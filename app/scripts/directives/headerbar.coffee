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
      scope.model.alertMessageVisible = false

      _toggleHideOnClick = ->
        if scope.model.addPageFormVisible or scope.model.searchFormVisible or scope.model.alertMessageVisible
          $window.onclick = _hideBarOnClickOutside
        else
          $window.onclick = null

      _toggle = (obj) ->
        headers = ['searchFormVisible', 'addPageFormVisible', 'alertMessageVisible']
        headers.splice(headers.indexOf(obj), 1)
        scope.model[obj] = !scope.model[obj]

        for x in headers
            scope.model[x] = false

        _toggleHideOnClick()

      _hideBarOnClickOutside = (event) ->
        _hideBar = (event, element, obj) ->
          Ythreshold = Math.abs($(element).position().top) + $(element).height() - $($window).scrollTop()
          if event.y > Ythreshold
            scope.model[obj] = false
            scope.hideAlertMessage()
            scope.$apply()
            _toggleHideOnClick()

        if scope.model.addPageFormVisible
          _hideBar(event, '.add-page-form', 'addPageFormVisible')
        else if scope.model.searchFormVisible
          _hideBar(event, '.search-form', 'searchFormVisible')

      scope.toggleAddPage = ->
        _toggle('addPageFormVisible')

      scope.toggleSearch = ->
        _toggle('searchFormVisible')

      scope.hideAlertMessage = (headerWitchOne) ->
        if headerWitchOne == 'success_page'
          scope.toggleAddPage()
        scope.model.alertMessageVisible = false
