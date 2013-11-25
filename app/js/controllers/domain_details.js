(function() {
  'use strict';
  var __hasProp = {}.hasOwnProperty;

  angular.module('holmesApp').controller('DomainDetailsCtrl', function($scope, $routeParams, Restangular, WebSocket) {
    var buildCharts, isValidDate, updateChartData, updateDomainDetails, updateReviews;
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
      currentPage: 1,
      numberOfPages: 0,
      pages: []
    };
    updateDomainDetails = function() {
      return Restangular.one('domains', $routeParams.domainName).get().then(function(domainDetails) {
        return $scope.model.domainDetails = domainDetails;
      });
    };
    updateReviews = function() {
      return Restangular.one('domains', $routeParams.domainName).getList('reviews', {
        current_page: $scope.model.currentPage
      }).then(function(domainData) {
        var i, _i, _ref, _ref1, _results;
        $scope.model.pageCount = domainData.pageCount;
        $scope.model.numberOfPages = Math.ceil(domainData.pageCount / 10);
        $scope.model.pages = domainData.pages;
        $scope.model.pagesWithoutReview = domainData.pagesWithoutReview;
        $scope.model.pagesWithoutReviewCount = domainData.pagesWithoutReviewCount;
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
      });
    };
    updateChartData = function() {
      return Restangular.one('domains', $routeParams.domainName).getList('violations-per-day').then(function(violations) {
        violations = violations.violations;
        return buildCharts(violations);
      });
    };
    buildCharts = function(violations) {
      var date, dt, obj, violationCount, violationCountData, violationPoints, violationPointsData;
      violationPoints = [];
      violationCount = [];
      for (date in violations) {
        if (!__hasProp.call(violations, date)) continue;
        obj = violations[date];
        dt = new Date(date);
        if (!isValidDate(dt)) {
          continue;
        }
        violationPoints.push({
          x: new Date(date),
          y: obj.violation_points
        });
        violationCount.push({
          x: new Date(date),
          y: obj.violation_count
        });
      }
      violationPointsData = [
        {
          values: violationPoints,
          key: 'Violation Points',
          color: '#ff7f0e'
        }
      ];
      violationCountData = [
        {
          values: violationCount,
          key: 'Violation Count',
          color: '#2ca02c'
        }
      ];
      nv.addGraph(function() {
        var chart;
        chart = nv.models.lineChart();
        chart.yAxis.tickFormat(d3.format('.02f'));
        chart.xAxis.tickFormat(function(d) {
          return (d3.time.format("%d-%b"))(new Date(d));
        });
        d3.select('#violation-count-chart svg').datum(violationCountData).transition().duration(500).call(chart);
        nv.utils.windowResize(function() {
          return d3.select('#violation-count-chart svg').call(chart);
        });
        return chart;
      });
      return nv.addGraph(function() {
        var chart;
        chart = nv.models.lineChart();
        chart.yAxis.tickFormat(d3.format('.02f'));
        chart.xAxis.tickFormat(function(d) {
          return (d3.time.format("%d-%b"))(new Date(d));
        });
        d3.select('#violation-points-chart svg').datum(violationPointsData).transition().duration(500).call(chart);
        nv.utils.windowResize(function() {
          return d3.select('#violation-points-chart svg').call(chart);
        });
        return chart;
      });
    };
    buildCharts([]);
    updateDomainDetails();
    updateReviews();
    updateChartData();
    WebSocket.on(function(message) {
      if (message.type === 'new-page' || message.type === 'new-review') {
        updateDomainDetails();
        updateReviews();
        return updateChartData();
      }
    });
    return $scope.goToReviewPage = function(pageIndex) {
      $scope.model.currentPage = pageIndex;
      updateReviews();
      return false;
    };
  });

}).call(this);

/*
//@ sourceMappingURL=domain_details.js.map
*/