'use strict'

class WorkersFactory
  constructor: (@restangular) ->

  getWorkers: ->
    @restangular.all('workers').getList()


angular.module('holmesApp')
  .factory 'WorkersFcty', (Restangular) ->
    return new WorkersFactory(Restangular)
