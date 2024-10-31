const core = require('@actions/core');
const github = require('@actions/github');
try {
    const message = core.getInput('message');
    console.log(`Message: ${message}`);
} catch (error) {
    core.setFailed(error.message);
}