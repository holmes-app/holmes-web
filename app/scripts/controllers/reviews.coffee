'use strict'

class ReviewsCtrl
  constructor: (@scope, @sce, @ReviewsFcty, @pageId, @reviewId, @location) ->
    if @location.hash() == 'facts'
      @showFacts()
    else
      @showViolations()

    @getReviewDetails()
    @getReviews()

  showFacts: ->
    @factsVisible = true
    @violationsVisible = false
    @location.url('#facts')

  showViolations: ->
    @factsVisible = false
    @violationsVisible = true
    @location.url('#violations')

  getReviewDetails: ->
    @ReviewsFcty.getReview(@pageId, @reviewId).then( (data) =>
      @review_details = data
      violations_by_category = _.toArray(_.groupBy(data.violations, 'category'))
      @violations = _.map(
        violations_by_category,
        (obj) ->
          return {
            'label': obj[0].category + ' violations',
            'violations': _.toArray(obj),
            'value': obj.length * 100 / this.violationCount,
            'percentage': 10,
            'violationCount': 10
          }
        data
      )

      @facts = _.groupBy(data.facts, 'category')
    )

  getReviews: ->
    @reviews = @ReviewsFcty.getPageReviews(@pageId)

  asHtml: (text) ->
    @sce.trustAsHtml(text)


angular.module('holmesApp')
  .controller 'ReviewsCtrl', ($scope, $sce, $routeParams, ReviewsFcty, $location) ->
    pageId = $routeParams.pageId
    reviewId = $routeParams.reviewId

    $scope.model = new ReviewsCtrl($scope, $sce, ReviewsFcty, pageId, reviewId, $location)
