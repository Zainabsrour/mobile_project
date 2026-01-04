const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

// GET random products (مثلاً 4)
router.get("/", async (req, res) => {
  const limit = parseInt(req.query.limit) || 4;

  try {
    const { data, error } = await supabase
      .from("products")
      .select(`
        id,
        name,
        rate,
        price,
        image,
        description,
        category_id
      `);

    if (error) {
      return res.status(500).json({ message: error.message });
    }

    // 🔀 shuffle
    const shuffled = data.sort(() => 0.5 - Math.random());
    const result = shuffled.slice(0, limit);

    res.json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;
