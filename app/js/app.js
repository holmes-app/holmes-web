(function() {
  'use strict';
  angular.module('holmesApp', ['ngRoute', 'ngAnimate', 'ngResource', 'angular-growl', 'restangular', 'angularMoment']).config(function($routeProvider, $locationProvider, RestangularProvider, growlProvider) {
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
    RestangularProvider.setBaseUrl('http://local.holmes.com:2368/');
    return growlProvider.globalTimeToLive(3000);
  });

}).call(this);

/*
//@ sourceMappingURL=app.js.map
*/