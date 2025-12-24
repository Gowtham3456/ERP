import express from "express";
import {
  createQuotationFromEnquiry,
  addQuotationItem,
  getAllQuotations,
  getQuotationById,
  updateQuotationStatus,
  approveQuotation,
  deleteQuotation
} from "../Controllers/quotation.controller.js";

const router = express.Router();

router.post("/from-enquiry/:enquiryId", createQuotationFromEnquiry);
router.post("/item", addQuotationItem);
router.get("/", getAllQuotations);
router.get("/:id", getQuotationById);
router.put("/:id/status", updateQuotationStatus);
router.put("/:id/approve", approveQuotation);
router.delete("/:id", deleteQuotation);

export default router;
