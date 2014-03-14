'use strict'

angular.module('holmesApp')
  .directive 'headerbar', ($window) ->
    templateUrl: 'views/headerbar.html'
    restrict: 'E'
    replace: true,
    link: (scope, element, attrs) ->
      scope.model = scope.model or {}
      scope.model.addPageFormVisible = false
      scope.model.searchFormVisible = false

      scope.toggleBar = ->
        if scope.model.addPageFormVisible or scope.model.searchFormVisible
          $window.onclick = (event) ->
            scope.hideBarIfClickOutside(event, scope.toggleBar)
        else
          $window.onclick = null
          scope.$apply()

      _toggle = (obj) ->
        headers = ['searchFormVisible', 'addPageFormVisible']
        headers.splice(headers.indexOf(obj), 1)
        scope.model[obj] = !scope.model[obj]

        for x in headers
            scope.model[x] = false

        if scope.model[obj]
          scope.toggleBar()

      scope.toggleAddPage = ->
        _toggle('addPageFormVisible')

      scope.toggleSearch = ->
        _toggle('searchFormVisible')

      scope.hideBarIfClickOutside = (event, callback) ->
        _hideBar = (event, element, obj) ->
          Ythreshold = Math.abs($(element).position().top) + $(element).height() - $($window).scrollTop()
          if event.y > Ythreshold
            scope.model[obj] = false

        if scope.model.addPageFormVisible
          _hideBar(event, '.add-page-form', 'addPageFormVisible')
        else if scope.model.searchFormVisible
          _hideBar(event, '.search-form', 'searchFormVisible')
        callback()
