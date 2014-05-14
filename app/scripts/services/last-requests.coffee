'use strict'

class LastRequestsFactory
  constructor: (@restangular) ->

  getLastRequests: (params) ->
    @restangular.one('last-requests').get(params)

  getRequestsInLastDay: (params) ->
    @restangular.one('requests-in-last-day').get(params)

  getStatusCode: ->
    @restangular.one('last-requests').one('status-code').get()


angular.module('holmesApp')
  .factory 'LastRequestsFcty', (Restangular) ->
    return new LastRequestsFactory(Restangular)
