import express from "express";
import {
  createQuotationFromEnquiry,
  addQuotationItem,
  getAllQuotations,
  getQuotationById,
  updateQuotationStatus,
  deleteQuotation
} from "../Controllers/quotation.controller.js";

import {
  authenticateJWT,
  authorizeRoles
} from "../Utils/auth.middleware.js";

const router = express.Router();

router.post(
  "/from-enquiry/:enquiryId",
  authenticateJWT,
  authorizeRoles("ADMIN", "STAFF"),
  createQuotationFromEnquiry
);

router.post(
  "/item",
  authenticateJWT,
  authorizeRoles("ADMIN", "STAFF"),
  addQuotationItem
);

router.get("/", authenticateJWT, getAllQuotations);
router.get("/:id", authenticateJWT, getQuotationById);

router.put(
  "/:id/status",
  authenticateJWT,
  authorizeRoles("ADMIN"),
  updateQuotationStatus
);

router.delete(
  "/:id",
  authenticateJWT,
  authorizeRoles("ADMIN"),
  deleteQuotation
);

export default router;
