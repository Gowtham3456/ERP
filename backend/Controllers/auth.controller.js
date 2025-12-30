import pool from "../Utils/db.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

export const login = async (req, res) => {
  const { email, password } = req.body;

  try {
    // 1️⃣ Fetch user
    const userResult = await pool.query(
      `
      SELECT id, name, email, password_hash
      FROM auth.users
      WHERE email = $1 AND is_active = true
      `,
      [email]
    );

    if (!userResult.rows.length) {
      return res.status(401).json({ message: "Invalid email or password" });
    }

    const user = userResult.rows[0];

    // 2️⃣ Verify password
    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid email or password" });
    }

    // 3️⃣ Fetch roles
    const roleResult = await pool.query(
      `
      SELECT r.role_name
      FROM auth.user_roles ur
      JOIN auth.roles r ON ur.role_id = r.id
      WHERE ur.user_id = $1
      `,
      [user.id]
    );

    const roles = roleResult.rows.map(r => r.role_name);

    if (!roles.length) {
      return res.status(403).json({ message: "User has no roles assigned" });
    }

    // 4️⃣ JWT (NO company_id here)
    const token = jwt.sign(
      {
        user_id: user.id,
        roles: roles
      },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN }
    );

    // 5️⃣ Response
    res.json({
      message: "Login successful",
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        roles: roles
      }
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
