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
      valuelabel: '@'
      totallabel: '@'
    link: (scope, element, attrs) ->
      showTotal = false
      showTotal = scope.showtotal if scope.showtotal?

      element.html('<div class="value"></div>')
      valueElement = element.find('.value')
      maxWidth = element.width()
      width = scope.percentage * maxWidth
      valueElement.css('width', width)

      setElementValue = (value) ->
        valueLabel = ''
        if scope.valuelabel?
          valueLabel = '<div class="value-label">' + scope.valuelabel + '</div>'

        valueElement.html(value + valueLabel)

      setElementValue(scope.value)

      totalLabel = null
      if scope.totallabel?
        totalLabel = angular.element('<div class="total-label">' + scope.totallabel + '</div>')
        element.append(totalLabel)

      element.append(angular.element('<div class="total">' + (scope.total - scope.value) + '</div>')) if showTotal

      scope.$watch('value', (newValue, oldValue) ->
        setElementValue(newValue)
      )

      scope.$watch('percentage', (newValue, oldValue) ->
        width = scope.percentage * maxWidth
        valueElement.css('width', width)

        if totalLabel?
          if width > 890
            totalLabel.fadeOut()
          else
            totalLabel.fadeIn()

        if scope.valuelabel?
          label = valueElement.find('.value-label')
          if width < 160
            label.fadeOut()
          else
            label.fadeIn()
      )
  )
