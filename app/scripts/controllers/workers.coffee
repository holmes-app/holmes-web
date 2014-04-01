'use strict'

class WorkersCtrl
  constructor: (@scope, @WorkersFcty, @WebSocketFcty) ->
    @workers = []
    @activeWorkersPercentage = 0

    @getWorkers()

    @WebSocketFcty.on((message) =>
      @getWorkers() if message.type == 'worker-status'
    )

    @scope.$on '$destroy', @_cleanUp

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillWorkers: (data) =>
    @workers = data
    @workerCount = @workers.length
    @activeWorkers = _.filter(@workers, {'working': true}).length
    @activeWorkersPercentage = @activeWorkers / @workerCount
    @loadedWorkers = true

  getWorkers: ->
    @WorkersFcty.getWorkers().then @_fillWorkers, =>
      @loadedWorkers = null


angular.module('holmesApp')
  .controller 'WorkersCtrl',  ($scope, WorkersFcty, WebSocketFcty) ->
    $scope.model = new WorkersCtrl($scope, WorkersFcty, WebSocketFcty)
