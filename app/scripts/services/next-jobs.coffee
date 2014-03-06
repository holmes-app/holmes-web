'use strict'

class NextJobsFactory
  constructor: (@restangular) ->

  getNextJobs: (params) ->
    @restangular.one('next-jobs').get(params)


angular.module('holmesApp')
  .factory 'NextJobsFcty', (Restangular) ->
    return new NextJobsFactory(Restangular)
