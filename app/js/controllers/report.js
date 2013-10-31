(function() {
  'use strict';
  angular.module('holmesApp').controller('ReportCtrl', function($scope, $routeParams, Restangular, $timeout) {
    var sinAndCos, updateDetails, updateReviews;
    $('#reportTabs').tab();
    sinAndCos = function() {
      var cos, i, sin, _i;
      sin = [];
      cos = [];
      for (i = _i = 0; _i <= 100; i = ++_i) {
        sin.push({
          x: i,
          y: Math.sin(i / 10)
        });
        cos.push({
          x: i,
          y: .5 * Math.cos(i / 10)
        });
      }
      return [
        {
          values: sin,
          key: 'Sine Wave',
          color: '#ff7f0e'
        }, {
          values: cos,
          key: 'Cosine Wave',
          color: '#2ca02c'
        }
      ];
    };
    $scope.model = {
      details: {},
      reviews: {}
    };
    updateDetails = function() {
      return Restangular.one('page', $routeParams.pageId).one('review', $routeParams.reviewId).get().then(function(details) {
        return $scope.model.details = details;
      });
    };
    updateReviews = function() {
      return Restangular.one('page', $routeParams.pageId).one('reviews').get().then(function(reviews) {
        return $scope.model.reviews = reviews;
      });
    };
    nv.addGraph(function() {
      var chart;
      chart = nv.models.lineChart();
      chart.xAxis.axisLabel('Time (ms)').tickFormat(d3.format(',r'));
      chart.yAxis.axisLabel('Voltage (v)').tickFormat(d3.format('.02f'));
      d3.select('#chart svg').datum(sinAndCos()).transition().duration(500).call(chart);
      nv.utils.windowResize(function() {
        return d3.select('#chart svg').call(chart);
      });
      return chart;
    });
    updateDetails();
    return updateReviews();
  });

}).call(this);

/*
//@ sourceMappingURL=report.js.map
*/