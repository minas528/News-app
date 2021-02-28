const mongoose = require("mongoose");

// definition of products schema 
const productSchema = mongoose.Schema({
  name: {
    type: String,
    required: [true, "Please include the product name"],
  },
  price: {
    type: String,
    required: [true, "Please include the product price"],
  },
 image: {
    type: String,
    required: false,
  },
  description: {
    type: String,
    required: [true, "Please include the product price"],
    min: 50,
  },
});

const Product = mongoose.model("Product", productSchema);

module.exports = Product;