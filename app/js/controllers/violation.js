(function() {
  'use strict';
  angular.module('holmesApp').controller('ViolationCtrl', function($scope, $routeParams, Restangular, WebSocket) {
    var updatePager, updateViolation;
    $scope.model = {
      currentPage: 1,
      numberOfPages: 0
    };
    $scope.getClass = function(pageIndex) {
      if (pageIndex === $scope.model.currentPage) {
        return 'active';
      }
      if (pageIndex !== $scope.model.currentPage) {
        return '';
      }
    };
    updateViolation = function() {
      return Restangular.one('violation', $routeParams.keyName).get({
        current_page: $scope.model.currentPage
      }).then(function(items) {
        $scope.model.violation = items;
        return updatePager(items);
      });
    };
    updatePager = function(domainData) {
      var i, _i, _ref, _ref1, _results;
      if (domainData != null) {
        $scope.model.numberOfPages = Math.ceil(domainData.reviewCount / 10);
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
    $scope.goToReviewPage = function(pageIndex) {
      $scope.model.currentPage = pageIndex;
      updatePager();
      return updateViolation();
    };
    return updateViolation();
  });

}).call(this);

/*
//@ sourceMappingURL=violation.js.map
*/