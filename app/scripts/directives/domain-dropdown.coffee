'use strict'

class DomainDropdown
  constructor: (@scope, @element, @attrs, @DomainsFcty) ->
    @scope.domainsOnChange = () =>
      @scope.onchange = @scope.domainsSelected.text

    @scope.clearDomainDropdown = () =>
      @scope.domainsSelected = {text: 'Filter domain', placeholder: true}
      @scope.onchange = ''

    @getDomainsList()

  _fillDomainsList: (domains) =>
    @scope.domainsOptions = ({text: domain.name} for domain in domains)

  getDomainsList: =>
    @DomainsFcty.getDomains().then @_fillDomainsList, =>
      @scope.domainsOptions = []
    @scope.clearDomainDropdown()


angular.module('holmesApp')
  .directive('domaindropdown', (DomainsFcty) ->
    templateUrl: 'views/domain-dropdown.html'
    restrict: 'E'
    replace: true
    scope:
      selected: '='
      options: '='
      onchange: '='
    link: (scope, element, attrs) ->
      domaindropdown = new DomainDropdown(scope, element, attrs, DomainsFcty)
  )
