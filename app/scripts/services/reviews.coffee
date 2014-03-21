'use strict'

class ReviewsFactory
  constructor: (@restangular) ->

  getReview: (pageId, reviewId) ->
    @restangular.one('page', pageId).one('review', reviewId).get()

  getPageReviews: (pageId) ->
    @restangular.one('page', pageId).all('reviews').getList().$object

angular.module('holmesApp')
  .factory 'ReviewsFcty', (Restangular) ->
    return new ReviewsFactory(Restangular)
