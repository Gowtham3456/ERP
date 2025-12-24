// import pool from "../Utils/db.js";

// /**
//  * ==============================
//  * CREATE QUOTATION FROM ENQUIRY
//  * ==============================
//  */
// export const createQuotationFromEnquiry = async (req, res) => {
//   const { enquiryId } = req.params;
//   const { quotation_number, quotation_date, created_by } = req.body;

//   try {
//     // 1. Validate enquiry
//     const enquiryRes = await pool.query(
//       `SELECT * FROM enquiry WHERE enquiry_id=$1`,
//       [enquiryId]
//     );

//     if (!enquiryRes.rows.length) {
//       return res.status(404).json({ message: "Enquiry not found" });
//     }

//     const enquiry = enquiryRes.rows[0];

//     // 2. Create quotation header
//     const quotationRes = await pool.query(
//       `INSERT INTO quotations
//        (quotation_number, enquiry_id, customer_id, quotation_date, created_by)
//        VALUES ($1,$2,$3,$4,$5)
//        RETURNING *`,
//       [
//         quotation_number,
//         enquiryId,
//         enquiry.customer_id,
//         quotation_date,
//         created_by
//       ]
//     );

//     const quotationId = quotationRes.rows[0].quotation_id;

//     // 3. Copy enquiry items → quotation items
//     const itemsRes = await pool.query(
//       `SELECT * FROM enquiry_items WHERE enquiry_id=$1`,
//       [enquiryId]
//     );

//     let totalBeforeTax = 0;

//     for (const item of itemsRes.rows) {
//       const quantity =
//         item.uom === "QTY" ? item.qty : item.weight;

//       const taxableAmount = quantity * item.unit_price;

//       totalBeforeTax += taxableAmount;

//       await pool.query(
//         `INSERT INTO quotation_items
//          (quotation_id, item_description, uom, quantity, unit_price,
//           taxable_amount, line_total)
//          VALUES ($1,$2,$3,$4,$5,$6,$6)`,
//         [
//           quotationId,
//           item.item_name,
//           item.uom,
//           quantity,
//           item.unit_price,
//           taxableAmount
//         ]
//       );
//     }

//     // 4. Update quotation totals
//     await pool.query(
//       `UPDATE quotations
//        SET total_before_tax=$1,
//            net_amount=$1
//        WHERE quotation_id=$2`,
//       [totalBeforeTax, quotationId]
//     );

//     // 5. Update enquiry status
//     await pool.query(
//       `UPDATE enquiry SET enquiry_status='QUOTED' WHERE enquiry_id=$1`,
//       [enquiryId]
//     );

//     res.status(201).json({
//       message: "Quotation created successfully from enquiry",
//       quotation: quotationRes.rows[0]
//     });
//     console.log("Quotation Number:", quotation_number);
// console.log("Calculated Revision:", revisionNo);

//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// };

// /**
//  * ==============================
//  * ADD QUOTATION ITEM
//  * ==============================
//  */
// export const addQuotationItem = async (req, res) => {
//   const {
//     quotation_id,
//     item_description,
//     uom,
//     quantity,
//     unit_price,
//     discount_percent = 0,
//     cgst_percent = 0,
//     sgst_percent = 0,
//     igst_percent = 0
//   } = req.body;

//   try {
//     // 1. Block modification after approval
//     const statusRes = await pool.query(
//       `SELECT status FROM quotations WHERE quotation_id=$1`,
//       [quotation_id]
//     );

//     if (statusRes.rows[0].status === "APPROVED") {
//       return res.status(400).json({
//         message: "Approved quotation cannot be modified"
//       });
//     }

//     // 2. Price calculation
//     const baseAmount = quantity * unit_price;
//     const discountAmount = (baseAmount * discount_percent) / 100;
//     const taxableAmount = baseAmount - discountAmount;

//     const cgstAmount = (taxableAmount * cgst_percent) / 100;
//     const sgstAmount = (taxableAmount * sgst_percent) / 100;
//     const igstAmount = (taxableAmount * igst_percent) / 100;

//     const lineTotal =
//       taxableAmount + cgstAmount + sgstAmount + igstAmount;

