import pool from "../Utils/db.js";
import { v4 as uuidv4 } from "uuid";

/**
 * =====================================================
 * CREATE ENQUIRY (HEADER + ITEMS)
 * =====================================================
 */
export const createEnquiry = async (req, res) => {
  const {
    company_id,
    branch_id,
    inquiry_type,
    customer_id,
    remarks,
    items
  } = req.body;

  const userId = req.user.user_id;
  const inquiryId = uuidv4();
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // 1️⃣ Create enquiry header
    await client.query(
      `
      INSERT INTO erp.inquiries (
        id,
        company_id,
        branch_id,
        inquiry_number,
        inquiry_date,
        customer_id,
        inquiry_type,
        status,
        remarks,
        created_by,
        created_at,
        modified_by,
        modified_at
      )
      VALUES (
        $1,$2,$3,$4,CURRENT_DATE,$5,$6,'DRAFT',$7,$8,NOW(),$8,NOW()
      )
      `,
      [
        inquiryId,
        company_id,
        branch_id,
        `INQ-${new Date().getFullYear()}-${Date.now()}`,
        customer_id || null,
        inquiry_type,
        remarks || null,
        userId
      ]
    );

    // 2️⃣ Insert enquiry items (PRN → Material mapping)
    for (const item of items) {
      const {
        prn_id,
        description,
        dimension_length,
        dimension_width,
        dimension_height,
        quantity,
        unit_id,
        weight,
        expected_price
      } = item;

      // 🔹 Fetch PRN and mapped material
      const prnMaterialRes = await client.query(
        `
        SELECT
          p.id AS prn_id,
          m.id AS material_id
        FROM erp.prns p
        JOIN erp.materials m
          ON p.prn_number LIKE '%' || m.material_code || '%'
        WHERE p.id = $1
        `,
        [prn_id]
      );

      if (!prnMaterialRes.rows.length) {
        throw new Error("PRN not found or material mapping failed");
      }

      const materialId = prnMaterialRes.rows[0].material_id;

      // 🔹 Validate unit
      const unitRes = await client.query(
        `SELECT id FROM erp.units WHERE id = $1`,
        [unit_id]
      );
      if (!unitRes.rows.length) {
        throw new Error("Invalid unit");
      }

      // 🔹 Insert inquiry item
      await client.query(
        `
        INSERT INTO erp.inquiry_items (
          id,
          inquiry_id,
          material_id,
          description,
          dimension_length,
          dimension_width,
          dimension_height,
          quantity,
          unit_id,
          weight,
          expected_price
        )
        VALUES (
          $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11
        )
        `,
        [
          uuidv4(),
          inquiryId,
          materialId, // ✅ derived from PRN
          description || null,
          dimension_length || null,
          dimension_width || null,
          dimension_height || null,
          quantity,
          unit_id,
          weight || null,
          expected_price || null
        ]
      );
    }

    await client.query("COMMIT");

    res.status(201).json({
      message: "Enquiry created successfully",
      inquiry_id: inquiryId
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
 * GET ALL ENQUIRIES
 * =====================================================
 */
export const getAllEnquiries = async (req, res) => {
  try {
    const result = await pool.query(
      `
      SELECT
        i.id,
        i.inquiry_number,
        i.inquiry_date,
        i.inquiry_type,
        i.status,
        i.remarks,
        u.name AS created_by
      FROM erp.inquiries i
      JOIN auth.users u ON i.created_by = u.id
      ORDER BY i.created_at DESC
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
      `SELECT * FROM erp.inquiries WHERE id = $1`,
      [id]
    );

    if (!enquiryRes.rows.length) {
      return res.status(404).json({ message: "Enquiry not found" });
    }

    const itemsRes = await pool.query(
      `
      SELECT
        ii.*,
        m.material_name,
        u.unit_code
      FROM erp.inquiry_items ii
      JOIN erp.materials m ON ii.material_id = m.id
      JOIN erp.units u ON ii.unit_id = u.id
      WHERE ii.inquiry_id = $1
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
      UPDATE erp.inquiries
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
      message: "Enquiry status updated",
      enquiry: result.rows[0]
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * =====================================================
 * UPDATE ENQUIRY HEADER
 * =====================================================
 */
export const updateEnquiry = async (req, res) => {
  const { id } = req.params;
  const { customer_id, remarks } = req.body;
  const userId = req.user.user_id;

  try {
    const result = await pool.query(
      `
      UPDATE erp.inquiries
      SET
        customer_id = COALESCE($1, customer_id),
        remarks = COALESCE($2, remarks),
        modified_by = $3,
        modified_at = NOW()
      WHERE id = $4
      RETURNING *
      `,
      [customer_id || null, remarks || null, userId, id]
    );

    res.json({
      message: "Enquiry updated successfully",
      enquiry: result.rows[0]
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * =====================================================
 * UPDATE ENQUIRY ITEM
 * =====================================================
 */
export const updateEnquiryItem = async (req, res) => {
  const { itemId } = req.params;

  const {
    description,
    dimension_length,
    dimension_width,
    dimension_height,
    quantity,
    unit_id,
    weight,
    expected_price
  } = req.body;

  try {
    const result = await pool.query(
      `
      UPDATE erp.inquiry_items
      SET
        description = COALESCE($1, description),
        dimension_length = COALESCE($2, dimension_length),
        dimension_width = COALESCE($3, dimension_width),
        dimension_height = COALESCE($4, dimension_height),
        quantity = COALESCE($5, quantity),
        unit_id = COALESCE($6, unit_id),
        weight = COALESCE($7, weight),
        expected_price = COALESCE($8, expected_price)
      WHERE id = $9
      RETURNING *
      `,
      [
        description || null,
        dimension_length || null,
        dimension_width || null,
        dimension_height || null,
        quantity || null,
        unit_id || null,
        weight || null,
        expected_price || null,
        itemId
      ]
    );

    res.json({
      message: "Enquiry item updated successfully",
      item: result.rows[0]
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
      `DELETE FROM erp.inquiry_items WHERE inquiry_id = $1`,
      [id]
    );

    await client.query(
      `DELETE FROM erp.inquiries WHERE id = $1`,
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
