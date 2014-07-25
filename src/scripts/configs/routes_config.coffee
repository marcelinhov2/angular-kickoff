class Routes extends Config
  constructor: ($routeProvider, $locationProvider) ->
      $routeProvider
      .when '/',
        controller: 'homeController'
        templateUrl: '/partials/views/home.html'
      .when '/internal',
        controller: 'internalController'
        templateUrl: '/partials/views/internal.html'
      .otherwise
        redirectTo: '/'

      $locationProvider.html5Mode true