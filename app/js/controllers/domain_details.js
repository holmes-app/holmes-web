(function() {
  'use strict';
  angular.module('holmesApp').controller('DomainDetailsCtrl', function($scope, $routeParams, Restangular, WebSocket) {
    var isValidDate, throttled, updateDomainDetails, updatePager, updatePercentage, updateReviews;
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
        violationPoints: 0,
        is_active: true,
        statusCodeInfo: []
      },
      pageCount: 0,
      currentPage: 1,
      numberOfPages: 0,
      reviewedPercentage: 0.0,
      pages: [],
      reviewFilter: '',
      numberOfRequests: 0
    };
    updatePercentage = function() {
      return $scope.model.reviewedPercentage = Math.round(($scope.model.pageCount / $scope.model.domainDetails.pageCount * 100) * 100) / 100;
    };
    updateDomainDetails = function() {
      return Restangular.one('domains', $routeParams.domainName).get().then(function(domainDetails) {
        var i, _i, _j, _len, _len1, _ref, _ref1;
        _ref = domainDetails.statusCodeInfo;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          i = _ref[_i];
          $scope.model.numberOfRequests += i.total;
        }
        _ref1 = domainDetails.statusCodeInfo;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          i = _ref1[_j];
          i['percentage'] = parseFloat(i.total * 100 / $scope.model.numberOfRequests).toFixed(4);
        }
        console.log(domainDetails.statusCodeInfo);
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
        current_page: $scope.model.currentPage,
        term: $scope.model.reviewFilter
      }).then(function(domainData) {
        $scope.model.pages = domainData.pages;
        updatePercentage();
        return updatePager(domainData);
      });
    };
    updateDomainDetails();
    updateReviews();
    throttled = $.debounce(500, function() {
      return updateReviews();
    });
    $scope.$watch('model.reviewFilter', throttled);
    WebSocket.on(function(message) {
      if (message.type === 'new-page' || message.type === 'new-review') {
        updateDomainDetails();
        return updateReviews();
      }
    });
    $scope.changeDomainStatus = function() {
      return Restangular.one('domains', $routeParams.domainName).post('change-status').then(updateDomainDetails());
    };
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