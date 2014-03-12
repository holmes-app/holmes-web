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

      scope.hideBarIfClickOutside = (event, callback) ->
        if scope.model.addPageFormVisible
          Ythreshold = Math.abs($('.add-page-form').position().top) + $('.add-page-form').height() - $($window).scrollTop()
          if event.y > Ythreshold
            scope.model.addPageFormVisible = false
        else
          Ythreshold = Math.abs($('.search-form').position().top) + $('.search-form').height() - $($window).scrollTop()
          if event.y > Ythreshold
            scope.model.searchFormVisible = false
        callback()
