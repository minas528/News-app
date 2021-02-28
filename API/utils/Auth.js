const User = require("../models/Users");
const bycrpt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const passport = require("passport");
const { SECRET } = require("../config");

/**
 * @DESC To register the user (Admin, super admin, user)
 */

const userRegister = async (userDets, role, res) => {
  try {
    // Validate username
    let usernameTaken = await validateUsername(userDets.username);
    console.log(usernameTaken);
    if (usernameTaken) {
      res.status(400).json({
        message: `Username is already taken.`,
        success: false,
      });
    }
    // validate email
    let emailTake = await validateEmail(userDets.email);
    if (!emailTake) {
      res.status(400).json({
        message: `email is already registered.`,
        success: false,
      });
    }

    // Get the hashed password
    const password = await bycrpt.hash(userDets.password, 12);
    // Create a new user
    const newUser = User({ ...userDets, password, role });
    await newUser.save();
    return res.status(201).json({
      message: "Hurry, you are succesfully registered. Please login now!",
      success: true,
    });
  } catch (err) {
    // Imeplement logger functions (winston)
    return res.status(500).json({
      message: "Unable to create your accout!",
      success: false,
    });
  }
};

/**
 * @DESC To Login the user (Admin, super admin, user)
 */

const userLogin = async (userCreds, role, res) => {
  let { username, password } = userCreds;
  // First check the username is in the database
  const user = await User.findOne({ username });
  if (!user) {
    res.status(404).json({
      message: `Username is not Found. Invalid login credintials.`,
      success: false,
    });
  }
  // if found then check the role
  if (user.role != role) {
    res.status(403).json({
      message: `Please make sure you are logged in from the right portal.`,
      success: false,
    });
  }
  // This means the user is exsting with valid role
  // Now check the password
  let isMatch = await bycrpt.compare(password, user.password);
  if (isMatch) {
    // Sign in the token and issue it to the user
    let token = jwt.sign(
      {
        user_id: user._id,
        role: user.role,
        username: user.username,
        email: user.email,
      },
      SECRET,
      { expiresIn: "7 days" }
    );

    let result = {
      username: user.username,
      role: user.role,
      email: user.emial,
      token: `Bearer ${token}`,
      expiresIn: 168,
    };

    return res.status(200).json({
      ...result,
      message: "Hurry, you are now logged in!",
      success: true,
    });
  } else {
    res.status(403).json({
      message: `Incorrect password!`,
      success: false,
    });
  }
};

/**
 *
 * @DESC Passport middleware
 */

const userAuth = passport.authenticate("jwt", { session: false });

/**
 * @DESC Check role middleware
 */
const checkRole = (roles) => (req, res, next) =>
  !roles.includes(req.user.role) ? res.status(401).json("Unautorized!") : next();

const validateUsername = async (username) => {
  let user = await User.findOne({ username });
  return user ? true : false;
};
const validateEmail = async (email) => {
  let user = await User.findOne({ email });
  return user ? false : true;
};

const serializeUser = (user) => {
  return {
    username: user.username,
    email: user.email,
    name: user.name,
    _id: user._id,
    updatedAt: user.updatedAt,
    createdAt: user.createdAt,
  };
};

module.exports = {
  userRegister,
  userLogin,
  userAuth,
  serializeUser,
  checkRole,
};
