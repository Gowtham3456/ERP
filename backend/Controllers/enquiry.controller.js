import pool from "../Utils/db.js";
import { v4 as uuidv4 } from "uuid";

/**
 * =====================================================
 * CREATE ENQUIRY (HEADER + ITEMS)
 * =====================================================
 */
export const createEnquiry = async (req, res) => {
  const {
    supplier_id,      // company
    customer_id,      // buyer
    inquiry_items,    // array of items
    expected_date,
    source,
    notes
  } = req.body;

  const userId = req.user.user_id;
  const enquiryId = uuidv4();

  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // 1️⃣ Validate supplier
    const supplierRes = await client.query(
      `SELECT id FROM erp.suppliers WHERE id = $1`,
      [supplier_id]
    );
    if (!supplierRes.rows.length) {
      throw new Error("Invalid supplier/company");
    }

    // 2️⃣ Validate customer
    const customerRes = await client.query(
      `SELECT id FROM erp.customers WHERE id = $1`,
      [customer_id]
    );
    if (!customerRes.rows.length) {
      throw new Error("Invalid customer");
    }

    // 3️⃣ Create enquiry header
    await client.query(
      `
      INSERT INTO erp.inquiry (
        id,
        inquiry_no,
        inquiry_date,
        company_id,
        customer_id,
        expected_date,
        source,
        status,
        notes,
        created_by,
        created_at,
        modified_by,
        modified_at
      )
      VALUES (
        $1,
        $2,
        CURRENT_DATE,
        $3,
        $4,
        $5,
        $6,
        'NEW',
        $7,
        $8,
        NOW(),
        $8,
        NOW()
      )
      `,
      [
        enquiryId,
        `INQ-${new Date().getFullYear()}-${Date.now()}`,
        supplier_id,
        customer_id,
        expected_date || null,
        source || "WEB",
        notes || null,
        userId
      ]
    );

    // 4️⃣ Insert enquiry items
    for (const item of inquiry_items) {
      const {
        item_name,
        width,
        thickness,
        length,
        density,
        pricing_source,
        uom,
        qty,
        weight,
        unit_price,
        total_price
      } = item;

      await client.query(
        `
        INSERT INTO erp.inquiry_items (
          id,
          enquiry_id,
          item_name,
          width,
          thickness,
          length,
          density,
          pricing_source,
          uom,
          qty,
          weight,
          unit_price,
          total_price,
          created_at
        )
        VALUES (
          $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,NOW()
        )
        `,
        [
          uuidv4(),
          enquiryId,
          item_name,
          width,
          thickness,
          length,
          density,
          pricing_source,
          uom,
          qty,
          weight,
          unit_price,
          total_price
        ]
      );
    }

    await client.query("COMMIT");

    res.status(201).json({
      message: "Enquiry created successfully",
      enquiry_id: enquiryId
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
 * GET ALL ENQUIRIES (HEADER LIST)
 * =====================================================
 */
export const getAllEnquiries = async (req, res) => {
  try {
    const result = await pool.query(
      `
      SELECT
        e.id,
        e.inquiry_no,
        e.inquiry_date,
        e.status,
        e.source,
        s.name AS supplier_name,
        c.name AS customer_name,
        u.name AS created_by
      FROM erp.inquiry e
      JOIN erp.suppliers s ON e.company_id = s.id
      JOIN erp.customers c ON e.customer_id = c.id
      JOIN auth.users u ON e.created_by = u.id
      ORDER BY e.created_at DESC
      `
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * =====================================================
 * GET ENQUIRY BY ID (HEADER + ITEMS)
 * =====================================================
 */
export const getEnquiryById = async (req, res) => {
  const { id } = req.params;

  try {
    const enquiryRes = await pool.query(
      `
      SELECT
        e.*,
        s.name AS supplier_name,
        c.name AS customer_name
      FROM erp.inquiry e
      JOIN erp.suppliers s ON e.company_id = s.id
      JOIN erp.customers c ON e.customer_id = c.id
      WHERE e.id = $1
      `,
      [id]
    );

    if (!enquiryRes.rows.length) {
      return res.status(404).json({ message: "Enquiry not found" });
    }

    const itemsRes = await pool.query(
      `
      SELECT *
      FROM erp.inquiry_items
      WHERE enquiry_id = $1
      `,
      [id]
    );

    res.json({
      enquiry: enquiryRes.rows[0],
      items: itemsRes.rows
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * =====================================================
 * UPDATE ENQUIRY STATUS
 * =====================================================
 */
export const updateEnquiryStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;
  const userId = req.user.user_id;

  try {
    const result = await pool.query(
      `
      UPDATE erp.inquiry
      SET
        status = $1,
        modified_by = $2,
        modified_at = NOW()
      WHERE id = $3
      RETURNING *
      `,
      [status, userId, id]
    );

    res.json({
      message: "Enquiry status updated successfully",
      enquiry: result.rows[0]
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * =====================================================
 * DELETE ENQUIRY (HEADER + ITEMS)
 * =====================================================
 */
export const deleteEnquiry = async (req, res) => {
  const { id } = req.params;
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    await client.query(
      `DELETE FROM erp.inquiry_items WHERE enquiry_id = $1`,
      [id]
    );

    await client.query(
      `DELETE FROM erp.inquiry WHERE id = $1`,
      [id]
    );

    await client.query("COMMIT");

    res.json({ message: "Enquiry deleted successfully" });

  } catch (err) {
    await client.query("ROLLBACK");
    res.status(500).json({ error: err.message });
  } finally {
    client.release();
  }
};
