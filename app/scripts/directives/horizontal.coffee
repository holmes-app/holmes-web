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
      valueLabelWidth = null
      totalLabelWidth = null

      setElementValue = (value) ->
        valueLabel = ''
        if scope.valuelabel?
          valueLabel = '<div class="value-label">' + scope.valuelabel + '</div>'

        valueElement.html(value + valueLabel)
        valueLabelWidth = valueElement.find('.value-label').width()

      setElementValue(scope.value)

      totalLabel = null
      if scope.totallabel?
        totalLabel = angular.element('<div class="total-label">' + scope.totallabel + '</div>')
        element.append(totalLabel)
        totalLabelWidth = totalLabel.width()

      totalValueElement = null
      if showTotal
        totalValueElement = angular.element('<div class="total">' + (scope.total - scope.value) + '</div>')
        element.append(totalValueElement)

      setElementTotalValue = (totalValue) ->
        totalValueElement.html(totalValue)

      setElementTotalValue(scope.total)

      scope.$watch('value', (newValue, oldValue) ->
        setElementValue(newValue)
      )

      scope.$watch('total', (newValue, oldValue) ->
        setElementTotalValue(newValue)
      )

      scope.$watch('percentage', (newValue, oldValue) ->
        width = scope.percentage * maxWidth
        valueElement.css('width', width)

        if totalLabel?
          if width > maxWidth - totalLabelWidth
            totalLabel.fadeOut()
            totalValue.fadeOut() if totalValue?
          else
            totalLabel.fadeIn()
            totalValue.fadeIn() if totalValue?

        if scope.valuelabel?
          label = valueElement.find('.value-label')
          if width < label.width()
            label.fadeOut()
          else
            label.fadeIn()
      )
  )
