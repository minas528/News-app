const Media = require('../models/Media');


// Get all Media
exports.medias = async () => {
    const medias = await Media.find();
    return medias;
};

// Get one Media By its Id
exports.mediaById = async (id) => {
    const media = await Media.findById(id);
    return media;
};

// Create new Media
exports.createMedia = async (payload) => {
    const newMedia = await Media.create(payload);
    return newMedia;
};

// Find Media by its id and update its properties
exports.updateMedia = async (id, payload) => {
    const media = await Media.findByIdAndUpdate(id, payload, {new: true});
    return media;
};

// Find Media by its id and delete it
exports.deleteMedia = async (id) => {
    const media = await Media.findByIdAndDelete(id);
    return media;
};