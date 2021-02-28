const express = require("express");
const reporterController = require("./reporter_controller");
const multerInstance = require("../utils/multer");
const { userAuth, checkRole } = require("../utils/Auth");

router = express.Router();

// Create Service
router.post(
  "/",
  userAuth,
  checkRole(["user"]),
  reporterController.createReporter
);
// Get all the Services
router.get("/", userAuth, checkRole(["user"]), reporterController.getReporter);
// Get single service by its ID
router.get(
  "/:id",
  userAuth,
  checkRole(["user"]),
  reporterController.getReporterById
);
// Update service by ID
router.put(
  "/:id",
  userAuth,
  checkRole(["user"]),
  reporterController.updateReporter
);
// Delete service by ID
router.delete(
  "/:id",
  userAuth,
  checkRole(["user"]),
  reporterController.removeReporter
);

module.exports = router;
