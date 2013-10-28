'use strict'

angular.module('holmesApp')
  .controller 'DomainsCtrl', ($scope, Restangular, $timeout) ->
    $scope.model = {}

    updateDomains = ->
      Restangular.all('domains').getList().then((items) ->
        $scope.model.domains = items
      )
      $timeout(updateDomains, 2000)

    updateDomains()
