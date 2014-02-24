'use strict'

angular.module('holmesApp')
  .factory 'WorkersFcty', (Restangular) ->
    Restangular.withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setBaseUrl(RestangularConfigurer.baseUrl + '/workers')
