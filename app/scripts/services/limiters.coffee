'use strict'

class LimitersFactory
  constructor: (@restangular, @cookieStore) ->

  getLimiters: ->
    @restangular.one('limiters').get()

  postLimiters: (data) ->
    @restangular.all('limiters').post(data, {}, {'X-AUTH-HOLMES': @cookieStore.get('HOLMES_AUTH_TOKEN')})


angular.module('holmesApp')
  .factory 'LimitersFcty', (Restangular, $cookieStore) ->
    return new LimitersFactory(Restangular, $cookieStore)
