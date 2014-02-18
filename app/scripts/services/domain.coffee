'use strict'

angular.module('holmesApp')
  .factory 'DomainFcty', (Restangular) ->
    Restangular.withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setBaseUrl(RestangularConfigurer.baseUrl + '/domains')
