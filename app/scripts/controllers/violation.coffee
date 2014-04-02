'use strict'

class ViolationCtrl
  constructor: (@scope, @violationKey, @ViolationFcty) ->
    if @violationKey in ['blacklist.domains']
      @showDetails = true
    @pageFilter = null
    @pageSize = 10
    @violation = {}
    @ViolationFcty.getDomainViolations(@violationKey).then @_fillViolation, =>
      @loadedViolation = null
      @loadedDetails = null
      @loadedReviews = null
    @watchScope()

  _fillReviews: (violation) =>
    @violation.reviews = violation.reviews
    @reviewsCount = violation.reviewsCount
    @loadedReviews = violation.reviews.length

  _fillDetails: (details) =>
    counts = _.pluck details, 'count'
    countSum = counts.reduce (a, b) -> a + b
    @details = _.map(
      details
      (detail) ->
        label: detail.domain
        value: detail.count
        percentage: detail.count / this * 100
      countSum
    )
    @loadedDetails = details.length

  _fillViolation: (violation) =>
    @_fillDetails(violation.details) if violation.details?
    violation.domains = _.sortBy(violation.domains, 'count').reverse()
    max_value = if violation.domains.length > 0 then violation.domains[0].count else 0
    splitIndex = _.findIndex violation.domains, (domain) ->
      return domain.count < (0.12 * max_value)
    others = _.reduce violation.domains[splitIndex..], (others, domain) ->
      return {
        name: 'others'
        count: others.count + domain.count
      }
    @violation.domainsCount = violation.domains.length
    violation.domains = violation.domains[0..splitIndex - 1].concat(others) if others?
    @violation.domains = _.map(
      violation.domains
      (domain) -> {
        name: domain.name
        value: domain.count
        percentage: domain.count / this
      }
      max_value)
    @violation.label = violation.title
    @violation.pageCount = violation.total
    params =
      page_size: @pageSize
    @ViolationFcty.getViolations(@violationKey, params).then @_fillReviews, =>
      @loadedReviews = null
    @loadedViolation = @violation.domains.length

  updateReviews: (currentPage, pageSize) =>
    return if !currentPage? and !pageSize? and !@pageFilter?
    pageSize = if not pageSize then @pageSize
    params =
      page_size: pageSize
      current_page: currentPage
      page_filter: @pageFilter
    delete(@loadedReviews)
    @ViolationFcty.getViolations(@violationKey, params).then @_fillReviews, =>
      @loadedReviews = null

  watchScope: ->
    updateReviews = $.debounce 500, => @updateReviews()
    @scope.$watch('model.pageFilter', updateReviews)

angular.module('holmesApp')
  .controller 'ViolationCtrl', ($scope, $routeParams, ViolationFcty) ->
    $scope.model = new ViolationCtrl($scope, $routeParams.violationKey, ViolationFcty)
