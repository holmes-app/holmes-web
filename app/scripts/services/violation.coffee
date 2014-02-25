'use strict'

angular.module('holmesApp')
  .factory 'ViolationFcty', (Restangular) ->
    Restangular.withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setBaseUrl(RestangularConfigurer.baseUrl + '/violation')
