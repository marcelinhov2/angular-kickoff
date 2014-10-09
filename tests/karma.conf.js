module.exports = function(config){
  config.set({

    basePath : '../',

    files : [
      'bower_components/angular/angular.js',
      'bower_components/angular-route/angular-route.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'app/scripts/dependencies.js',
      'app/scripts/main.js',
      'app/scripts/**/*.js',
      'tests/scripts/**/*.js'
    ],

    autoWatch : true,

    frameworks: ['jasmine'],

    plugins : [
            'karma-jasmine'
            ],

  });
};
