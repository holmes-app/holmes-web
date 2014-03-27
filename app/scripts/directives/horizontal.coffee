'use strict'

class HorizontalCtrl
  constructor: (@scope, @element, @attrs, @filter) ->
    @showTotal = false
    @showTotal = @scope.showtotal if @scope.showtotal?
    @elements = {}

    @buildElements()

    @setElementValue(@scope.value)
    @setElementTotalValue(@scope.total)

    @watchForChanges()

  setElementValue: (value) ->
    valueLabel = ''
    if @scope.valuelabel?
      valueLabel = '<div class="value-label">' + @scope.valuelabel + '</div>'

    @elements.value.html(@filter('number')(value) + valueLabel)
    @setElementTotalValue(@scope.total)

  setElementTotalValue: (totalValue) ->
    return unless @elements.totalValue?

    totalValue = if totalValue > @scope.value then totalValue - @scope.value else 0

    total = @filter('number')(totalValue)
    @elements.totalValue.html(total)

  buildElements: ->
    @element.html('<div class="value"></div>')
    @elements.value = @element.find('.value')
    @maxWidth = @element.width()
    @width = @scope.percentage * @maxWidth
    @elements.value.css('width', @width)

    @elements.totalLabel = null
    if @scope.totallabel?
      @elements.totalLabel = angular.element('<div class="total-label">' + @scope.totallabel + '</div>')
      @element.append(@elements.totalLabel)
      @totalLabelWidth = @elements.totalLabel.width()

    @elements.totalValue = null
    if @showTotal
      @elements.totalValue = angular.element('<div class="total"></div>')
      @element.append(@elements.totalValue)

  watchForChanges: ->
    @scope.$watch('value', (newValue, oldValue) =>
      @setElementValue(newValue)
    )

    @scope.$watch('total', (newValue, oldValue) =>
      @setElementTotalValue(newValue)
    )

    @scope.$watch('percentage', @updatePercentage)

  updatePercentage: =>
    @scope.percentage = 1 if @scope.percentage > 1

    idealdx = (Math.floor(Math.log(@scope.value) / Math.log(1000))) * 0.012
    idealRatio = idealdx + (Math.floor(Math.log(@scope.value) / Math.log(10)) + 1) * 0.024
    @width = if @scope.percentage > idealRatio then @scope.percentage * @maxWidth else idealRatio * @maxWidth
    @elements.value.css('width', @width)

    if @elements.totalLabel?
      if @width > @maxWidth - @totalLabelWidth
        @elements.totalLabel.fadeOut()
      else
        @elements.totalLabel.fadeIn()
        @elements.totalValue.fadeIn() if @elements.totalValue?

    if @scope.valuelabel?
      label = @elements.value.find('.value-label')
      if @width < label.width()
        label.fadeOut()
      else
        label.fadeIn()


angular.module('holmesApp')
  .directive('horizontal', ($filter) ->
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
      ctrl = new HorizontalCtrl(scope, element, attrs, $filter)
  )
