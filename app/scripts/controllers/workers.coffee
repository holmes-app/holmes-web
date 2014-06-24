'use strict'

class WorkersCtrl
  constructor: (@scope, @WorkersFcty, @WebSocketFcty, @location) ->
    if @scope.isLoggedIn
      @workers = []
      @activeWorkersPercentage = 0
      @activeWorkers = []
      @loadedWorkers = false

      @scope.$on '$destroy', @_cleanUp

      @WorkersFcty.listen(@getWorkers)
    else
      @location.path '/login'


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
  .controller 'WorkersCtrl', ($scope, WorkersFcty, WebSocketFcty, $location) ->
    $scope.model = new WorkersCtrl($scope, WorkersFcty, WebSocketFcty, $location)
