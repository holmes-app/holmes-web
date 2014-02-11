'use strict'

angular.module('holmesApp')
  .directive('headerbar', () ->
    templateUrl: 'views/headerbar.html'
    restrict: 'E'
    replace: true,
    link: (scope, element, attrs) ->
      scope.model = scope.model or {}

      scope.model.addPageFormVisible = false
      scope.toggleAddPage = ->
        scope.model.addPageFormVisible = !scope.model.addPageFormVisible
        scope.model.searchFormVisible = false

      scope.model.searchFormVisible = false
      scope.toggleSearch = ->
        scope.model.addPageFormVisible = false
        scope.model.searchFormVisible = !scope.model.searchFormVisible
  )
