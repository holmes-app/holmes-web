'use strict'

class DomainDropdown
  constructor: (@scope, @element, @attrs, @DomainsFcty) ->
    @scope.domainsOptions = []

    if not @scope.showclose?
      @scope.showclose = true

    @scope.domainsOnChange = () =>
      @scope.onchange = @scope.domainsSelected.text

    @scope.clearDomainDropdown = () =>
      if @scope.placeholder?
        @scope.domainsSelected = {text: @scope.placeholder, placeholder: true}
      else
        @scope.domainsSelected = {text: 'Filter domain', placeholder: true}
      @scope.domainsOnChange()

    @getDomainsList()

  _fillOptions: (domains) =>
    if not @scope.placeholder?
      ({text: domain.name, placeholder: false} for domain in domains)
    else
      values = ({text: domain.name, placeholder: true} for domain in domains)
      values.unshift({text: @scope.placeholder, placeholder: true})
      values

  _fillDomainsList: (domains) =>
    @scope.domainsOptions =  @_fillOptions(domains)
    @watchScope()

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
