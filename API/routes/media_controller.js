const mediaRepository = require("../repository/media");

// Create Media Controller
exports.createMedia = async (req, res) => {
    try {
        let payload = {
            name: req.body.name,
            email: req.body.email,
            website: req.body.website,
        }
        // console.log(payload)
        let media = await mediaRepository.createMedia({...payload});
        console.log(media);
        res.status(200).json({
            status: true,
            data: media,
        });
    } catch (err) {
        console.log(err);
        res.status(400).json({
            error: err,
            status: false
        })
    }
};

// Get all Media Controller
exports.getMedia = async (req, res) => {

    try {
        let medias = await mediaRepository.medias();
        res.status(200).json({
            status: true,
            data: medias,
        })
    } catch (err) {
        console.log(err)
        res.status(500).json({
            error: err,
            status: false,
        })
    }
}

// Get Media By its Id Controller
exports.getMediaById = async (req, res) => {
    try {
        let id = req.params.id
        let mediaDetails = await mediaRepository.mediaById(id);
        res.status(200).json({
            status: true,
            data: mediaDetails,
        })
    } catch (err) {
        res.status(500).json({
            status: false,
            error: err
        })
    }
}

// Update Service Media
exports.updateMedia = async (req, res) => {
    try{
        let id = req.params.id;
        let payload = {
            name: req.body.name,
            email: req.body.email,
            website: req.body.website,
        }
        let mediaDetails =  await mediaRepository.updateMedia(id,payload);
        console.log(mediaDetails);
        res.status(200).json({
            
            status: true,
            data: mediaDetails,
        })
    } catch (err) {
        console.log('eerr')
        res.status(500).json({
            status: false,
            error: err
        })
    }
}

// Delete Post Controller
exports.removePost = async (req, res) => {
    try {
        let id = req.params.id
        let postDetails = await mediaRepository.deleteMedia(id)
        res.status(200).json({
            status: true,
            data: postDetails,
        })
    } catch (err) {
        res.status(501).json({
            status: false,
            error: err
        })
    }
}
