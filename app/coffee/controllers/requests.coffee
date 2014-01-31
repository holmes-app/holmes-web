'use strict'

angular.module('holmesApp')
  .controller 'RequestDomainCtrl', ($scope, $routeParams, Restangular, WebSocket) ->

    $scope.getClass = (pageIndex) ->
      return 'active' if pageIndex == $scope.model.currentPage
      return '' unless pageIndex == $scope.model.currentPage

    $scope.model = {
      domainName: $routeParams.domainName,
      statusCode: $routeParams.statusCode,
      statusCodeTitle: '',
      requestsDetails: {
        url: '',
        review_url: '',
        completed_date: ''
      },
      requestsCount: 0,
      currentPage: 1,
      numberOfPages: 0,
      requests: []
    }

    updateRequestsDetails = ->
      Restangular.one('domains', $routeParams.domainName).one('requests', $routeParams.statusCode).get({current_page: $scope.model.currentPage}).then((requestsDetails) ->
        $scope.model.requests = requestsDetails.requests
        $scope.model.statusCodeTitle = requestsDetails.statusCodeTitle
        updatePager(requestsDetails)
      )

    updatePager = (domainData) ->
        if domainData?
          $scope.model.numberOfPages = Math.ceil(domainData.requestsCount / 10)

        $scope.model.nextPages = [1 .. 10] if $scope.model.currentPage < 6

        $scope.model.prevPage = Math.max(1, $scope.model.currentPage - 5)
        $scope.model.nextPage = Math.max(6, Math.min($scope.model.numberOfPages, $scope.model.currentPage + 5))

        if $scope.model.currentPage >= 6
          $scope.model.nextPages = []

          for i in [$scope.model.currentPage - 4 .. $scope.model.currentPage + 4] by 1
            $scope.model.nextPages.push(i)

    $scope.goToRequestPage = (pageIndex) ->
      console.log(pageIndex)
      $scope.model.currentPage = pageIndex
      updateRequestsDetails()
      updatePager()

    updateRequestsDetails()
    updatePager()
