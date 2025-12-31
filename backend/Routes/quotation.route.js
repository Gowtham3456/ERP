import express from "express";
import {
  createQuotation,
  getAllQuotations,
  getQuotationById,
  updateQuotationStatus
} from "../Controllers/quotation.controller.js";

import {
  authenticateJWT,
  authorizeRoles
} from "../Utils/auth.middleware.js";

const router = express.Router();

// Create quotation from enquiry
router.post(
  "/",
  authenticateJWT,
  authorizeRoles("ADMIN", "STAFF"),
  createQuotation
);

// Get all quotations
router.get("/", authenticateJWT, getAllQuotations);

// Get quotation by ID
router.get("/:id", authenticateJWT, getQuotationById);

// Update quotation status (approval)
router.put(
  "/:id/status",
  authenticateJWT,
  authorizeRoles("ADMIN"),
  updateQuotationStatus
);

export default router;
