'use strict'

class WorkersCtrl
  constructor: (@scope, @WorkersFcty, @WebSocketFcty) ->
    @workers = []
    @activeWorkersPercentage = 0

    @getWorkers()

    @WebSocketFcty.on((message) =>
      @getWorkers() if message.type == 'worker-status'
    )

  _fillWorkers: (data) =>
    @workers = data
    @workerCount = @workers.length
    @activeWorkers = _.filter(@workers, {'working': true}).length
    @activeWorkersPercentage = @activeWorkers / @workerCount

  getWorkers: ->
    @WorkersFcty.getWorkers().then(@_fillWorkers)


angular.module('holmesApp')
  .controller 'WorkersCtrl',  ($scope, WorkersFcty, WebSocketFcty) ->
    $scope.model = new WorkersCtrl($scope, WorkersFcty, WebSocketFcty)
