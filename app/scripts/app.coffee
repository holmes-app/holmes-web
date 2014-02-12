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
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/domains',
        templateUrl: 'views/domains.html'
        controller: 'DomainsCtrl'
      .otherwise
        redirectTo: '/'
