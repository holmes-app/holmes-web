(function() {
  'use strict';
  var __hasProp = {}.hasOwnProperty;

  angular.module('holmesApp').controller('DomainDetailsCtrl', function($scope, $routeParams, Restangular, WebSocket) {
    var buildCharts, isValidDate, updateChartData, updateDomainDetails;
    isValidDate = function(d) {
      if (Object.prototype.toString.call(d) !== "[object Date]") {
        return false;
      }
      return !isNaN(d.getTime());
    };
    $scope.model = {
      domainDetails: {
        name: $routeParams.domainName,
        url: '',
        pageCount: 0,
        violationCount: 0,
        violationPoints: 0
      },
      pageCount: 0,
      pages: []
    };
    updateDomainDetails = function() {
      Restangular.one('domains', $routeParams.domainName).get().then(function(domainDetails) {
        return $scope.model.domainDetails = domainDetails;
      });
      return Restangular.one('domains', $routeParams.domainName).getList('reviews').then(function(domainData) {
        $scope.model.pageCount = domainData.pageCount;
        $scope.model.pages = domainData.pages;
        $scope.model.pagesWithoutReview = domainData.pagesWithoutReview;
        return $scope.model.pagesWithoutReviewCount = domainData.pagesWithoutReviewCount;
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
    updateChartData();
    return WebSocket.on(function(message) {
      if (message.type === 'new-page' || message.type === 'new-review') {
        updateDomainDetails();
        return updateChartData();
      }
    });
  });

}).call(this);

/*
//@ sourceMappingURL=domain_details.js.map
*/