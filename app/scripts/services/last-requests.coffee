'use strict'

class LastRequestsFactory
  constructor: (@restangular) ->

  getLastRequests: (params) ->
    @restangular.one('last-requests').get(params)

  getRequestsInLastDay: ->
    @restangular.one('requests-in-last-day').getList()


angular.module('holmesApp')
  .factory 'LastRequestsFcty', (Restangular) ->
    return new LastRequestsFactory(Restangular)
