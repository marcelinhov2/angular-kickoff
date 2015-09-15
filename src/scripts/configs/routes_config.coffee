class Routes extends Config
  constructor: (
    $stateProvider
    $stickyStateProvider
    $urlRouterProvider
    $urlMatcherFactoryProvider
    $httpProvider
    $locationProvider
  ) ->
    $stateProvider
      .state 'App',
        abstract: true
        template: '<div ui-view="main"></div>'
        controller : 'appController'

      .state 
        name: 'App.dashboard'
        url: '/dashboard'
        views: 
          main:
            templateUrl : '/partials/views/dashboard/index.html'
            controller : 'dashboardIndexController'

    $stickyStateProvider.enableDebug(true);

    $urlRouterProvider.rule ($injector, $location) ->
      path = $location.url()
      # check to see if the path already has a slash where it should be
      if path[path.length - 1] == '/' or path.indexOf('/?') > -1
        return
      if path.indexOf('?') > -1
        return path.replace('?', '/?')
      path + '/'
      
    $urlRouterProvider.otherwise('/dashboard');

    $locationProvider.html5Mode true
    $httpProvider.interceptors.push('HttpRequestInterceptor');