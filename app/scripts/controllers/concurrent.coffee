'use strict'

class ConcurrentRequestsCtrl
  constructor: (@scope, @timeout) ->
    @isFormVisible = false
    @limiters = []

    for i in [1..20]
      percentage = Math.random()
      max = Math.floor(200 * percentage)

      @limiters.push(
        name: "http://g1.globo.com/economia/test-string-grande-para-limitador-#{ i }"
        concurrentRequestsPercentage: percentage
        concurrentRequests: Math.floor(max * 0.8)
        maxConcurrentRequests: max
        isCurrentValueVisible: false
      )

    @newLimitConcurrentConnections = 5

    @scope.$watch('model.newLimitConcurrentConnections', (newValue, oldValue) =>
      newValue = parseInt(newValue, 10)
      @newLimitConcurrentConnections = 200 if newValue > 200
    , true)

  toggleFormVisibility: ->
    @isFormVisible = not @isFormVisible

  saveNewLimit: (limiter) ->
    # TODO: save the new value in Holmes API

    limiter.isCurrentValueVisible = true

    @timeout.cancel(limiter.currentTimer) if limiter.currentTimer?

    limiter.currentTimer = @timeout(->
      limiter.isCurrentValueVisible = false
      limiter.currentTimer = null
    , 1000)


angular.module('holmesApp')
  .controller 'ConcurrentCtrl', ($scope, $timeout) ->
    $scope.model = new ConcurrentRequestsCtrl($scope, $timeout)
