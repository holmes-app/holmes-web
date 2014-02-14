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
        #templateUrl: 'views/main.html'
        #controller: 'MainCtrl'
      .when '/domains',
        templateUrl: 'views/domains.html'
        controller: 'DomainsCtrl'
      .when '/domains/:domainId',
        templateUrl: 'views/domain.html'
        controller: 'DomainCtrl'
      .otherwise
        redirectTo: '/'
