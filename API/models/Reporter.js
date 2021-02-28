const mongoose = require('mongoose');
const reporterSchema = new mongoose.Schema({
    name: {firstName: {
        type: String,
        required: true},
        lastName:{
            type: String,
            require: true
        }
    },
    email: {
        type: String,
        required: true
    },
    sex: {
        type: String,
        required: true
    },
    media: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Media",
    },
    password: {
        type: String,
        required: true,
    }
} , {timestamps: true});

module.exports = mongoose.model("Reporter", reporterSchema);