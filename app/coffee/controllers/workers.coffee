'use strict'

angular.module('holmesApp')
  .controller 'WorkersCtrl', ($scope, Restangular, WebSocket) ->
    $scope.model = {}

    updateWorkers = ->
      Restangular.all('workers').getList().then((items) ->
        $scope.model.workers = items
      )

    updateWorkers()

    WebSocket.on((message) ->
      updateWorkers() if message.type == 'worker-status'
    )
