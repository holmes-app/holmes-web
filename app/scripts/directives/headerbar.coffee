'use strict'

angular.module('holmesApp')
  .directive 'headerbar', ($window) ->
    templateUrl: 'views/headerbar.html'
    restrict: 'E'
    replace: true,
    link: (scope, element, attrs) ->
      scope.model = scope.model or {}

      scope.model.addPageFormVisible = false
      scope.toggleAddPage = ->
        scope.model.addPageFormVisible = !scope.model.addPageFormVisible
        scope.model.searchFormVisible = false
        if scope.model.addPageFormVisible
          scope.toggleBar()

      scope.model.searchFormVisible = false
      scope.toggleSearch = ->
        scope.model.addPageFormVisible = false
        scope.model.searchFormVisible = !scope.model.searchFormVisible
        if scope.model.searchFormVisible
          scope.toggleBar()

      scope.toggleBar = ->
        if scope.model.addPageFormVisible or scope.model.searchFormVisible
          $window.onclick = (event) ->
            scope.hideBarIfClickOutside(event, scope.toggleBar)
        else
          $window.onclick = null
          scope.$apply()

      _hideBar = (event, element, obj) ->
        Ythreshold = Math.abs($(element).position().top) + $(element).height() - $($window).scrollTop()
        if event.y > Ythreshold
          scope.model[obj] = false

      scope.hideBarIfClickOutside = (event, callback) ->
        if scope.model.addPageFormVisible
          _hideBar(event, '.add-page-form', 'addPageFormVisible')
        else if scope.model.searchFormVisible
          _hideBar(event, '.search-form', 'searchFormVisible')
        callback()
