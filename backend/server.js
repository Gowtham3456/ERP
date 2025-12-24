import express from "express";
import cors from "cors";
import pool from "./Utils/db.js";
import enquiryRoutes from "./Routes/enquiry.routes.js";
import quotationRoutes from "./Routes/quotation.route.js";

const app = express();

app.use(cors());
app.use(express.json());

app.use("/api/enquiries", enquiryRoutes);
app.use("/api/quotations", quotationRoutes)

// Test DB connection
app.get("/db-test", async (req, res) => {
  try {
    const result = await pool.query("SELECT NOW()");
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database connection failed" });
  }
});

const PORT = process.env.PORT || 5000;

// SIMPLE ROUTE
app.get('/', (req, res) => {
    res.send('Hello, Buddy!');
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
