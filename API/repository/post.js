const Post = require('../models/Post');


// Get all Posts
exports.posts = async () => {
    const posts = await Post.find();
    return posts;
};

// Get one Post By its Id
exports.postById = async (id) => {
    const post = await Post.findById(id);
    return post;
};

// Create new Post
exports.createPost = async (payload) => {
    const newPost = await Post.create(payload);
    return newPost;
};

// Find Post by its id and update its properties
exports.updatePost = async (id, payload) => {
    const post = await Post.findByIdAndUpdate(id, payload, {new: true, useFindAndModify:false});
    return post;
};

// Find Post by its id and delete it
exports.deletePost = async (id) => {
    const post = await Post.findByIdAndDelete(id);
    return post;
};