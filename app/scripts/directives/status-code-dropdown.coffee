'use strict'

class StatusCodeDropdown
  constructor: (@scope, @element, @attrs, @LastRequestsFcty) ->
    @scope.statusCodeOnChange = () =>
      @scope.onchange = @scope.statusCodeSelected.text

    @scope.clearStatusCodeDropdown = () =>
      @scope.statusCodeSelected = {label: 'Filter status code', placeholder: true}
      @scope.onchange = ''

    @getStatusCode()

  _fillStatusCode: (status_code) =>
    @scope.statusCodeOptions = ({label: item.statusCode + ' ' + item.statusCodeTitle, text: item.statusCode} for item in status_code)

  getStatusCode: =>
    @LastRequestsFcty.getStatusCode().then @_fillStatusCode, =>
      @scope.statusCodeOptions = []
    @scope.clearStatusCodeDropdown()


angular.module('holmesApp')
  .directive('statuscodedropdown', (LastRequestsFcty) ->
    templateUrl: 'views/status-code-dropdown.html'
    restrict: 'E'
    replace: true
    scope:
      selected: '='
      options: '='
      onchange: '='
    link: (scope, element, attrs) ->
      statusCodeDropdown = new StatusCodeDropdown(scope, element, attrs, LastRequestsFcty)
  )
