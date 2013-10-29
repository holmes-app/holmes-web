(function() {
  'use strict';
  angular.module('holmesApp').directive('sidebar', function() {
    return {
      templateUrl: 'views/sidebar.html',
      restrict: 'E',
      scope: {},
      controller: function($scope, Restangular, $location, $timeout) {
        var getWorkers;
        $scope.model = {};
        $scope.model.workers = [];
        getWorkers = function() {
          Restangular.one('workers').getList().then(function(activeWorkers) {
            return $scope.model.workers = activeWorkers;
          });
          return $timeout(getWorkers, 2000);
        };
        getWorkers();
        $scope.mostCommonViolations = [
          {
            name: "Javascript total size is too big",
            count: 948
          }, {
            name: "Missing opengraph",
            count: 19245
          }, {
            name: "Too many elements in page",
            count: 4203
          }, {
            name: "Invalid HTML",
            count: 10234
          }, {
            name: "Missing description metadata in header",
            count: 7429
          }, {
            name: "No sitemap",
            count: 23049
          }, {
            name: "Too many requests",
            count: 2023
          }
        ];
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