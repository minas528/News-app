const router = require("express").Router();
// Bring in  the user Registration function
const {
  userRegister,
  userLogin,
  userAuth,
  serializeUser,
  checkRole,
} = require("../utils/Auth");
// const User = require("./models/Users.js");

// User registration route
router.post("/register-user", async (req, res) => {
  console.log("got hee")
  await userRegister(req.body, "user", res);
});

// Admin registration route
router.post("/register-admin", async (req, res) => {
  await userRegister(req.body, "admin", res);
});

// SuperAdmin registration route
router.post("/register-super-admin", async (req, res) => {
  await userRegister(req.body, "superadmin", res);
});

// User login route
router.post("/login-user", async (req, res) => {
  await userLogin(req.body, "user", res);
});

// Admin login route
router.post("/login-admin", async (req, res) => {
  await userLogin(req.body, "admin", res);
});

// SuperAdmin login route
router.post("/login-super-admin", async (req, res) => {
  await userLogin(req.body, "superadmin", res);
});

// profile route
router.get("/", userAuth, async (req, res) => {
  return res.json(serializeUser(req.user));
});

// User Protected route
router.get(
  "/user-protected",
  userAuth,
  checkRole(["user"]),
  async (req, res) => {
      res.json("Hello user");
  }
);

// Admin Protected route
router.get(
  "/admin-protected",
  userAuth,
  checkRole(["admin"]),
  async (req, res) => {
    res.json("Hello admin");
  }
);

// SuperAdmin Protected route
router.get(
  "/super-admin-protected",
  userAuth,
  checkRole(["superadmin"]),
  async (req, res) => {
    res.json("Hello superadmiin");
  }
);

// SuperAdmin and Admin Protected route
router.get(
    "/super-admin-and-admin-protected",
    userAuth,
    checkRole(["superadmin","admin"]),
    async (req, res) => {
        res.json("Hello super admin or admin");
    }
  );

module.exports = router;
