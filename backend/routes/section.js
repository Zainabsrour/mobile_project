const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

router.get("/", async (req, res) => {
  const { data, error } = await supabase
    .from("First_section") // ✅ اسم الجدول الصح
    .select("section_tittle, section_description, section_image")
    .limit(1)
    .single(); // 👈 مهم

  if (error) {
    return res.status(500).json({ error: error.message });
  }

  res.json(data);
});

module.exports = router;
