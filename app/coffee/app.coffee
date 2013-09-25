'use strict'

angular.module('holmesApp', ['ngRoute', 'ngAnimate', 'ngResource'])
  .config ($routeProvider, $locationProvider) ->
    $locationProvider.html5Mode(true)

    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/page',
        templateUrl: 'views/page.html'
        controller: 'PageCtrl'
      .otherwise
        redirectTo: '/'
