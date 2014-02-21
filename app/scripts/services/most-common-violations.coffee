'use strict'

angular.module('holmesApp')
  .factory 'MostCommonViolationsFcty', (Restangular) ->
    Restangular.withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setBaseUrl(RestangularConfigurer.baseUrl + '/most-common-violations')
