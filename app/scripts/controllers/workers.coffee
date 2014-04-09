'use strict'

class WorkersCtrl
  constructor: (@scope, @WorkersFcty, @WebSocketFcty) ->
    @workers = []
    @activeWorkersPercentage = 0

    @scope.$on '$destroy', @_cleanUp

    @WorkersFcty.listen(@getWorkers)


  _cleanUp: =>
    @WorkersFcty.stopListen()

  _fillWorkers: (activeWorkers, idleWorkers) =>
    @workers = activeWorkers.concat(idleWorkers)
    @workerCount = @workers.length
    @activeWorkers = activeWorkers.length
    @activeWorkersPercentage = @activeWorkers / @workerCount
    @loadedWorkers = @workerCount

  getWorkers: (activeWorkers, idleWorkers) =>
    @_fillWorkers(activeWorkers, idleWorkers)

angular.module('holmesApp')
  .controller 'WorkersCtrl', ($scope, WorkersFcty, WebSocketFcty) ->
    $scope.model = new WorkersCtrl($scope, WorkersFcty, WebSocketFcty)