//     // 3. Insert item
//     const itemRes = await pool.query(
//       `INSERT INTO quotation_items
//        (quotation_id, item_description, uom, quantity, unit_price,
//         discount_percent, taxable_amount,
//         cgst_percent, sgst_percent, igst_percent,
//         cgst_amount, sgst_amount, igst_amount,
//         line_total)
//        VALUES
//        ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)
//        RETURNING *`,
//       [
//         quotation_id,
//         item_description,
//         uom,
//         quantity,
//         unit_price,
//         discount_percent,
//         taxableAmount,
//         cgst_percent,
//         sgst_percent,
//         igst_percent,
//         cgstAmount,
//         sgstAmount,
//         igstAmount,
//         lineTotal
//       ]
//     );

//     // 4. Update quotation totals
//     await pool.query(
//       `UPDATE quotations
//        SET total_before_tax = total_before_tax + $1,
//            cgst_amount = cgst_amount + $2,
//            sgst_amount = sgst_amount + $3,
//            igst_amount = igst_amount + $4,
//            net_amount = net_amount + $5
//        WHERE quotation_id=$6`,
//       [
//         taxableAmount,
//         cgstAmount,
//         sgstAmount,
//         igstAmount,
//         lineTotal,
//         quotation_id
//       ]
//     );

//     res.status(201).json({
//       message: "Quotation item added",
//       item: itemRes.rows[0]
//     });

//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// };

// /**
//  * ==============================
//  * GET ALL QUOTATIONS
//  * ==============================
//  */
// export const getAllQuotations = async (req, res) => {
//   try {
//     const result = await pool.query(`
//       SELECT q.quotation_id, q.quotation_number, q.revision_no,
//              q.status, q.net_amount, q.created_at,
//              c.customer_name,
//              u.full_name AS created_by
//       FROM quotations q
//       LEFT JOIN customers c ON q.customer_id = c.customer_id
//       LEFT JOIN users u ON q.created_by = u.user_id
//       WHERE q.is_deleted = false
//       ORDER BY q.created_at DESC
//     `);

//     res.json(result.rows);
//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// };

// /**
//  * ==============================
//  * GET QUOTATION BY ID
//  * ==============================
//  */
// export const getQuotationById = async (req, res) => {
//   const { id } = req.params;

//   try {
//     const quotationRes = await pool.query(
//       `SELECT * FROM quotations WHERE quotation_id=$1 AND is_deleted=false`,
//       [id]
//     );

//     if (!quotationRes.rows.length) {
//       return res.status(404).json({ message: "Quotation not found" });
//     }

//     const itemsRes = await pool.query(
//       `SELECT * FROM quotation_items WHERE quotation_id=$1`,
//       [id]
//     );

//     res.json({
//       quotation: quotationRes.rows[0],
//       items: itemsRes.rows
//     });

//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// };

// /**
//  * ==============================
//  * UPDATE QUOTATION STATUS
//  * ==============================
//  */
// export const updateQuotationStatus = async (req, res) => {
//   const { id } = req.params;
//   const { status } = req.body;

//   try {
//     const result = await pool.query(
//       `UPDATE quotations
//        SET status=$1, updated_at=NOW()
//        WHERE quotation_id=$2
//        RETURNING *`,
//       [status, id]
//     );

//     res.json({
//       message: "Quotation status updated",
//       quotation: result.rows[0]
//     });

//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// };

// /**
//  * ==============================
//  * APPROVE QUOTATION
//  * ==============================
//  */
// export const approveQuotation = async (req, res) => {
//   const { id } = req.params;
//   const { approved_by } = req.body;

//   try {
//     const result = await pool.query(
//       `UPDATE quotations
//        SET status='APPROVED',
//            approved_by=$1,
//            approved_at=NOW()
//        WHERE quotation_id=$2
//        RETURNING *`,
//       [approved_by, id]
//     );

//     res.json({
//       message: "Quotation approved",
//       quotation: result.rows[0]
//     });

//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// };

// /**
//  * ==============================
//  * SOFT DELETE QUOTATION
//  * ==============================
//  */
// export const deleteQuotation = async (req, res) => {
//   const { id } = req.params;

