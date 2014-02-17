'use strict'

angular.module('holmesApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        redirectTo: '/domains'
      .when '/domains',
        templateUrl: 'views/domains.html'
        controller: 'DomainsCtrl'
      .when '/domains/:domainId',
        templateUrl: 'views/domain.html'
        controller: 'DomainCtrl'
      .when '/domains/:domainId/reviews/:reviewId',
        templateUrl: 'views/reviews.html'
        controller: 'ReviewsCtrl'
      .otherwise
        redirectTo: '/'
