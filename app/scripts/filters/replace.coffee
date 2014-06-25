'use strict'

angular.module('holmesApp')
  .filter('replace', ->
    (string, regexp, replace, flags) ->
      pattern = new RegExp regexp, flags
      string.replace pattern, replace
  )
