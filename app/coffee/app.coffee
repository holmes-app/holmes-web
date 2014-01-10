'use strict'

angular.module('holmesApp', ['ngRoute', 'ngAnimate', 'ngResource', 'angular-growl', 'restangular', 'angularMoment', 'HolmesConfig', 'WebSocketService'])
  .config ($routeProvider, $locationProvider, RestangularProvider, growlProvider, baseUrl, wsUrl, timeToLive) ->
    #$locationProvider.html5Mode(true)

    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/domains',
        templateUrl: 'views/domains.html'
        controller: 'DomainsCtrl'
      .when '/domains/:domainName',
        templateUrl: 'views/domain_details.html'
        controller: 'DomainDetailsCtrl'
      .when '/pages/:pageId/reviews/:reviewId',
        templateUrl: 'views/report.html'
        controller: 'ReportCtrl',
      .when '/workers',
        templateUrl: 'views/workers.html'
        controller: 'WorkersCtrl'
      .when '/violations',
        templateUrl: 'views/violations.html'
        controller: 'ViolationsCtrl'
      .when '/violations/:keyName',
        templateUrl: 'views/violation.html'
        controller: 'ViolationCtrl'

    RestangularProvider.setBaseUrl(baseUrl)

    growlProvider.globalTimeToLive(timeToLive)

    #WebSocketProvider
      #.prefix('')
      #.url(wsUrl)
