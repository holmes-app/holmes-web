'use strict'

class DomainsCtrl
  constructor: (@scope, @DomainsFcty, @MostCommonViolationsFcty) ->
    @domainsVisible = false
    @groupsVisible = true
    @mostFrequentVisible = false

    @getDomainData()
    @getMostCommonViolations()

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
    @domains = @DomainsFcty.all('').getList().$object

  getMostCommonViolations: ->
    @MostCommonViolationsFcty.all('').getList().then(@_fillViolations)


angular.module('holmesApp')
  .controller 'DomainsCtrl', ($scope, DomainsFcty, MostCommonViolationsFcty) ->

    $scope.model = new DomainsCtrl($scope, DomainsFcty, MostCommonViolationsFcty)
