'use strict'

class ViolationCtrl
  constructor: (@scope, @violationKey, @ViolationFcty) ->
    @pageFilter = null
    @violation = {}
    @ViolationFcty.one(@violationKey).get({page_size: 10}).then(@_fillReviews)
    @ViolationFcty.one(@violationKey, 'domains').get('').then(@_fillViolation)
    @watchScope()

  _fillReviews: (violation) =>
    @violation.reviews = violation.reviews
    @reviewsCount = violation.reviewsCount

  _fillViolation: (violation) =>
    max_value = _.map(
      violation.domains
      (domain) -> domain.count).sort((x, y) -> x - y).pop()
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

  updateReviews: (currentPage, pageSize) =>
    @ViolationFcty.one(@violationKey).get({page_size: pageSize, current_page: currentPage, page_filter: @pageFilter}).then(@_fillReviews)

  watchScope: ->
    updateReviews = $.debounce 500, => @updateReviews()
    @scope.$watch('model.pageFilter', updateReviews)

angular.module('holmesApp')
  .controller 'ViolationCtrl', ($scope, $routeParams, ViolationFcty) ->
    $scope.model = new ViolationCtrl($scope, $routeParams.violationKey, ViolationFcty)
