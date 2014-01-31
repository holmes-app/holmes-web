(function() {
  'use strict';
  angular.module('holmesApp').controller('RequestDomainCtrl', function($scope, $routeParams, Restangular, WebSocket) {
    var updatePager, updateRequestsDetails;
    $scope.getClass = function(pageIndex) {
      if (pageIndex === $scope.model.currentPage) {
        return 'active';
      }
      if (pageIndex !== $scope.model.currentPage) {
        return '';
      }
    };
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
    };
    updateRequestsDetails = function() {
      return Restangular.one('domains', $routeParams.domainName).one('requests', $routeParams.statusCode).get({
        current_page: $scope.model.currentPage
      }).then(function(requestsDetails) {
        $scope.model.requests = requestsDetails.requests;
        $scope.model.statusCodeTitle = requestsDetails.statusCodeTitle;
        return updatePager(requestsDetails);
      });
    };
    updatePager = function(domainData) {
      var i, _i, _ref, _ref1, _results;
      if (domainData != null) {
        $scope.model.numberOfPages = Math.ceil(domainData.requestsCount / 10);
      }
      if ($scope.model.currentPage < 6) {
        $scope.model.nextPages = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      }
      $scope.model.prevPage = Math.max(1, $scope.model.currentPage - 5);
      $scope.model.nextPage = Math.max(6, Math.min($scope.model.numberOfPages, $scope.model.currentPage + 5));
      if ($scope.model.currentPage >= 6) {
        $scope.model.nextPages = [];
        _results = [];
        for (i = _i = _ref = $scope.model.currentPage - 4, _ref1 = $scope.model.currentPage + 4; _i <= _ref1; i = _i += 1) {
          _results.push($scope.model.nextPages.push(i));
        }
        return _results;
      }
    };
    $scope.goToRequestPage = function(pageIndex) {
      console.log(pageIndex);
      $scope.model.currentPage = pageIndex;
      updateRequestsDetails();
      return updatePager();
    };
    updateRequestsDetails();
    return updatePager();
  });

}).call(this);

/*
//@ sourceMappingURL=requests.js.map
*/