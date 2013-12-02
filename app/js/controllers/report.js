(function() {
  'use strict';
  angular.module('holmesApp').controller('ReportCtrl', function($scope, $routeParams, Restangular, $sce) {
    var buildCharts, isValidDate, updateChartData, updateDetails, updateReviews;
    $scope.asHtml = function(text) {
      return $sce.trustAsHtml(text);
    };
    isValidDate = function(d) {
      if (Object.prototype.toString.call(d) !== "[object Date]") {
        return false;
      }
      return !isNaN(d.getTime());
    };
    $('#reportTabs').tab();
    $scope.model = {
      details: {},
      reviews: {}
    };
    updateDetails = function() {
      return Restangular.one('page', $routeParams.pageId).one('review', $routeParams.reviewId).get().then(function(details) {
        var fact, item, _i, _len, _ref, _results;
        $scope.model.details = details;
        _ref = details.facts;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          fact = _ref[_i];
          if (fact.unit === 'values') {
            _results.push((function() {
              var _j, _len1, _ref1, _results1;
              _ref1 = fact.value;
              _results1 = [];
              for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
                item = _ref1[_j];
                _results1.push(item.content = window.decodeURIComponent(window.escape(item.content)));
              }
              return _results1;
            })());
          } else {
            _results.push(fact.value = window.decodeURIComponent(window.escape(fact.value)));
          }
        }
        return _results;
      });
    };
    updateReviews = function() {
      return Restangular.one('page', $routeParams.pageId).one('reviews').get().then(function(reviews) {
        return $scope.model.reviews = reviews;
      });
    };
    updateChartData = function() {
      return Restangular.one('page', $routeParams.pageId).getList('violations-per-day').then(function(violations) {
        violations = violations.violations;
        return buildCharts(violations);
      });
    };
    buildCharts = function(violations) {
      var dt, obj, violationCount, violationCountData, violationPoints, violationPointsData, _i, _len;
      violationPoints = [];
      violationCount = [];
      for (_i = 0, _len = violations.length; _i < _len; _i++) {
        obj = violations[_i];
        dt = new Date(obj.completedAt);
        if (!isValidDate(dt)) {
          continue;
        }
        violationPoints.push({
          x: new Date(obj.completedAt),
          y: obj.violation_points
        });
        violationCount.push({
          x: new Date(obj.completedAt),
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
    updateDetails();
    updateReviews();
    return updateChartData();
  });

}).call(this);

/*
//@ sourceMappingURL=report.js.map
*/