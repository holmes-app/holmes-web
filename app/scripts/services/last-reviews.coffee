'use strict'

class LastReviewsFactory
  constructor: (@restangular) ->

  getLastReviews: ->
    @restangular.one('last-reviews').get()


angular.module('holmesApp')
  .factory 'LastReviewsFcty', (Restangular) ->
    return new LastReviewsFactory(Restangular)
