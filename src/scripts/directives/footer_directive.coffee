class FooterDirective extends Directive
  constructor: ->
    return {
      restrict: 'E'
      templateUrl: '/partials/directives/footer.html'
      controller: 'footerController'
    }