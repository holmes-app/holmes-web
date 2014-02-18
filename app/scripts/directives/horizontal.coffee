'use strict'

angular.module('holmesApp')
  .directive('horizontal', () ->
    template: '<div class="horizontal-bar"><div class="value"></div></div>'
    replace: true
    restrict: 'E'
    scope:
        percentage: '='
    link: (scope, element, attrs) ->
      valueElement = element.find('.value')
      maxWidth = element.width()
      width = scope.percentage * maxWidth
      valueElement.css('width', width)
  )
