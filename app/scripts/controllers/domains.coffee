'use strict'

class DomainsCtrl
  constructor: (@scope, @DomainsFcty, @MostCommonViolationsFcty, @WebSocketFcty) ->
    @domainsVisible = false
    @groupsVisible = true
    @mostFrequentVisible = false

    @getDomainData()
    @getMostCommonViolations()

    @WebSocketFcty.on (message) =>
      if message.type == 'new-page' or message.type == 'new-review'
        @getDomainData()

  _fillDomains: (@domainList) =>
    @domains = _.mapValues(_.groupBy(@domainList, 'name'), 0) # 0 is the index of the _only one_ element of the array

    for domain in @domainList[0..3]
      @DomainsFcty.getDomainPageCount(domain).then(@_fillDomainDetails)
      @DomainsFcty.getDomainViolationCount(domain).then(@_fillDomainDetails)
      @DomainsFcty.getDomainErrorPercentage(domain).then(@_fillDomainDetails)
      @DomainsFcty.getDomainResponseTimeAvg(domain).then(@_fillDomainDetails)

    @_extraDomainsDetailsLoaded = false
    if @domainsVisible
      @_loadExtraDomainsDetails()

  _fillDomainDetails: (domainDetails) =>
    @domains[domainDetails.name] = _.merge(@domains[domainDetails.name], domainDetails)

  _loadExtraDomainsDetails: ->
    return if @_extraDomainsDetailsLoaded

    for domain in @domainList[4..]
      @DomainsFcty.getDomainPageCount(domain).then(@_fillDomainDetails)
      @DomainsFcty.getDomainViolationCount(domain).then(@_fillDomainDetails)
      @DomainsFcty.getDomainErrorPercentage(domain).then(@_fillDomainDetails)
      @DomainsFcty.getDomainResponseTimeAvg(domain).then(@_fillDomainDetails)

    @_extraDomainsDetailsLoaded = true

  _fillViolations: (mostCommonViolations) =>
    @mostFrequentViolations = mostCommonViolations[0..10]
    @leastFrequentViolations = mostCommonViolations[10..]
    @groupData = _.groupBy(mostCommonViolations, 'category')

  toggleDomainVisibility: ->
    @domainsVisible = !@domainsVisible
    @_loadExtraDomainsDetails()

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
