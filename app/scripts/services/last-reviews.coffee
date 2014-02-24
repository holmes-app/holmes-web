'use strict'

angular.module('holmesApp')
  .factory 'LastReviewsFcty', (Restangular) ->
    Restangular.withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setBaseUrl(RestangularConfigurer.baseUrl + '/last-reviews')
