'use strict'

angular.module('holmesApp')
  .directive('sidebar', () ->
    templateUrl: 'views/sidebar.html',
    restrict: 'E',
    scope: {},
    controller: ($scope, Restangular, $location, $timeout, growl) ->
      $scope.model =
        term: ''

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

      $scope.search = ->
        term = $scope.model.term
        Restangular.all('search').getList({term: term}).then((pages) ->
          if pages.length == 0
            growl.addErrorMessage("Page with URL " + term + " was not found!")
          else
            $location.path('/pages/' + pages[0].uuid + '/reviews/' + pages[0].reviewId)

          $scope.model.term = ''
        )
  )
