'use strict'

angular.module('holmesApp')
  .directive('focusIf', ($timeout, $parse) ->
    scope:
      shall_focus: '=focusIf'
    link: (scope, element, attrs) ->
      scope.$watch 'shall_focus', (value) ->
        if value
          $timeout ->
            element[0].focus()
  )
