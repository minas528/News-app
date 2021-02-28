const reporterRepository = require("../repository/reporter");

// Create Reporter Controller
exports.createReporter = async (req, res) => {
    try {
        let payload = {
            name: req.body.name,
            email: req.body.email,
            sex: req.body.sex,
            media: req.body.media,
            password: req.body.password
        }

        let reporter = await reporterRepository.createReporter({...payload});
        res.status(200).json({
            status: true,
            data: reporter,
        });
    } catch (err) {
        console.log(err);
        res.status(400).json({
            error: err,
            status: false
        })
    }
};

// Get all Reporter Controller
exports.getReporter = async (req, res) => {

    try {
        let reporters = await reporterRepository.reoorters();
        res.status(200).json({
            status: true,
            data: reporters,
        })
    } catch (err) {
        console.log(err)
        res.status(500).json({
            error: err,
            status: false,
        })
    }
}

// Get Reporter By its Id Controller
exports.getReporterById = async (req, res) => {
    try {
        let id = req.params.id
        let reporterDetails = await reporterRepository.postById(id);
        res.status(200).json({
            status: true,
            data: reporterDetails,
        })
    } catch (err) {
        res.status(500).json({
            status: false,
            error: err
        })
    }
}

// Update Service Reporter
exports.updateReporter = async (req, res) => {
    try{
        let id = req.params.id;
        console.log(id);
        let payload = {
            media: req.body.media,
            reporter: req.body.reporter,
            headlines: req.body.headlines,
            content: req.body.content,
            image: req.body.image,
        }
        let reporterDetails =  await reporterRepository.updateReporter(id,req.body)
        res.status(200).json({
            status: true,
            data: reporterDetails,
        })
    } catch (err) {
        res.status(500).json({
            status: false,
            error: err
        })
    }
}

// Delete Reporter Controller
exports.removeReporter = async (req, res) => {
    try {
        let id = req.params.id
        let reporterDetails = await reporterRepository.deleteReporter(id)
        res.status(200).json({
            status: true,
            data: reporterDetails,
        })
    } catch (err) {
        res.status(501).json({
            status: false,
            error: err
        })
    }
}
