'use strict'

class MostCommonViolationsFactory
  constructor: (@restangular) ->

  getMostCommonViolations: ->
    @restangular.all('most-common-violations').getList()


angular.module('holmesApp')
  .factory 'MostCommonViolationsFcty', (Restangular) ->
    return new MostCommonViolationsFactory(Restangular)
