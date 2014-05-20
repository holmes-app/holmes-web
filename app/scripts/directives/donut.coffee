'use strict'

angular.module('holmesApp')
  .directive 'donut', ($rootScope) ->
    restrict: 'E'
    template: '<div class="donut"><div class="donut-chart"></div><div class="donut-label"></div></div>'
    replace: true
    scope:
        data: '=' # list of data object to use for graph
        onselect: '='
        width: '='
        height: '='
    link: (scope, element, attrs) ->
      chartElement = element.find('.donut-chart')
      labelElement = element.find('.donut-label')

      label = attrs.label
      data = scope.data
      onSelect = scope.onselect
      width = scope.width
      height = scope.height
      width = 354 unless width?
      height = 354 unless height?

      colors = [
        '#9d0000',
        '#bd0000',
        '#d23939',
        '#df5a49',
        '#e78442',
        '#ff9f42',
        '#ffbd54',
        '#f2ce51',
        '#ffd955'
      ]

      executeOnSelect = (value, data) ->
        return unless onSelect?

        if(!$rootScope.$$phase)
          scope.$apply(->
            onSelect(value, data)
          )
        else
          onSelect()

      currentLabel = null

      setLabel = (label) ->
        return if label == currentLabel

        currentLabel = label
        labelElement.stop(true, true).fadeOut(
          duration: 200
          complete: ->
            labelElement.stop(true, true).html(label).fadeIn(200)
        )

      setData = (val) ->
        return if typeof val == 'undefined'
        element.css('width', width).css('height', height)
        donut = Morris.Donut
          element: chartElement
          data: val
          colors: colors
          formatter: (value, data) ->
            executeOnSelect(value, data)
            setLabel(data.label)
            return Morris.commas(value, data)

        deselect = ->
          for segment in donut.segments
            segment.deselect()

          executeOnSelect(null, null)
          setLabel(label)

        element.bind('mouseleave', $.debounce(10000, deselect))
        deselect()

      scope.$watch 'data', setData # lets just observe only the data because it is
                                   # bad to use many observers, anyway this won't work
                                   # without supplied data
