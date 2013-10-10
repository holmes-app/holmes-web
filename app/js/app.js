(function() {
  'use strict';
  angular.module('holmesApp', ['ngRoute', 'ngAnimate', 'ngResource', 'angular-growl', 'restangular']).config(function($routeProvider, $locationProvider, RestangularProvider, growlProvider) {
    $routeProvider.when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    }).when('/page', {
      templateUrl: 'views/page.html',
      controller: 'PageCtrl'
    }).when('/page/:domainId', {
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