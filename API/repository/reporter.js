const Reporter = require('../models/Reporter');


// Get all Reporter
exports.reoorters = async () => {
    const reporters = await Reporter.find();
    return reporters;
};

// Get one Reporter By its Id
exports.reporterById = async (id) => {
    const reporter = await Reporter.findById(id);
    return reporter;
};

// Create new Reporter
exports.createReporter = async (payload) => {
    const newReporter = await Reporter.create(payload);
    return newReporter;
};

// Find Reporter by its id and update its properties
exports.updateReporter = async (id, payload) => {
    const reporter = await Reporter.findByIdAndUpdate(id, payload, {new: true});
    return reporter;
};

// Find Reporter by its id and delete it
exports.deleteReporter = async (id) => {
    const reporter = await Reporter.findByIdAndDelete(id);
    return reporter;
};