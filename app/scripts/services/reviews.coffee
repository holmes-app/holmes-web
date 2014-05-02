'use strict'

class ReviewsFactory
  constructor: (@restangular, @WebSocketFcty) ->

  getReview: (pageId, reviewId) ->
    @restangular.one('page', pageId).one('review', reviewId).get()

  getPageReviews: (pageId) ->
    @restangular.one('page', pageId).all('reviews').getList().$object

angular.module('holmesApp')
  .factory 'ReviewsFcty', (Restangular, WebSocketFcty) ->
    return new ReviewsFactory(Restangular, WebSocketFcty)
