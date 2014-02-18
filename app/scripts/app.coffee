'use strict'

app = angular.module('holmesApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'angularMoment'
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
      .when '/violations/:violationKey',
        templateUrl: 'views/violation.html'
        controller: 'ViolationCtrl'
      .otherwise
        redirectTo: '/'
