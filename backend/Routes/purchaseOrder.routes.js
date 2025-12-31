import express from "express";
import {
  authenticateJWT,
  authorizeRoles
} from "../Utils/auth.middleware.js";

const router = express.Router();

// Create PO from approved quotation
router.post(
  "/from-quotation/:quotationId",
  authenticateJWT,
  authorizeRoles("ADMIN"),
  createPOFromQuotation
);

