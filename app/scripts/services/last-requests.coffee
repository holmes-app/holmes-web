'use strict'

class LastRequestsFactory
  constructor: (@restangular) ->

  getLastRequests: (params) ->
    @restangular.one('last-requests').get(params)


angular.module('holmesApp')
  .factory 'LastRequestsFcty', (Restangular) ->
    return new LastRequestsFactory(Restangular)
