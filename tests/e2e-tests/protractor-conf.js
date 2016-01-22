exports.config = {
  allScriptsTimeout: 11000,

  specs: [
    'tests/e2e-tests/scripts/**/*.js'
  ],

  capabilities: {
    'browserName': 'chrome'
  },

  baseUrl: 'http://localhost:1137',

  framework: 'jasmine',

  jasmineNodeOpts: {
    defaultTimeoutInterval: 30000
  }
};
