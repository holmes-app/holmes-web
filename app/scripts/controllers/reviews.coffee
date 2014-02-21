'use strict'

class ReviewsCtrl
  constructor: (@scope, @sce, @ReviewsFcty, @pageId, @reviewId) ->
    @factsVisible = false
    @violationsVisible = true

    @getReviewDetails()
    @getReviews()

  showFacts: ->
    @factsVisible = true
    @violationsVisible = false

  showViolations: ->
    @factsVisible = false
    @violationsVisible = true

  getReviewDetails: ->
    @ReviewsFcty.one(@pageId).one('review', @reviewId).get().then( (data) =>
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

      console.log(@violations)

      @facts = _.groupBy(data.facts, 'category')
    )

  getReviews: ->
    @reviews = @ReviewsFcty.one(@pageId).one('reviews').getList().$object

  asHtml: (text) ->
    @sce.trustAsHtml(text)


angular.module('holmesApp')
  .controller 'ReviewsCtrl', ($scope, $sce, $routeParams, ReviewsFcty) ->
    pageId = $routeParams.pageId
    reviewId = $routeParams.reviewId

    $scope.model = new ReviewsCtrl($scope, $sce, ReviewsFcty, pageId, reviewId)
