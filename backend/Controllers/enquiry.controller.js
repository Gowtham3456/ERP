import pool from "../Utils/db.js";
import { v4 as uuidv4 } from "uuid";

/**
 * Create Enquiry
 * company_id === customer_id
 */
export const createEnquiry = async (req, res) => {
  const {
    customer_id,
    product_id,
    quantity,
    expected_date,
    source,
    notes
  } = req.body;

  const userId = req.user.user_id;

  try {
    // Validate customer (company)
    const customerRes = await pool.query(
      `SELECT id FROM public.customers WHERE id = $1`,
      [customer_id]
    );

    if (!customerRes.rows.length) {
      return res.status(400).json({ message: "Invalid customer/company" });
    }

    const result = await pool.query(
      `
      INSERT INTO public.inquiry (
        id,
        inquiry_no,
        inquiry_date,
        company_id,
        customer_id,
        product_id,
        quantity,
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
        $3,
        $4,
        $5,
        $6,
        $7,
        'NEW',
        $8,
        $9,
        NOW(),
        $9,
        NOW()
      )
      RETURNING *
      `,
      [
        uuidv4(),
        `INQ-${new Date().getFullYear()}-${Date.now()}`,
        customer_id,   // company_id = customer_id
        product_id,
        quantity,
        expected_date || null,
        source || "WEB",
        notes || null,
        userId
      ]
    );

    res.status(201).json({
      message: "Enquiry created successfully",
      enquiry: result.rows[0]
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Get All Enquiries (company scoped)
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
        e.quantity,
        e.expected_date,
        e.source,
        c.name AS customer_name,
        p.name AS product_name,
        u.name AS created_by
      FROM public.inquiry e
      JOIN public.customers c ON e.customer_id = c.id
      JOIN erp.products p ON e.product_id = p.id
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
 * Get Enquiry By ID
 */
export const getEnquiryById = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query(
      `
      SELECT
        e.*,
        c.name AS customer_name,
        p.name AS product_name
      FROM public.inquiry e
      JOIN public.customers c ON e.customer_id = c.id
      JOIN erp.products p ON e.product_id = p.id
      WHERE e.id = $1
      `,
      [id]
    );

    if (!result.rows.length) {
      return res.status(404).json({ message: "Enquiry not found" });
    }

    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Update Enquiry Status
 */
export const updateEnquiryStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;
  const userId = req.user.user_id;

  try {
    const result = await pool.query(
      `
      UPDATE public.inquiry
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
 * Delete Enquiry
 */
export const deleteEnquiry = async (req, res) => {
  const { id } = req.params;

  try {
    await pool.query(
      `DELETE FROM public.inquiry WHERE id = $1`,
      [id]
    );

    res.json({ message: "Enquiry deleted successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
