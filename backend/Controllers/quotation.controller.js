import pool from "../Utils/db.js";
import { v4 as uuidv4 } from "uuid";

/**
 * Create Quotation From Enquiry
 */
export const createQuotationFromEnquiry = async (req, res) => {
  const { enquiryId } = req.params;

  try {
    // 1️⃣ Validate enquiry
    const enquiryRes = await pool.query(
      `SELECT * FROM public.inquiry WHERE id = $1`,
      [enquiryId]
    );

    if (!enquiryRes.rows.length) {
      return res.status(404).json({ message: "Enquiry not found" });
    }

    // 2️⃣ Create quotation
    const quotationRes = await pool.query(
      `
      INSERT INTO erp.quotation
      (id, inquiry_id, quotation_no, "createdAt", "updatedAt")
      VALUES ($1, $2, $3, NOW(), NOW())
      RETURNING *
      `,
      [
        uuidv4(),
        enquiryId,
        `QT-${Date.now()}`
      ]
    );

    res.status(201).json({
      message: "Quotation created successfully",
      quotation: quotationRes.rows[0]
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Add Quotation Item
 */
export const addQuotationItem = async (req, res) => {
  const { quotation_id, product_id, rate, quantity } = req.body;

  try {
    const result = await pool.query(
      `
      INSERT INTO erp.quotation_items
      (id, quotation_id, product_id, rate, quantity)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *
      `,
      [
        uuidv4(),
        quotation_id,
        product_id,
        rate,
        quantity
      ]
    );

    res.status(201).json({
      message: "Quotation item added",
      item: result.rows[0]
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Get All Quotations
 */
export const getAllQuotations = async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 
        q.id,
        q.quotation_no,
        q.status,
        q."createdAt",
        e.inquiry_no,
        c.name AS customer_name
      FROM erp.quotation q
      JOIN public.inquiry e ON q.inquiry_id = e.id
      JOIN public.customers c ON e.customer_id = c.id
      ORDER BY q."createdAt" DESC
    `);

    res.json(result.rows);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Get Quotation By ID
 */
export const getQuotationById = async (req, res) => {
  const { id } = req.params;

  try {
    const quotationRes = await pool.query(
      `SELECT * FROM erp.quotation WHERE id = $1`,
      [id]
    );

    if (!quotationRes.rows.length) {
      return res.status(404).json({ message: "Quotation not found" });
    }

    const itemsRes = await pool.query(
      `
      SELECT 
        qi.id,
        qi.rate,
        qi.quantity,
        p.name AS product_name
      FROM erp.quotation_items qi
      JOIN erp.products p ON qi.product_id = p.id
      WHERE qi.quotation_id = $1
      `,
      [id]
    );

    res.json({
      quotation: quotationRes.rows[0],
      items: itemsRes.rows
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Update Quotation Status
 */
export const updateQuotationStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  try {
    const result = await pool.query(
      `
      UPDATE erp.quotation
      SET status = $1, "updatedAt" = NOW()
      WHERE id = $2
      RETURNING *
      `,
      [status, id]
    );

    res.json({
      message: "Quotation status updated",
      quotation: result.rows[0]
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Delete Quotation (Hard Delete – Schema has no soft delete)
 */
export const deleteQuotation = async (req, res) => {
  const { id } = req.params;

  try {
    await pool.query(
      `DELETE FROM erp.quotation WHERE id = $1`,
      [id]
    );

    res.json({ message: "Quotation deleted successfully" });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
