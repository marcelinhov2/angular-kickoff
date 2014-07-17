class App extends App then constructor: -> return [
  'ngAnimate'
  'ngRoute'
]

class Routes extends Config
  constructor: ($routeProvider, $locationProvider) ->
      $routeProvider
      .when '/',
          controller: 'HomeController'
          templateUrl: '/partials/home.html'

      $locationProvider.html5Mode true