'use strict'

class LastReviewsFactory
  constructor: (@restangular) ->

  getLastReviews: ->
    @restangular.one('last-reviews').get()

  getReviewsInLastHour: ->
    @restangular.one('reviews-in-last-hour').get()


angular.module('holmesApp')
  .factory 'LastReviewsFcty', (Restangular) ->
    return new LastReviewsFactory(Restangular)
