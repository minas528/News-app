const multer = require("multer");

const path = require("path");

//image upload
const storage = multer.diskStorage({
    destination: (req, res, cb) => {
         cb(null, path.join("./files/"));
    },
    filename: (req, file, cb) => {
        cb(null, new Date().toISOString() + file.originalname);
    }
});
// checking file type
const fileFilter = (req, file, cb) => {
    // if (file.mimetype.containes('jpg')) {
        cb(null, true);
    // } else {
    //     cb(new Error('Not an image! Please upload an image.', 400), false);
    // }
};
exports.upload = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 6
    },
    fileFilter: fileFilter
});