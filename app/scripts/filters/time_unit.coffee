'use strict'

angular.module('holmesApp')
  .filter('timeUnit', ($filter) ->
    (value) ->
      if isFinite(value)
        if value > 1000
          $filter('number')(value / 1000, 2) + 's'
        else
          $filter('number')(value, 0) + 'ms'
      else
        ''
  )
