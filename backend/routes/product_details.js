const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

// GET product details by ID
router.get("/:id", async (req, res) => {
  const id = parseInt(req.params.id);

  try {
    const { data, error } = await supabase
      .from("products")
      .select(
        "id, name, rate, price, image, description, category_id"
      )
      .eq("id", id)
      .single();

    if (error || !data) {
      return res.status(404).json({ message: "Product not found" });
    }

    res.json(data);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;



