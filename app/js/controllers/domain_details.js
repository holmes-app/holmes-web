(function() {
  'use strict';
  angular.module('holmesApp').controller('DomainDetailsCtrl', function($scope, $routeParams, Restangular, WebSocket) {
    var isValidDate, updateDomainDetails, updatePager, updatePercentage, updateReviews;
    isValidDate = function(d) {
      if (Object.prototype.toString.call(d) !== "[object Date]") {
        return false;
      }
      return !isNaN(d.getTime());
    };
    $scope.getClass = function(pageIndex) {
      if (pageIndex === $scope.model.currentPage) {
        return 'active';
      }
      if (pageIndex !== $scope.model.currentPage) {
        return '';
      }
    };
    $scope.model = {
      domainDetails: {
        name: $routeParams.domainName,
        url: '',
        pageCount: 0,
        numberofPages: 0,
        violationCount: 0,
        violationPoints: 0
      },
      pageCount: 0,
      currentPage: 1,
      numberOfPages: 0,
      reviewedPercentage: 0.0,
      pages: []
    };
    updatePercentage = function() {
      return $scope.model.reviewedPercentage = Math.round(($scope.model.pageCount / $scope.model.domainDetails.pageCount * 100) * 100) / 100;
    };
    updateDomainDetails = function() {
      return Restangular.one('domains', $routeParams.domainName).get().then(function(domainDetails) {
        $scope.model.domainDetails = domainDetails;
        updatePercentage();
        return updatePager(domainDetails);
      });
    };
    updatePager = function(domainData) {
      var i, _i, _ref, _ref1, _results;
      if (domainData != null) {
        $scope.model.numberOfPages = Math.ceil(domainData.reviewCount / 10);
        $scope.model.pageCount = domainData.pageCount;
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
    updateReviews = function() {
      return Restangular.one('domains', $routeParams.domainName).getList('reviews', {
        current_page: $scope.model.currentPage
      }).then(function(domainData) {
        $scope.model.pages = domainData.pages;
        return updatePercentage();
      });
    };
    updateDomainDetails();
    updateReviews();
    WebSocket.on(function(message) {
      if (message.type === 'new-page' || message.type === 'new-review') {
        updateDomainDetails();
        return updateReviews();
      }
    });
    return $scope.goToReviewPage = function(pageIndex) {
      $scope.model.currentPage = pageIndex;
      updateReviews();
      return updatePager();
    };
  });

}).call(this);

/*
//@ sourceMappingURL=domain_details.js.map
*/