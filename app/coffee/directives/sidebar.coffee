'use strict'

angular.module('holmesApp')
  .directive('sidebar', () ->
    templateUrl: 'views/sidebar.html',
    restrict: 'E',
    scope: {},
    controller: ($scope, Restangular, $location, $timeout) ->
      $scope.model = {}

      $scope.model.workers = []
      getWorkers = ->
        Restangular.one('workers').getList().then((activeWorkers) ->
          $scope.model.workers = activeWorkers
        )
        $timeout(getWorkers, 2000)

      getWorkers()

      $scope.model.mostCommonViolations = []
      getMostCommonViolations = ->
        Restangular.one('most-common-violations').getList().then((violations) ->
          $scope.model.mostCommonViolations = violations
        )
        $timeout(getMostCommonViolations, 2000)

      getMostCommonViolations()

      $scope.getClass = (path) ->
        isActive = $location.path().trim() == path.trim()
        return "active" if isActive
        return "" unless isActive
  )
