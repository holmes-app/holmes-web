'use strict'

angular.module('holmesApp')
  .controller 'ViolationCtrl', ($scope, $routeParams, Restangular, WebSocket) ->
    $scope.model = {
      currentPage: 1,
      numberOfPages: 0
    }

    $scope.getClass = (pageIndex) ->
      return 'active' if pageIndex == $scope.model.currentPage
      return '' unless pageIndex == $scope.model.currentPage

    updateViolation = ->
      Restangular.one('violation', $routeParams.keyName).get(current_page: $scope.model.currentPage).then((items) ->
        $scope.model.violation = items
        updatePager(items)
      )

    updatePager = (domainData) ->
        if domainData?
          $scope.model.numberOfPages = Math.ceil(domainData.reviewCount / 10)

        $scope.model.nextPages = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] if $scope.model.currentPage < 6

        $scope.model.prevPage = Math.max(1, $scope.model.currentPage - 5)
        $scope.model.nextPage = Math.max(6, Math.min($scope.model.numberOfPages, $scope.model.currentPage + 5))

        if $scope.model.currentPage >= 6
          $scope.model.nextPages = []

          for i in [$scope.model.currentPage - 4 .. $scope.model.currentPage + 4] by 1
            $scope.model.nextPages.push(i)

    $scope.goToReviewPage = (pageIndex) ->
      $scope.model.currentPage = pageIndex
      updatePager()
      updateViolation()

    updateViolation()
