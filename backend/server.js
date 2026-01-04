const express = require("express");
require("dotenv").config();
const cors = require("cors");

const app = express();

app.use(cors({ origin: "*" }));
app.use(express.json());

console.log("SERVER STARTED");

// routes
const loginRoute = require("./routes/login");
const sectionRouter = require("./routes/section");
const categoryRouter = require("./routes/category");
const productsRouter = require("./routes/products");
const productDetailsRouter = require("./routes/product_details");
const productsRandomRouter = require("./routes/products_random");
// use routes
app.use("/login", loginRoute);
app.use("/section", sectionRouter);
app.use("/category", categoryRouter);
app.use("/products", productsRouter);
app.use("/product_details", productDetailsRouter);
app.use("/products_random", productsRandomRouter);
// root
app.get("/", (req, res) => {
  res.send("🚀 Mobile Project API is running!");
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () =>
  console.log(`Server running on port ${PORT}`)
);


