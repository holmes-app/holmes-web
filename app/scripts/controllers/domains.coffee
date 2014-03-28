'use strict'

class DomainsCtrl
  constructor: (@scope, @DomainsFcty, @MostCommonViolationsFcty, @WebSocketFcty) ->
    @domainsVisible = false
    @groupsVisible = true
    @mostFrequentVisible = false

    @getDomainData()
    @getMostCommonViolations()

    @watchScope()

    @WebSocketFcty.clearHandlers()
    @WebSocketFcty.on (message) =>
      if message.type == 'new-page' or message.type == 'new-review'
        @getDomainData()

  _fillDomains: (@domainList) =>
    @domainList = _.sortBy(@domainList.reverse(), 'is_active').reverse()
    @domains = @domainList
    @loadedDomains = @domainList.length

  _fillViolations: (mostCommonViolations) =>
    @mostFrequentViolations = mostCommonViolations[0..9]
    @leastFrequentViolations = mostCommonViolations[10..]
    @groupDataFull = _.groupBy(mostCommonViolations, 'category')
    @groupData = @groupDataFull
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
  .controller 'DomainsCtrl', ($scope, DomainsFcty, MostCommonViolationsFcty, WebSocketFcty) ->

    $scope.model = new DomainsCtrl($scope, DomainsFcty, MostCommonViolationsFcty, WebSocketFcty)
