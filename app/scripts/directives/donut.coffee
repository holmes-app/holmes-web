'use strict'

angular.module('holmesApp')
  .directive('donut', () ->
    restrict: 'E'
    template: '<div class="donut"><div class="chart"></div><div class="label"></div></div>'
    replace: true
    scope:
        data: '=' # list of data object to use for graph
        onselect: '='
        width: '='
        height: '='
    link: (scope, element, attrs) ->
      chartElement = element.find('.chart')
      labelElement = element.find('.label')

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

      setData = ->
        element.css('width', width).css('height', height)
        Morris.Donut(
          element: chartElement
          data: data
          colors: colors
          formatter: (value, data) ->
            onSelect(value, data) if onSelect
            labelElement.html(data.label)
            return Morris.commas(value, data)
        )


      attrs.$observe('data', setData); # lets just observe only the data because it is 
                                       # bad to use many observers, anyway this won't work
                                       # without supplied data
  )
