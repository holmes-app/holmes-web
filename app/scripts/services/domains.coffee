'use strict'

angular.module('holmesApp')
  .factory 'DomainsFcty', (Restangular) ->
    Restangular.withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setBaseUrl(RestangularConfigurer.baseUrl + '/domains')
