'use strict'

class LastReviewsFactory
  constructor: (@restangular) ->

  getLastReviews: (params) ->
    @restangular.one('last-reviews').get(params)

  getReviewsInLastHour: (params) ->
    @restangular.one('reviews-in-last-hour').get(params)


angular.module('holmesApp')
  .factory 'LastReviewsFcty', (Restangular) ->
    return new LastReviewsFactory(Restangular)
