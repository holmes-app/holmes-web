'use strict'

angular.module('holmesApp')
  .filter('slice', ->
    (arr, start, end) ->
      if arr then arr.slice(start, end) else []
  )