//   try {
//     await pool.query(
//       `UPDATE quotations SET is_deleted=true WHERE quotation_id=$1`,
//       [id]
//     );

//     res.json({ message: "Quotation deleted safely" });

//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// };
import pool from "../Utils/db.js";

/**
 * ==================================================
 * CREATE QUOTATION FROM ENQUIRY (WITH REVISION LOGIC)
 * ==================================================
 */
export const createQuotationFromEnquiry = async (req, res) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const { enquiryId } = req.params;
    const { quotation_number, quotation_date, created_by } = req.body;

    /* 1️⃣ Validate enquiry */
    const enquiryRes = await client.query(
      `SELECT * FROM enquiry WHERE enquiry_id=$1`,
      [enquiryId]
    );

    if (enquiryRes.rows.length === 0) {
      throw new Error("Enquiry not found");
    }

    const enquiry = enquiryRes.rows[0];

    /* 2️⃣ Get next revision */
    const revisionRes = await client.query(
      `SELECT COALESCE(MAX(revision_no),0)+1 AS next_revision
       FROM quotations WHERE quotation_number=$1`,
      [quotation_number]
    );

    const revisionNo = revisionRes.rows[0].next_revision;

    /* 3️⃣ Insert quotation */
    const quotationRes = await client.query(
      `INSERT INTO quotations
       (quotation_number, revision_no, enquiry_id, customer_id,
        quotation_date, created_by)
       VALUES ($1,$2,$3,$4,$5,$6)
       RETURNING quotation_id`,
      [
        quotation_number,
        revisionNo,
        enquiryId,
        enquiry.customer_id,
        quotation_date,
        created_by
      ]
    );

    const quotationId = quotationRes.rows[0].quotation_id;

    /* 4️⃣ Copy enquiry items */
    const itemsRes = await client.query(
      `SELECT * FROM enquiry_items WHERE enquiry_id=$1`,
      [enquiryId]
    );

    if (itemsRes.rows.length === 0) {
      throw new Error("No enquiry items found");
    }

    let totalBeforeTax = 0;

    for (const item of itemsRes.rows) {
      let quantity;

      if (item.uom === "QTY") quantity = item.qty;
      else if (item.uom === "WEIGHTS") quantity = item.weight;
      else throw new Error(`Invalid UOM ${item.uom}`);

      const taxableAmount = quantity * item.unit_price;
      totalBeforeTax += taxableAmount;

      await client.query(
        `INSERT INTO quotation_items
         (quotation_id, item_description, uom, quantity, unit_price,
          taxable_amount, line_total)
         VALUES ($1,$2,$3,$4,$5,$6,$6)`,
        [
          quotationId,
          item.item_name,
          item.uom,
          quantity,
          item.unit_price,
          taxableAmount
        ]
      );
    }

    /* 5️⃣ Update totals */
    await client.query(
      `UPDATE quotations
       SET total_before_tax=$1,
           net_amount=$1
       WHERE quotation_id=$2`,
      [totalBeforeTax, quotationId]
    );

    /* 6️⃣ Update enquiry status */
    await client.query(
      `UPDATE enquiry SET enquiry_status='QUOTED' WHERE enquiry_id=$1`,
      [enquiryId]
    );

    /* 🔥 7️⃣ FETCH UPDATED QUOTATION */
    const finalQuotationRes = await client.query(
      `SELECT * FROM quotations WHERE quotation_id=$1`,
      [quotationId]
    );

    await client.query("COMMIT");

    res.status(201).json({
      message: "Quotation created successfully from enquiry",
      quotation: finalQuotationRes.rows[0]
    });

  } catch (err) {
    await client.query("ROLLBACK");
    res.status(500).json({ error: err.message });
  } finally {
    client.release();
  }
};


/**
 * ==============================
 * ADD QUOTATION ITEM
 * ==============================
 */
