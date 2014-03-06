'use strict'

class ConcurrentRequestsCtrl
  constructor: (@scope) ->
    @limiters = []

    for i in [1..20]
      percentage = Math.random()
      max = Math.floor(200 * percentage)

      @limiters.push(
        name: "http://g1.globo.com/economia/test-string-grande-para-limitador-#{ i }"
        concurrentRequestsPercentage: percentage
        concurrentRequests: Math.floor(max * 0.8)
        maxConcurrentRequests: max
      )


angular.module('holmesApp')
  .controller 'ConcurrentCtrl', ($scope) ->
    $scope.model = new ConcurrentRequestsCtrl($scope)
