'use strict'

angular.module('holmesApp', ['ngRoute', 'ngAnimate', 'ngResource', 'angular-growl', 'restangular'])
  .config ($routeProvider, $locationProvider, RestangularProvider, growlProvider) ->
    #$locationProvider.html5Mode(true)

    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/page',
        templateUrl: 'views/page.html'
        controller: 'PageCtrl'
      .when '/page/:domainId',
        templateUrl: 'views/report.html'
        controller: 'ReportCtrl'

    RestangularProvider.setBaseUrl('http://local.holmes.com:2368/')

    growlProvider.globalTimeToLive(3000);
