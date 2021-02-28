const postRepository = require("../repository/post");

// Create Post Controller
exports.createPost = async (req, res) => {
    try {
        let payload = {
            mediaId: req.body.media,
            reporterId: req.body.reporter,
            headlines: req.body.headlines,
            content: req.body.content,
            image: req.file.path,
        }
        console.log(`create post ${payload}`)
        let post = await  postRepository.createPost({...payload});
        res.status(200).json({
            status: true,
            data: post,
        });
    } catch (err) {
        console.log('nohkjghfdghj'+err);
        res.status(400).json({
            error: err,
            status: false
        })
    }
};

// Get all Post Controller
exports.getPost = async (req, res) => {
    

    try {
        console.log('get posts endpoint hit');
        let posts = await postRepository.posts();
        res.status(200).json({
            status: true,
            data: posts,
        })
    } catch (err) {
        console.log(err)
        res.status(500).json({
            error: err,
            status: false,
        })
    }
}

// Get Post By its Id Controller
exports.getPostById = async (req, res) => {
    try {
        let id = req.params.id
        let postDetails = await postRepository.postById(id);
        res.status(200).json({
            status: true,
            data: postDetails,
        })
    } catch (err) {
        res.status(500).json({
            status: false,
            error: err
        })
    }
}

// Update Service Post
exports.updatePost = async (req, res) => {
    try{
        let id = req.params.id;
        console.log(req.body);
        let payload = {
            media: req.body.media,
            reporter: req.body.reporter,
            headlines: req.body.headlines,
            content: req.body.content,
            image: req.file.path,
        }
        let postDetails =  await postRepository.updatePost(id,payload)
        res.status(200).json({
            status: true,
            data: postDetails,
        })
    } catch (err) {
        console.log(err)
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
        let postDetails = await postRepository.deletePost(id)
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
