'use strict'

angular.module('holmesApp')
  .directive('sidebar', () ->
    templateUrl: 'views/sidebar.html',
    restrict: 'E',
    scope: {},
    controller: ($scope, $location) ->
      $scope.workers = []

      for i in [25..1]
        $scope.workers.push(
          id: "Worker 2013012041203"
          position: i
          status: if i < 5 then "working" else "waiting"
          url: "http://www.globo.com"
        )

      $scope.getClass = (path) ->
        isActive = $location.path().trim() == path.trim()
        return "active" if isActive
        return "" unless isActive
  )
