'use strict'

class APIVersionFactory
  constructor: (@restangular) ->

  getAPIVersion: ->
    @restangular.one('version').get()


angular.module('holmesApp')
  .factory 'APIVersionFcty', (Restangular) ->
    return new APIVersionFactory(Restangular)

