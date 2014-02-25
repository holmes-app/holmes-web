'use strict'

angular.module('holmesApp')
  .factory 'NextJobsFcty', (Restangular) ->
    Restangular.withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setBaseUrl(RestangularConfigurer.baseUrl + '/next-jobs')
