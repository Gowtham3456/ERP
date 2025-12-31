import pool from "../Utils/db.js";
import { v4 as uuidv4 } from "uuid";

/**
 * =====================================================
 * CREATE QUOTATION (FROM ENQUIRY)
 * =====================================================
 */
export const createQuotation = async (req, res) => {
  const {
    inquiry_id,
    quotation_items,
    validity_date
  } = req.body;

  const userId = req.user.user_id;
  const quotationId = uuidv4();

  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // 1️⃣ Validate enquiry
    const enquiryRes = await client.query(
      `SELECT * FROM erp.inquiry WHERE id = $1`,
      [inquiry_id]
    );

    if (!enquiryRes.rows.length) {
      throw new Error("Invalid enquiry");
    }

    const enquiry = enquiryRes.rows[0];

    // 2️⃣ Generate quotation number
    const quotationNo = `QT-${new Date().getFullYear()}-${Date.now()}`;

    // 3️⃣ Insert quotation header
    await client.query(
      `
      INSERT INTO erp.quotations (
        id,
        quotation_no,
        revision_no,
        inquiry_id,
        customer_id,
        quotation_date,
        validity_date,
        status,
        created_by,
        created_at,
        updated_at
      )
      VALUES (
        $1,$2,1,$3,$4,CURRENT_DATE,$5,'DRAFT',$6,NOW(),NOW()
      )
      `,
      [
        quotationId,
        quotationNo,
        inquiry_id,
        enquiry.customer_id,
        validity_date || null,
        userId
      ]
    );

    let totalBeforeTax = 0;
    let totalTax = 0;

    // 4️⃣ Insert quotation lines
    for (const item of quotation_items) {
      const {
        product_id,
        width,
        thickness,
        length,
        density,
        uom,
        quantity,
        weight,
        unit_price,
        discount_percent,
        cgst_percent,
        sgst_percent,
        igst_percent
      } = item;

      const taxableAmount =
        (quantity || 0) * unit_price * (1 - (discount_percent || 0) / 100);

      const cgstAmount = taxableAmount * (cgst_percent || 0) / 100;
      const sgstAmount = taxableAmount * (sgst_percent || 0) / 100;
      const igstAmount = taxableAmount * (igst_percent || 0) / 100;

      const lineTotal =
        taxableAmount + cgstAmount + sgstAmount + igstAmount;

      totalBeforeTax += taxableAmount;
      totalTax += cgstAmount + sgstAmount + igstAmount;

      await client.query(
        `
        INSERT INTO erp.quotation_lines (
          id,
          quotation_id,
          product_id,
          width,
          thickness,
          length,
          density,
          uom,
          quantity,
          weight,
          unit_price,
          discount_percent,
          taxable_amount,
          cgst_percent,
          sgst_percent,
          igst_percent,
          cgst_amount,
          sgst_amount,
          igst_amount,
          line_total,
          created_at
        )
        VALUES (
          $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,
          $11,$12,$13,$14,$15,$16,$17,$18,$19,$20,NOW()
        )
        `,
        [
          uuidv4(),
          quotationId,
          product_id,
          width || null,
          thickness || null,
          length || null,
          density || null,
          uom || null,
          quantity || 0,
          weight || 0,
          unit_price,
          discount_percent || 0,
          taxableAmount,
          cgst_percent || 0,
          sgst_percent || 0,
          igst_percent || 0,
          cgstAmount,
          sgstAmount,
          igstAmount,
          lineTotal
        ]
      );
    }

    // 5️⃣ Update quotation totals
    await client.query(
      `
      UPDATE erp.quotations
      SET
        total_before_tax = $1,
        total_tax_amount = $2,
        net_amount = $3,
        updated_at = NOW()
      WHERE id = $4
      `,
      [
        totalBeforeTax,
        totalTax,
        totalBeforeTax + totalTax,
        quotationId
      ]
    );

    await client.query("COMMIT");

    res.status(201).json({
      message: "Quotation created successfully",
      quotation_id: quotationId
    });

  } catch (err) {
    await client.query("ROLLBACK");
    res.status(500).json({ error: err.message });
  } finally {
    client.release();
  }
};

/**
 * =====================================================
 * GET ALL QUOTATIONS
 * =====================================================
 */
export const getAllQuotations = async (req, res) => {
  try {
    const result = await pool.query(
      `
      SELECT
        q.id,
        q.quotation_no,
        q.quotation_date,
        q.status,
        q.net_amount,
        c.name AS customer_name,
        u.name AS created_by
      FROM erp.quotations q
      JOIN erp.customers c ON q.customer_id = c.id
      JOIN auth.users u ON q.created_by = u.id
      ORDER BY q.created_at DESC
      `
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * =====================================================
 * GET QUOTATION BY ID
 * =====================================================
 */
export const getQuotationById = async (req, res) => {
  const { id } = req.params;

  try {
    const headerRes = await pool.query(
      `
      SELECT q.*, c.name AS customer_name
      FROM erp.quotations q
      JOIN erp.customers c ON q.customer_id = c.id
      WHERE q.id = $1
      `,
      [id]
    );

    if (!headerRes.rows.length) {
      return res.status(404).json({ message: "Quotation not found" });
    }

    const linesRes = await pool.query(
      `
      SELECT
        ql.*,
        p.name AS product_name
      FROM erp.quotation_lines ql
      JOIN erp.products p ON ql.product_id = p.id
      WHERE ql.quotation_id = $1
      `,
      [id]
    );

    res.json({
      quotation: headerRes.rows[0],
      items: linesRes.rows
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * =====================================================
 * UPDATE QUOTATION STATUS
 * =====================================================
 */
export const updateQuotationStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;
  const userId = req.user.user_id;

  try {
    const result = await pool.query(
      `
      UPDATE erp.quotations
      SET
        status = $1,
        approved_by = $2,
        approved_at = NOW(),
        updated_at = NOW()
      WHERE id = $3
      RETURNING *
      `,
      [status, userId, id]
    );

    res.json({
      message: "Quotation status updated successfully",
      quotation: result.rows[0]
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
