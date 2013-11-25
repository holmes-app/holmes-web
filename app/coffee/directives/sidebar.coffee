'use strict'

angular.module('holmesApp')
  .directive('sidebar', () ->
    templateUrl: 'views/sidebar.html',
    restrict: 'E',
    scope: {},
    controller: ($scope, Restangular, $location, $timeout, growl, WebSocket) ->
      $scope.model =
        term: ''

      $scope.model.workers = []
      getWorkers = ->
        Restangular.one('workers').getList().then((activeWorkers) ->
          $scope.model.workers = activeWorkers
        )

      getWorkers()

      $scope.model.mostCommonViolations = []
      getMostCommonViolations = ->
        Restangular.one('most-common-violations').getList().then((violations) ->
          $scope.model.mostCommonViolations = violations
        )

      getMostCommonViolations()

      $scope.getClass = (path) ->
        isActive = $location.path().trim() == path.trim()
        return "active" if isActive
        return "" unless isActive

      $scope.search = ->
        term = $scope.model.term
        Restangular.all('search').getList({term: term}).then((page) ->
          if page == null or page == undefined
            growl.addErrorMessage("Page with URL " + term + " was not found or does not have any reviews associated with it!")
          else
            $location.path('/pages/' + page.uuid + '/reviews/' + page.reviewId)

          $scope.model.term = ''
        )

      WebSocket.on((message) ->
        getWorkers() if message.type == 'worker-status'
        getMostCommonViolations() if message.type == 'new-review'
      )

  )
