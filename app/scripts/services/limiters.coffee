'use strict'

class LimitersFactory
  constructor: (@restangular) ->

  getLimiters: (params) ->
    @restangular.one('limiters').get(params)

  postLimiters: (data) ->
    @restangular.all('limiters').post(data)

  deleteLimiter: (limiter) ->
    @restangular.one('limiters', limiter.id).remove()


angular.module('holmesApp')
  .factory 'LimitersFcty', (Restangular) ->
    return new LimitersFactory(Restangular)
