class HeaderDirective extends Directive
  constructor: ->
    return {
      restrict: 'E'
      templateUrl: '/partials/directives/header.html'
      controller: 'headerController'
    }