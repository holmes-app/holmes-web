'use strict'

class WorkersCtrl
  constructor: (@scope, @WorkersFcty, @WebSocketFcty) ->
    @workers = []
    @activeWorkersPercentage = 0

    @getWorkers()

    @WebSocketFcty.on((message) =>
      @getWorkers() if message.type == 'worker-status'
    )


  getWorkers: ->
    @WorkersFcty.all('').getList().then( (data) =>
      @workers = data
      @workerCount = @workers.length
      @activeWorkers = _.filter(@workers, {'working': true}).length
      @activeWorkersPercentage = @activeWorkers / @workerCount
    )


angular.module('holmesApp')
  .controller 'WorkersCtrl',  ($scope, WorkersFcty, WebSocketFcty) ->
    $scope.model = new WorkersCtrl($scope, WorkersFcty, WebSocketFcty)
