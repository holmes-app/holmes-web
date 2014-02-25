'use strict'

angular.module('holmesApp')
  .factory 'LastRequestsFcty', (Restangular) ->
    Restangular.withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setBaseUrl(RestangularConfigurer.baseUrl + '/last-requests')
