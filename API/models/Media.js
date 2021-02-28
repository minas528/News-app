const { Schema, model } = require('mongoose');
const mediaSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true
    },
    website: {
        type: String,
    },
} , {timestamps: true});

module.exports = model("Media", mediaSchema);