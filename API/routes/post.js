const express = require("express");
const postController = require("./post_controller");
const multerInstance = require("../utils/multer");
const { userAuth, checkRole } = require("../utils/Auth");

router = express.Router();

// Create Service
router.post(
  "/",
  userAuth,
  checkRole(["user"]),
  multerInstance.upload.single("image"),
  postController.createPost
);
// Get all the Services
router.get("/", userAuth, checkRole(["user"]), postController.getPost);
// Get single service by its ID
router.get("/:id", userAuth, checkRole(["user"]), postController.getPostById);
// Update service by ID
router.put(
    "/:id",
    userAuth,
    checkRole(["user"]),
    multerInstance.upload.single("image"),
    postController.updatePost
  );
// Delete service by ID
router.delete("/:id", userAuth, checkRole(["user"]), postController.removePost);

module.exports = router;
