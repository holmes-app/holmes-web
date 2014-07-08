'use strict'

angular.module('holmesApp')
  .directive 'headerbar', ($window, $location, $interval) ->
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

      _hideBarOnClickOutside = (ev) ->
        _hideBar = (ev, XThresElem, YThresElem, obj) ->
          YUpperThreshold = Math.abs($(YThresElem).position().top) - $($window).scrollTop()
          YLowerThreshold = Math.abs($(YThresElem).position().top) + $(YThresElem).height() - $($window).scrollTop()
          Xthreshold = Math.abs($(XThresElem).position().left)
          if ev.clientY > YLowerThreshold or ev.clientY < YUpperThreshold and ev.clientX < Xthreshold
            scope.model[obj] = false
            scope.hideAlertMessage()
            scope.$apply()
            _toggleHideOnClick()

        if scope.model.addPageFormVisible
          _hideBar(ev, '.header-add-page', '.add-page-form', 'addPageFormVisible')
        else if scope.model.searchFormVisible
          _hideBar(ev, '.header-add-page', '.search-form', 'searchFormVisible')

      scope.toggleAddPage = ->
        if scope.model.alertMessageVisible and scope.model.addPageFormVisible
          _toggle('alertMessageVisible')
        _toggle('addPageFormVisible')

      scope.toggleSearch = ->
        _toggle('searchFormVisible')

      scope.hideAlertMessage = (headerWitchOne) ->
        scope.model.alertMessageVisible = false
        if headerWitchOne == 'success_page'
          scope.toggleAddPage()
