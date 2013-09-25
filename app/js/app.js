(function() {
  'use strict';
  angular.module('holmesApp', ['ngRoute', 'ngAnimate', 'ngResource']).config(function($routeProvider, $locationProvider) {
    $locationProvider.html5Mode(true);
    return $routeProvider.when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    }).when('/page', {
      templateUrl: 'views/page.html',
      controller: 'PageCtrl'
    }).otherwise({
      redirectTo: '/'
    });
  });

}).call(this);

/*
//@ sourceMappingURL=app.js.map
*/