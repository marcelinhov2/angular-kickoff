module.exports = function(config){
  config.set({

    basePath : '../',

    files : [
      'www/scripts/dependencies.js',
      'www/scripts/main.js',
      'www/scripts/**/*.js',
      'tests/scripts/**/*.js'
    ],

    autoWatch : true,

    frameworks: ['jasmine'],

    plugins : [
      'karma-jasmine'
    ],

  });
};
