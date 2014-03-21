'use strict'

class ViolationCtrl
  constructor: (@scope, @violationKey, @ViolationFcty) ->
    @pageFilter = null
    @pageSize = 10
    @violation = {}
    @ViolationFcty.getDomainViolations(@violationKey).then(@_fillViolation)
    @watchScope()

  _fillReviews: (violation) =>
    @violation.reviews = violation.reviews
    @reviewsCount = violation.reviewsCount

  _fillViolation: (violation) =>
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
    @ViolationFcty.getViolations(@violationKey, params).then(@_fillReviews)

  updateReviews: (currentPage, pageSize) =>
    pageSize = if not pageSize then @pageSize
    params =
      page_size: pageSize
      current_page: currentPage
      page_filter: @pageFilter
    @ViolationFcty.getViolations(@violationKey, params).then(@_fillReviews)

  watchScope: ->
    updateReviews = $.debounce 500, => @updateReviews()
    @scope.$watch('model.pageFilter', updateReviews)

angular.module('holmesApp')
  .controller 'ViolationCtrl', ($scope, $routeParams, ViolationFcty) ->
    $scope.model = new ViolationCtrl($scope, $routeParams.violationKey, ViolationFcty)
