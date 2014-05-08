'use strict'

class LimitersFactory
  constructor: (@restangular, @cookieStore) ->

  getLimiters: (params) ->
    @restangular.one('limiters').get(params)

  postLimiters: (data) ->
    @restangular.all('limiters').post(data, {}, {'X-AUTH-HOLMES': @cookieStore.get('HOLMES_AUTH_TOKEN')})

  deleteLimiter: (limiter) ->
    @restangular.one('limiters', limiter.id).remove({}, {'X-AUTH-HOLMES': @cookieStore.get('HOLMES_AUTH_TOKEN')})


angular.module('holmesApp')
  .factory 'LimitersFcty', (Restangular, $cookieStore) ->
    return new LimitersFactory(Restangular, $cookieStore)
