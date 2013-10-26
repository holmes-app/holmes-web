'use strict'

angular.module('holmesApp')
  .controller 'DomainsCtrl', ($scope, Restangular) ->
    $scope.model = {}

    $scope.model.domains = Restangular.all('domains').getList()
