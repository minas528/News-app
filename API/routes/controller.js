const productRepository = require('../repository/products');

exports.createProduct = async (req, res) => {

    try {
        let payload = {
            name: req.body.name,
            price: req.body.price,
            image: req.file.path,
            description: req.body.description
        }
        let product = await productRepository.createProduct({
            ...payload
        });
        res.status(200).json({
            status: true,
            data: product,
        })
    } catch (err) {
        console.log(err)
        res.status(400).json({
            error: err,
            status: false,
        })
    }
    
}
exports.getProducts = async (req, res) => {

        try {
            let page = Math.max(0, req.params.page);
            let products = await productRepository.products(page);
            res.status(200).json({
                status: true,
                data: products,
        })
    } catch (err) {
        console.log(err)
        res.status(500).json({
            error: err,
            status: false,
        })
    }
}
exports.getProductById = async (req, res) => {
    try {
        let id = req.params.id
        let productDetails = await productRepository.productById(id);
        res.status(200).json({
            status: true,
            data: productDetails,
        })
    } catch (err) {
        res.status(500).json({
            status: false,
            error: err
        })
    }
}
exports.updateProduct = async (req, res) => {
    try{
        let id = req.params.id;
        console.log(req.body)
        let payload = {
            name: req.body.name,
            price: req.body.price,
            description: req.body.description
        }
        let productDetails =  await productRepository.updateProduct(id,req.body)
        res.status(200).json({
            status: true,
            data: productDetails,
        })
    } catch (err) {
        res.status(500).json({
            status: false,
            error: err
        })
    }
}
exports.removeProduct = async (req, res) => {
    try {
        let id = req.params.id
        let productDetails = await productRepository.removeProduct(id)
        res.status(200).json({
            status: true,
            data: productDetails,
        })
    } catch (err) {
        res.status(501).json({
            status: false,
            error: err
        })
    }
}