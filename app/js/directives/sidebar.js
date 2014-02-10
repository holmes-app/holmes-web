(function() {
  'use strict';
  angular.module('holmesApp').directive('sidebar', function() {
    return {
      templateUrl: 'views/sidebar.html',
      restrict: 'E',
      scope: {},
      controller: function($scope, Restangular, $location, $timeout, growl, WebSocket, $cookieStore) {
        var chartData, drawChart, getWorkersInfo, updateChart;
        $scope.model = {
          term: ''
        };
        $scope.$on('event:google-plus-signin-success', function(event, authResult) {
          return event.targetScope.$apply(function() {
            $scope.model.access_token = authResult.access_token;
            return $cookieStore.put('HOLMES_AUTH_TOKEN', authResult.access_token);
          });
        });
        $scope.$on('event:google-plus-signin-failure', function(event, authResult) {
          return event.targetScope.$apply(function() {
            $scope.model.access_token = '';
            return $cookieStore.remove('HOLMES_AUTH_TOKEN');
          });
        });
        $scope.model.workers_total = 0;
        $scope.search = function() {
          var term;
          term = $scope.model.term;
          return Restangular.all('search').getList({
            term: term
          }).then(function(page) {
            if (typeof page === 'string') {
              page = JSON.parse(page);
            }
            if (page != null) {
              $location.path('/pages/' + page.uuid + '/reviews/' + page.reviewId);
            } else {
              growl.addErrorMessage("Page with URL " + term + " was not found or does not have any reviews associated with it!");
            }
            return $scope.model.term = '';
          });
        };
        getWorkersInfo = function() {
          return Restangular.one('workers').one('info').get().then(function(data) {
            $scope.model.workers_total = data.total;
            return updateChart(data.active, data.inactive);
          });
        };
        drawChart = function() {
          return nv.addGraph(function() {
            var chart;
            chart = nv.models.pieChart().showLabels(false).tooltips(false).donut(true);
            return $scope.model.chart = chart;
          });
        };
        updateChart = function(active, inactive) {
          return d3.select('#workers-chart svg').datum(chartData(active, inactive)).transition().duration(1200).call($scope.model.chart);
        };
        chartData = function(active, inactive) {
          return [
            {
              x: "Active",
              y: active
            }, {
              x: "Inactive",
              y: inactive
            }
          ];
        };
        drawChart();
        getWorkersInfo();
        WebSocket.on(function(message) {
          if (message.type === 'worker-status') {
            return getWorkersInfo();
          }
        });
        return true;
      }
    };
  });

}).call(this);

/*
//@ sourceMappingURL=sidebar.js.map
*/