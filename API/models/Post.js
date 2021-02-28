const mongoose = require('mongoose');
const PostSchema = mongoose.Schema({
    mediaId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Media",
    },
    reporterId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Reporter",
    },
    headlines: {
        type: String,
    },
    content:{
        type: String,
    },
    image:{
        type: String,
        required: true
    }
} , {timestamps: true});

module.exports = mongoose.model("Post", PostSchema);