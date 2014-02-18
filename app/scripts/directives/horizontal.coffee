'use strict'

angular.module('holmesApp')
  .directive('horizontal', () ->
    template: '<div class="horizontal-bar"></div>'
    replace: true
    restrict: 'E'
    scope:
        percentage: '='
        value: '='
        total: '='
        showtotal: '='
    link: (scope, element, attrs) ->
      showTotal = false
      showTotal = scope.showtotal if scope.showTotal?

      element.html('<div class="value"></div>')
      valueElement = element.find('.value')
      maxWidth = element.width()
      width = scope.percentage * maxWidth
      valueElement.css('width', width)
      valueElement.html(scope.value)

      valueElement.append(Angular.element('<div class="total">' + scope.total + '</div>')) if showTotal
  )
