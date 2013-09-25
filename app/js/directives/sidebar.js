(function() {
  'use strict';
  angular.module('holmesApp').directive('sidebar', function() {
    return {
      templateUrl: 'views/sidebar.html',
      restrict: 'E',
      scope: {},
      controller: function($scope, $location) {
        var i, _i;
        $scope.workers = [];
        for (i = _i = 25; _i >= 1; i = --_i) {
          $scope.workers.push({
            id: "Worker 2013012041203",
            position: i,
            status: i < 5 ? "working" : "waiting",
            url: "http://www.globo.com"
          });
        }
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