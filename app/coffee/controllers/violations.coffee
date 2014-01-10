'use strict'

angular.module('holmesApp')
  .controller 'ViolationsCtrl', ($scope, Restangular, WebSocket) ->
    $scope.model = {}

    updateViolations = ->
      Restangular.all('violations').getList().then((items) ->
        $scope.model.violations = items
      )

    updateViolations()
