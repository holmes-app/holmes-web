'use strict'

angular.module('holmesApp')
  .factory 'ReviewsFcty', (Restangular) ->
    Restangular.withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setBaseUrl(RestangularConfigurer.baseUrl + '/page')
