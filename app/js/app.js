(function() {
  'use strict';
  angular.module('holmesApp', ['ngRoute', 'ngAnimate', 'ngResource', 'angular-growl', 'restangular', 'angularMoment', 'HolmesConfig', 'WebSocketService', 'directive.g+signin', 'ngCookies']).config(function($routeProvider, $locationProvider, RestangularProvider, growlProvider, baseUrl, wsUrl, timeToLive) {
    $routeProvider.when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    }).when('/domains', {
      templateUrl: 'views/domains.html',
      controller: 'DomainsCtrl'
    }).when('/domains/:domainName', {
      templateUrl: 'views/domain_details.html',
      controller: 'DomainDetailsCtrl'
    }).when('/domains/:domainName/requests/:statusCode', {
      templateUrl: 'views/requests.html',
      controller: 'RequestDomainCtrl'
    }).when('/pages/:pageId/reviews/:reviewId', {
      templateUrl: 'views/report.html',
      controller: 'ReportCtrl'
    }).when('/workers', {
      templateUrl: 'views/workers.html',
      controller: 'WorkersCtrl'
    }).when('/violations', {
      templateUrl: 'views/violations.html',
      controller: 'ViolationsCtrl'
    }).when('/violations/:keyName', {
      templateUrl: 'views/violation.html',
      controller: 'ViolationCtrl'
    }).when('/delimiters', {
      templateUrl: 'views/delimiter.html',
      controller: 'DelimiterCtrl'
    });
    RestangularProvider.setBaseUrl(baseUrl);
    return growlProvider.globalTimeToLive(timeToLive);
  });

}).call(this);

/*
//@ sourceMappingURL=app.js.map
*/