'use strict'

angular.module('holmesApp')
  .filter('prefixUrl', ($filter) ->
    (value) ->
      if value and !/^(http):\/\//i.test(value) && 'http://'.indexOf(value) == -1
        return 'http://' + value
      else
        return value
  )
