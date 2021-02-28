const router = require("express").Router();
const productController = require("./controller");
const multerInstance = require("../utils/multer");
const { userAuth, checkRole } = require("../utils/Auth");

// Create Product
router.post(
  "/",
  userAuth,
  checkRole(["user"]),
  multerInstance.upload.single("image"),
  productController.createProduct
);

// get all products
router.get("/", userAuth, checkRole(["user"]), productController.getProducts);

// get single product by id
router.get(
  "/:id",
  userAuth,
  checkRole(["user"]),
  productController.getProductById
);

// update product using id
router.put(
  "/:id",
  userAuth,
  checkRole(["user"]),
  productController.updateProduct
);

// delete product
router.delete(
  "/:id",
  userAuth,
  checkRole(["user"]),
  productController.removeProduct
);

module.exports = router;
