'use strict'

class WorkersCtrl
  constructor: (@scope) ->
    @activeWorkersPercentage = 0.9
    @activeWorkers = []
    @workerCount = 20

    for i in [1..16]
      @activeWorkers.push(
        id: i
        domain:
          name: 'g1.globo.com'
        url: 'http://mentakingup2muchspaceonthetrain.tumblr.com/'
        lastPing: '2014-02-16T18:42:50Z'
      )


angular.module('holmesApp')
  .controller 'WorkersCtrl', ($scope, $timeout) ->
    $scope.model = new WorkersCtrl($scope)

    randomizePercentage = ->
      percentage = Math.random()
      console.log percentage
      $scope.model.activeWorkersPercentage = percentage
      $timeout(randomizePercentage, 1000)

    randomizePercentage()
