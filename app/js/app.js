(function() {
  'use strict';
  angular.module('holmesApp', ['ngRoute', 'ngAnimate', 'ngResource', 'angular-growl', 'restangular', 'angularMoment', 'HolmesConfig', 'WebSocketService']).config(function($routeProvider, $locationProvider, RestangularProvider, growlProvider, baseUrl, wsUrl, timeToLive) {
    $routeProvider.when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    }).when('/domains', {
      templateUrl: 'views/domains.html',
      controller: 'DomainsCtrl'
    }).when('/domains/:domainName', {
      templateUrl: 'views/domain_details.html',
      controller: 'DomainDetailsCtrl'
    }).when('/pages/:pageId/reviews/:reviewId', {
      templateUrl: 'views/report.html',
      controller: 'ReportCtrl'
    });
    RestangularProvider.setBaseUrl(baseUrl);
    return growlProvider.globalTimeToLive(timeToLive);
  });

}).call(this);

/*
//@ sourceMappingURL=app.js.map
*/