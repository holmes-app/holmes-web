'use strict'

angular.module('holmesApp', ['ngRoute', 'ngAnimate', 'ngResource', 'angular-growl', 'restangular', 'angularMoment'])
  .config ($routeProvider, $locationProvider, RestangularProvider, growlProvider) ->
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
      .when '/pages/:pageId',
        templateUrl: 'views/report.html'
        controller: 'ReportCtrl'

    RestangularProvider.setBaseUrl('http://local.holmes.com:2368/')

    growlProvider.globalTimeToLive(3000);
