const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

router.post("/", async (req, res) => {
  const { name, password } = req.body;

  if (!name || !password) {
    return res.status(400).json({ message: "Missing data" });
  }

  const { data, error } = await supabase
    .from("users")
    .select("*")
    .eq("name", name)
    .eq("password", password);

  if (error) return res.status(500).json(error);

  if (data.length === 0) {
    return res.status(401).json({ message: "Invalid credentials" });
  }

  res.json({
    success: true,
    user: {
      id: data[0].id,
      name: data[0].name,
    },
  });
});

module.exports = router;