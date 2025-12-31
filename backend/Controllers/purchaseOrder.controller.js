import pool from "../Utils/db.js";
import { v4 as uuidv4 } from "uuid";

/**
 * =====================================================
 * CREATE PURCHASE ORDER FROM APPROVED QUOTATION
 * =====================================================
 */
export const createPOFromQuotation = async (req, res) => {
  const { quotationId } = req.params;
  const { remarks } = req.body;

  const userId = req.user.user_id;
  const poId = uuidv4();

  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // 1️⃣ Fetch quotation
    const quotationRes = await client.query(
      `
      SELECT *
      FROM erp.quotation
      WHERE id = $1
      `,
      [quotationId]
    );

    if (!quotationRes.rows.length) {
      throw new Error("Quotation not found");
    }

    const quotation = quotationRes.rows[0];

    // 2️⃣ Validate quotation status
    if (quotation.status !== "APPROVED") {
      throw new Error("Purchase Order can be created only from APPROVED quotation");
    }

    // 3️⃣ Fetch quotation items
    const itemsRes = await client.query(
      `
      SELECT *
      FROM erp.quotation_items
      WHERE quotation_id = $1
      `,
      [quotationId]
    );

    if (!itemsRes.rows.length) {
      throw new Error("No quotation items found");
    }

    // 4️⃣ Create PO header
    await client.query(
      `
      INSERT INTO erp.purchase_orders (
        id,
        document_number,
        quotation_id,
        customer_id,
        po_date,
        status,
        remarks,
        created_by,
        created_at
      )
      VALUES ($1,$2,$3,$4,CURRENT_DATE,'DRAFT',$5,$6,NOW())
      `,
      [
        poId,
        `PO-${new Date().getFullYear()}-${Date.now()}`,
        quotation.id,
        quotation.customer_id,
        remarks || null,
        userId
      ]
    );

    // 5️⃣ Copy quotation items → PO lines
    for (const item of itemsRes.rows) {
      await client.query(
        `
        INSERT INTO erp.purchase_order_lines (
          id,
          po_id,
          material_name,
          quantity,
          unit_price,
          line_total,
          remarks
        )
        VALUES ($1,$2,$3,$4,$5,$6,$7)
        `,
        [
          uuidv4(),
          poId,
          item.product_id || item.material_name,
          item.quantity,
          item.rate,
          item.quantity * item.rate,
          "Generated from quotation"
        ]
      );
    }

    await client.query("COMMIT");

    res.status(201).json({
      message: "Purchase Order created from quotation successfully",
      po_id: poId
    });

  } catch (err) {
    await client.query("ROLLBACK");
    res.status(400).json({ error: err.message });
  } finally {
    client.release();
  }
};
