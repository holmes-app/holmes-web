'use strict'

class DomainsCtrl
  constructor: (@scope, @DomainsFcty, @MostCommonViolationsFcty, @WebSocketFcty) ->
    @domainsVisible = false
    @groupsVisible = true
    @mostFrequentVisible = false

    @getDomainData()
    @getMostCommonViolations()

    @WebSocketFcty.on((message) =>
      @getDomainData()
    )

  _fillDomains: (domains) =>
    @domains = domains
    @DomainsFcty.getDomainsDetails().then(@_fillDomainsDetails)

  _fillDomainsDetails: (domains) =>
    @domains = domains
 
  _fillViolations: (mostCommonViolations) =>
    @mostFrequentViolations = mostCommonViolations.slice(0, 10)
    @leastFrequentViolations = mostCommonViolations.slice(10)
    @groupData = _.groupBy(mostCommonViolations, 'category')

  toggleDomainVisibility: ->
    @domainsVisible = !@domainsVisible

  showGroups: ->
    @groupsVisible = true
    @mostFrequentVisible = false

  showMostFrequent: ->
    @groupsVisible = false
    @mostFrequentVisible = true

  getDomainData: ->
    @DomainsFcty.getDomains().then(@_fillDomains)

  getMostCommonViolations: ->
    @MostCommonViolationsFcty.all('').getList().then(@_fillViolations)


angular.module('holmesApp')
  .controller 'DomainsCtrl', ($scope, DomainsFcty, MostCommonViolationsFcty, WebSocketFcty) ->

    $scope.model = new DomainsCtrl($scope, DomainsFcty, MostCommonViolationsFcty, WebSocketFcty)
