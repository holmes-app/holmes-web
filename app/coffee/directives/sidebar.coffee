'use strict'

angular.module('holmesApp')
  .directive('sidebar', () ->
    templateUrl: 'views/sidebar.html',
    restrict: 'E',
    scope: {},
    controller: ($scope, Restangular, $location, $timeout) ->
      getWorkers = ->
        Restangular.one('workers').getList().then((activeWorkers) ->
          $scope.workers = activeWorkers
        )

      $timeout(getWorkers, 5000)

      $scope.mostCommonViolations = [
        { name: "Javascript total size is too big", count: 948},
        { name: "Missing opengraph", count: 19245 },
        { name: "Too many elements in page", count: 4203},
        { name: "Invalid HTML", count: 10234 },
        { name: "Missing description metadata in header", count: 7429},
        { name: "No sitemap", count: 23049 },
        { name: "Too many requests", count: 2023},
      ]

      $scope.getClass = (path) ->
        isActive = $location.path().trim() == path.trim()
        return "active" if isActive
        return "" unless isActive
  )
