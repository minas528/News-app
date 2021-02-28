const express = require("express");
const mediaController = require("./media_controller");
const multerInstance = require("../utils/multer");
const { userAuth, checkRole } = require("../utils/Auth");

router = express.Router();

// Create Service
router.post("/", userAuth, checkRole(["user"]), mediaController.createMedia);
// Get all the Services
router.get("/", userAuth, checkRole(["user"]), mediaController.getMedia);
// Get single service by its ID
router.get("/:id", userAuth, checkRole(["user"]), mediaController.getMediaById);
// Update service by ID
router.put("/:id", userAuth, checkRole(["user"]), mediaController.updateMedia);
// Delete service by ID
router.delete(
  "/:id",
  userAuth,
  checkRole(["user"]),
  mediaController.removePost
);

module.exports = router;
