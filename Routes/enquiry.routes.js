import express from "express";
import {
  createEnquiry,
  addEnquiryItem,
  getAllEnquiries,
  getEnquiryById,
  updateEnquiryStatus,
  deleteEnquiry,
} from "../Controllers/enquiry.controller.js";

const router = express.Router();

router.post("/", createEnquiry);
router.post("/item", addEnquiryItem);
router.get("/", getAllEnquiries);
router.get("/:id", getEnquiryById);
router.put("/:id/status", updateEnquiryStatus);
router.delete("/:id", deleteEnquiry);

export default router;
