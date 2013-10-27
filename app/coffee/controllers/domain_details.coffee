'use strict'

angular.module('holmesApp')
  .controller 'DomainDetailsCtrl', ($scope, $routeParams, Restangular) ->
    $scope.model = {}

    $scope.model.domainDetails = Restangular.one('domains', $routeParams.domainName).get()
