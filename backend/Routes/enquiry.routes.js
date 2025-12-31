import express from "express";
import {
  createEnquiry,
  getAllEnquiries,
  getEnquiryById,
  updateEnquiryStatus,
  deleteEnquiry,
  updateEnquiry,
  updateEnquiryItem
} from "../Controllers/enquiry.controller.js";

import {
  authenticateJWT,
  authorizeRoles
} from "../Utils/auth.middleware.js";

const router = express.Router();

router.post(
  "/",
  authenticateJWT,
  authorizeRoles("ADMIN", "STAFF"),
  createEnquiry
);

router.get("/", authenticateJWT, getAllEnquiries);
router.get("/:id", authenticateJWT, getEnquiryById);

router.put(
  "/:id/status",
  authenticateJWT,
  authorizeRoles("ADMIN"),
  updateEnquiryStatus
);

router.delete(
  "/:id",
  authenticateJWT,
  authorizeRoles("ADMIN"),
  deleteEnquiry
);

// Update enquiry header (editable fields only)
router.put(
  "/:id",
  authenticateJWT,
  authorizeRoles("ADMIN", "STAFF"),
  updateEnquiry
);

// Update single enquiry item
router.put(
  "/item/:itemId",
  authenticateJWT,
  authorizeRoles("ADMIN", "STAFF"),
  updateEnquiryItem
);

export default router;
