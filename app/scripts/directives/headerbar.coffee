'use strict'

angular.module('holmesApp')
  .directive('headerbar', () ->
    templateUrl: 'views/headerbar.html'
    restrict: 'E'
    replace: true,
    transclude: true,
    link: (scope, element, attrs) ->
      #element.text 'this is the headerbar directive'
  )
