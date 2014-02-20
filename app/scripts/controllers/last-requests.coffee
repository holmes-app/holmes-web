'use strict'

class LastRequestsCtrl
  constructor: (@scope) ->

angular.module('holmesApp')
  .controller 'LastRequestsCtrl', ($scope) ->
    $scope.model = new LastRequestsCtrl($scope)
