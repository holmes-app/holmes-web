'use strict'

class DomainDropdown
  constructor: (@scope, @element, @attrs, @DomainsFcty) ->
    @scope.domainsOptions = []

    if @scope.selected?
      @scope.domainsSelected = @scope.selected

    if not @scope.showclose?
      @scope.showclose = true

    @scope.domainsOnChange = () =>
      @scope.onchange = @scope.domainsSelected.value

    @scope.clearDomainDropdown = () =>
     if @scope.selected?
       @scope.domainsSelected = {label: @scope.selected, value: @scope.selected,  placeholder: true}
     else if @scope.placeholder?
        @scope.domainsSelected = {label: @scope.placeholder, value: @scope.placeholder, placeholder: true}
      else
        @scope.domainsSelected = {label: 'Filter domain', value: '', placeholder: true}
      @scope.domainsOnChange()

    @getDomainsList()

  _fillOptions: (domains) =>
    if not @scope.placeholder?
      ({label: domain.name, value: domain.name, placeholder: false} for domain in domains)
    else
      values = ({label: domain.name, value: domain.name, placeholder: true} for domain in domains)
      values.unshift({label: @scope.placeholder, value: @scope.placeholder, placeholder: true})
      values

  _fillDomainsList: (domains) =>
    @scope.domainsOptions =  @_fillOptions(domains)
    @watchScope()
    @scope.clearDomainDropdown()

  getDomainsList: =>
    if @scope.autoload != false
      @DomainsFcty.getDomains().then @_fillDomainsList, =>
        @scope.domainsOptions = []

  setDomainsList: =>
    if @scope.options
      @scope.domainsOptions = @_fillOptions(@scope.options)
      @scope.clearDomainDropdown()

  watchScope: ->
    @scope.$watch('options', @setDomainsList)


angular.module('holmesApp')
  .directive('domaindropdown', (DomainsFcty) ->
    templateUrl: 'views/domain-dropdown.html'
    restrict: 'E'
    replace: true
    scope:
      selected: '='
      options: '='
      onchange: '='
      placeholder: '@'
      showclose: '@'
      autoload: '&'
    link: (scope, element, attrs) ->
      domaindropdown = new DomainDropdown(scope, element, attrs, DomainsFcty)
  )
