import express from "express";
import {
  createEnquiry,
  getAllEnquiries,
  getEnquiryById,
  updateEnquiryStatus,
  deleteEnquiry
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

export default router;
