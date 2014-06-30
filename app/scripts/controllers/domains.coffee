'use strict'

class DomainsCtrl
  constructor: (@scope, @window, @interval, @DomainsFcty, @MostCommonViolationsFcty, @WebSocketFcty, @NamedRouteService, @localStorage) ->
    @domainsVisible = false
    @groupsVisible = true
    @mostFrequentVisible = false

    @storage = @localStorage

    @getDomainData()
    @getMostCommonViolations()

    @watchScope()

    @WebSocketFcty.on (message) =>
      if message.type == 'new-page' or message.type == 'new-review'
        @getDomainData()

    @scope.$on '$destroy', @_cleanUp

    @_scrollToViolations() if @scope.$parent.prevHash == @NamedRouteService.reverse('violations')

  _scrollToElement: (el) =>
    srcollY = el[0].offsetTop + parseInt(el.css('margin-top'), 10) / 2
    dy = Math.abs(@window.pageYOffset - srcollY)
    @window.scrollTo(0, srcollY)
    return dy

  _scrollToViolations: ->
    el = angular.element('#violations')
    if el.length == 1
      counter = 0
      scrollInterval = @interval(=>
        dy = @_scrollToElement(el)
        if dy <= 5 or counter++ > 10
          @interval.cancel(scrollInterval)
      40)

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillDomains: (@domainList) =>
    @domainList = _.sortBy(@domainList.reverse(), 'is_active').reverse()
    @domains = @domainList
    @loadedDomains = @domainList.length
    @DomainsFcty.getDomainsDetails().then @_fillDomainsDetails

  _fillDomainsDetails: (domainsDetails) =>
    for domain in @domains
      domain.details = _.find domainsDetails, {id: domain.id}

  _fillViolations: (mostCommonViolations) =>
    groupArray = _.toArray(_.groupBy(mostCommonViolations, 'category'))
    @groupData = @groupDataFull = _.sortBy(groupArray, (g) -> g[0].category)
    @mostCommonViolations = _.sortBy mostCommonViolations, (violation) -> -violation.count
    @loadedViolations = mostCommonViolations.length

  toggleDomainVisibility: ->
    @domainsVisible = !@domainsVisible

  showGroups: ->
    @groupsVisible = true
    @mostFrequentVisible = false

  showMostFrequent: ->
    @groupsVisible = false
    @mostFrequentVisible = true

  getDomainData: ->
    @DomainsFcty.getDomains().then @_fillDomains, =>
      @loadedDomains = null

  getMostCommonViolations: ->
    @MostCommonViolationsFcty.getMostCommonViolations().then @_fillViolations, =>
      @loadedViolations = null

  watchScope: ->
    filterGroupData = $.debounce(500, (newValue, oldValue, childScope) =>
      if not newValue or newValue.length < 3
        @groupData = @groupDataFull
      else
        result = {}
        newValue = newValue.toLowerCase()
        for name, violations of @groupDataFull
          for violation in violations
            if violation.name.toLowerCase().indexOf(newValue, 0) >= 0
              if name not of result
                result[name] = []
              result[name].push(violation)
        @groupData = result
        childScope.$apply()
    )

    @scope.$watch('model.violationFilter', filterGroupData)


angular.module('holmesApp')
  .controller 'DomainsCtrl', ($scope, $window, $interval, DomainsFcty, MostCommonViolationsFcty, WebSocketFcty, $NamedRouteService, $localStorage) ->

    $scope.model = new DomainsCtrl($scope, $window, $interval, DomainsFcty, MostCommonViolationsFcty, WebSocketFcty, $NamedRouteService, $localStorage)
