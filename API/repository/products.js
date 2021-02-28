const Product = require("../models/Products");

exports.products = async (page) => {
  let perPage = 10;
      
  const products = await Product.find()
                                .limit(perPage)
                                .skip(perPage * page)
                                .sort("price");
  return products;
};

exports.productById = async (id) => {
  const product = await Product.findById(id);
  return product;
};

exports.createProduct = async (payload) => {
  const newProduct = await Product.create(payload);
  return newProduct;
};

exports.updateProduct = async (id,payload) => {
  console.log(payload)
  const product = await Product.findByIdAndUpdate(id, payload,{new: true,useFindAndModify:false});
  return product;
};

exports.removeProduct = async (id) => {
  const product = await Product.findByIdAndRemove(id);
  return product;
};
