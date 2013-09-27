(function() {
  'use strict';
  angular.module('holmesApp', ['ngRoute', 'ngAnimate', 'ngResource']).config(function($routeProvider, $locationProvider) {
    return $routeProvider.when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    }).when('/page', {
      templateUrl: 'views/page.html',
      controller: 'PageCtrl'
    }).when('/page/:domainId', {
      templateUrl: 'views/report.html',
      controller: 'ReportCtrl'
    });
  });

}).call(this);

/*
//@ sourceMappingURL=app.js.map
*/