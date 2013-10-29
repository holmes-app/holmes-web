(function() {
  'use strict';
  angular.module('holmesApp').directive('sidebar', function() {
    return {
      templateUrl: 'views/sidebar.html',
      restrict: 'E',
      scope: {},
      controller: function($scope, Restangular, $location, $timeout) {
        var getMostCommonViolations, getWorkers;
        $scope.model = {};
        $scope.model.workers = [];
        getWorkers = function() {
          Restangular.one('workers').getList().then(function(activeWorkers) {
            return $scope.model.workers = activeWorkers;
          });
          return $timeout(getWorkers, 2000);
        };
        getWorkers();
        $scope.model.mostCommonViolations = [];
        getMostCommonViolations = function() {
          Restangular.one('most-common-violations').getList().then(function(violations) {
            return $scope.model.mostCommonViolations = violations;
          });
          return $timeout(getMostCommonViolations, 2000);
        };
        getMostCommonViolations();
        return $scope.getClass = function(path) {
          var isActive;
          isActive = $location.path().trim() === path.trim();
          if (isActive) {
            return "active";
          }
          if (!isActive) {
            return "";
          }
        };
      }
    };
  });

}).call(this);

/*
//@ sourceMappingURL=sidebar.js.map
*/