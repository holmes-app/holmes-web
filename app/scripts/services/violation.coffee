'use strict'

class ViolationFactory
  constructor: (@restangular) ->

  getDomainViolations: (violationKey) ->
    @restangular.one('violation').one(violationKey, 'domains').get()

  getViolations: (violationKey, params) ->
    @restangular.one('violation').one(violationKey).get(params)


angular.module('holmesApp')
  .factory 'ViolationFcty', (Restangular) ->
    return new ViolationFactory(Restangular)
