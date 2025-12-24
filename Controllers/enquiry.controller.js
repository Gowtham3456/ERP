import pool from "../Utils/db.js";

/**
 * Create Enquiry
 */
export const createEnquiry = async (req, res) => {
  const { customer_id, created_by } = req.body;

  try {
    const result = await pool.query(
      `INSERT INTO enquiry (customer_id, created_by)
       VALUES ($1, $2)
       RETURNING *`,
      [customer_id, created_by]
    );

    res.status(201).json({
      message: "Enquiry created successfully",
      enquiry: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Add Enquiry Item
 */
export const addEnquiryItem = async (req, res) => {
  const {
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
  } = req.body;

  try {
    const total_price =
      uom === "QTY"
        ? qty * unit_price
        : weight * unit_price;

    const result = await pool.query(
      `INSERT INTO enquiry_items
      (enquiry_id, item_name, width, thickness, length, density,
       pricing_source, uom, qty, weight, unit_price, total_price)
      VALUES
      ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)
      RETURNING *`,
      [
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
      ]
    );

    res.status(201).json({
      message: "Enquiry item added",
      item: result.rows[0],
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Get All Enquiries
 */
export const getAllEnquiries = async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT e.enquiry_id, e.enquiry_status, e.created_at,
             c.customer_name, u.full_name AS created_by
      FROM enquiry e
      LEFT JOIN customers c ON e.customer_id = c.customer_id
      LEFT JOIN users u ON e.created_by = u.user_id
      ORDER BY e.created_at DESC
    `);

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Get Enquiry By ID (with items)
 */
export const getEnquiryById = async (req, res) => {
  const { id } = req.params;

  try {
    const enquiry = await pool.query(
      `SELECT * FROM enquiry WHERE enquiry_id=$1`,
      [id]
    );

    if (enquiry.rows.length === 0) {
      return res.status(404).json({ message: "Enquiry not found" });
    }

    const items = await pool.query(
      `SELECT * FROM enquiry_items WHERE enquiry_id=$1`,
      [id]
    );

    res.json({
      enquiry: enquiry.rows[0],
      items: items.rows,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * Update Enquiry Status
 */
export const updateEnquiryStatus = async (req, res) => {
  const { id } = req.params;
  const { enquiry_status } = req.body;

  try {
    const result = await pool.query(
      `UPDATE enquiry
       SET enquiry_status=$1
       WHERE enquiry_id=$2
       RETURNING *`,
      [enquiry_status, id]
    );

    res.json({
      message: "Enquiry status updated",
      enquiry: result.rows[0],
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
      `DELETE FROM enquiry WHERE enquiry_id=$1`,
      [id]
    );

    res.json({ message: "Enquiry deleted successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
