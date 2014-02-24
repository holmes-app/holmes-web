'use strict'

class WorkersCtrl
  constructor: (@scope, @WorkersFcty) ->
    @workers = []
    @activeWorkersPercentage = 0

    @getWorkers()


  getWorkers: ->
    @WorkersFcty.all('').getList().then( (data) =>
      @workers = data
      @workerCount = @workers.length
      @activeWorkers = _.filter(@workers, {'working': true}).length
      @activeWorkersPercentage = @activeWorkers / @workerCount
    )

angular.module('holmesApp')
  .controller 'WorkersCtrl',  ($scope, WorkersFcty) ->
    $scope.model = new WorkersCtrl($scope, WorkersFcty)

    #randomizePercentage = ->
      #percentage = Math.random()
      #console.log percentage
      #$scope.model.activeWorkersPercentage = percentage
      #$timeout(randomizePercentage, 1000)

    #randomizePercentage()
