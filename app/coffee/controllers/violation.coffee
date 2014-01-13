'use strict'

angular.module('holmesApp')
  .controller 'ViolationCtrl', ($scope, $routeParams, Restangular, WebSocket) ->
    $scope.model = {}

    updateViolation = ->
      Restangular.one('violation', $routeParams.keyName).get().then((items) ->
        $scope.model.violation = items
      )

    updateViolation()
