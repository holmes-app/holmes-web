(function() {
  'use strict';
  var __hasProp = {}.hasOwnProperty;

  angular.module('holmesApp').controller('DomainDetailsCtrl', function($scope, $routeParams, Restangular, $timeout) {
    var buildCharts, isValidDate, updateDomainDetails;
    isValidDate = function(d) {
      if (Object.prototype.toString.call(d) !== "[object Date]") {
        return false;
      }
      return !isNaN(d.getTime());
    };
    $scope.model = {};
    updateDomainDetails = function() {
      Restangular.one('domains', $routeParams.domainName).get().then(function(domainDetails) {
        return $scope.model.domainDetails = domainDetails;
      });
      Restangular.one('domains', $routeParams.domainName).getList('violations-per-day').then(function(violations) {
        violations = violations.violations;
        return buildCharts(violations);
      });
      Restangular.one('domains', $routeParams.domainName).getList('reviews').then(function(domainData) {
        return $scope.model.pages = domainData.pages;
      });
      return $timeout(updateDomainDetails, 5000);
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
          return (d3.time.format("%d-%b-%Y"))(new Date(d));
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
          return (d3.time.format("%d-%b-%Y"))(new Date(d));
        });
        d3.select('#violation-points-chart svg').datum(violationPointsData).transition().duration(500).call(chart);
        nv.utils.windowResize(function() {
          return d3.select('#violation-points-chart svg').call(chart);
        });
        return chart;
      });
    };
    return updateDomainDetails();
  });

}).call(this);

/*
//@ sourceMappingURL=domain_details.js.map
*/