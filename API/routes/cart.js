const router = require("express").Router();
const cartController = require("./cart_controller");
const { userAuth, checkRole } = require("../utils/Auth");

router.post("/", userAuth, checkRole(["user"]), cartController.addItemToCart);
router.get("/", userAuth, checkRole(["user"]), cartController.getCart);
router.delete(
  "/empty-cart",
  userAuth,
  checkRole(["user"]),
  cartController.emptyCart
);
module.exports = router;