export const addQuotationItem = async (req, res) => {
  const {
    quotation_id,
    item_description,
    uom,
    quantity,
    unit_price,
    discount_percent = 0,
    cgst_percent = 0,
    sgst_percent = 0,
    igst_percent = 0
  } = req.body;

  try {
    /* Block edit after approval */
    const statusRes = await pool.query(
      `SELECT status FROM quotations WHERE quotation_id = $1`,
      [quotation_id]
    );

    if (statusRes.rows[0].status === "APPROVED") {
      return res.status(400).json({
        message: "Approved quotation cannot be modified"
      });
    }

    const baseAmount = quantity * unit_price;
    const discountAmount = (baseAmount * discount_percent) / 100;
    const taxableAmount = baseAmount - discountAmount;

    const cgstAmount = (taxableAmount * cgst_percent) / 100;
    const sgstAmount = (taxableAmount * sgst_percent) / 100;
    const igstAmount = (taxableAmount * igst_percent) / 100;

    const lineTotal =
      taxableAmount + cgstAmount + sgstAmount + igstAmount;

    const itemRes = await pool.query(
      `INSERT INTO quotation_items
       (quotation_id, item_description, uom, quantity, unit_price,
        discount_percent, taxable_amount,
        cgst_percent, sgst_percent, igst_percent,
        cgst_amount, sgst_amount, igst_amount,
        line_total)
       VALUES
       ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)
       RETURNING *`,
      [
        quotation_id,
        item_description,
        uom,
        quantity,
        unit_price,
        discount_percent,
        taxableAmount,
        cgst_percent,
        sgst_percent,
        igst_percent,
        cgstAmount,
        sgstAmount,
        igstAmount,
        lineTotal
      ]
    );

    await pool.query(
      `UPDATE quotations
       SET total_before_tax = total_before_tax + $1,
           cgst_amount = cgst_amount + $2,
           sgst_amount = sgst_amount + $3,
           igst_amount = igst_amount + $4,
           net_amount = net_amount + $5
       WHERE quotation_id = $6`,
      [
        taxableAmount,
        cgstAmount,
        sgstAmount,
        igstAmount,
        lineTotal,
        quotation_id
      ]
    );

    res.status(201).json({
      message: "Quotation item added",
      item: itemRes.rows[0]
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * ==============================
 * GET ALL QUOTATIONS
 * ==============================
 */
export const getAllQuotations = async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT q.quotation_id, q.quotation_number, q.revision_no,
             q.status, q.net_amount, q.created_at,
             c.customer_name,
             u.full_name AS created_by
      FROM quotations q
      LEFT JOIN customers c ON q.customer_id = c.customer_id
      LEFT JOIN users u ON q.created_by = u.user_id
      WHERE q.is_deleted = false
      ORDER BY q.created_at DESC
    `);

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * ==============================
 * GET QUOTATION BY ID
 * ==============================
 */
export const getQuotationById = async (req, res) => {
  const { id } = req.params;

  try {
    const quotationRes = await pool.query(
      `SELECT * FROM quotations
       WHERE quotation_id = $1 AND is_deleted = false`,
      [id]
    );

    if (quotationRes.rows.length === 0) {
      return res.status(404).json({ message: "Quotation not found" });
    }

    const itemsRes = await pool.query(
      `SELECT * FROM quotation_items WHERE quotation_id = $1`,
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
 * ==============================
 * UPDATE QUOTATION STATUS
 * ==============================
 */
export const updateQuotationStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  try {
    const result = await pool.query(
      `UPDATE quotations
       SET status = $1, updated_at = NOW()
       WHERE quotation_id = $2
       RETURNING *`,
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
 * ==============================
 * APPROVE QUOTATION
 * ==============================
 */
export const approveQuotation = async (req, res) => {
  const { id } = req.params;
  const { approved_by } = req.body;

  try {
    const result = await pool.query(
      `UPDATE quotations
       SET status = 'APPROVED',
           approved_by = $1,
           approved_at = NOW()
       WHERE quotation_id = $2
       RETURNING *`,
      [approved_by, id]
    );

    res.json({
      message: "Quotation approved",
      quotation: result.rows[0]
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/**
 * ==============================
 * SOFT DELETE QUOTATION
 * ==============================
 */
export const deleteQuotation = async (req, res) => {
  const { id } = req.params;

  try {
    await pool.query(
      `UPDATE quotations
       SET is_deleted = true
       WHERE quotation_id = $1`,
      [id]
    );

    res.json({ message: "Quotation deleted safely" });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
