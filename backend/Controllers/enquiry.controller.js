import pool from "../Utils/db.js";
import { v4 as uuidv4 } from "uuid";

/**
 * Create Enquiry
 * company_id === customer_id
 */
export const createEnquiry = async (req, res) => {
  const {
    supplier_id,   // 🔴 company
    customer_id,   // 🔵 buyer
    product_id,
    quantity,
    expected_date,
    source,
    notes
  } = req.body;

  const userId = req.user.user_id;

  try {
    // 1️⃣ Validate supplier (company)
    const supplierRes = await pool.query(
      `SELECT id FROM erp.suppliers WHERE id = $1`,
      [supplier_id]
    );

    if (!supplierRes.rows.length) {
      return res.status(400).json({ message: "Invalid supplier/company" });
    }

    // 2️⃣ Validate customer
    const customerRes = await pool.query(
      `SELECT id FROM public.customers WHERE id = $1`,
      [customer_id]
    );

    if (!customerRes.rows.length) {
      return res.status(400).json({ message: "Invalid customer" });
    }

    // 3️⃣ Create enquiry
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
        $3,      -- company_id = supplier_id
        $4,      -- customer_id
        $5,
        $6,
        $7,
        $8,
        'NEW',
        $9,
        $10,
        NOW(),
        $10,
        NOW()
      )
      RETURNING *
      `,
      [
        uuidv4(),
        `INQ-${new Date().getFullYear()}-${Date.now()}`,
        supplier_id,
        customer_id,
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

        s.name AS supplier_name,
        c.name AS customer_name,
        p.name AS product_name,
        u.name AS created_by

      FROM public.inquiry e
      JOIN erp.suppliers s ON e.company_id = s.id
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
        s.name AS supplier_name,
        c.name AS customer_name,
        p.name AS product_name
      FROM public.inquiry e
      JOIN erp.suppliers s ON e.company_id = s.id
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
