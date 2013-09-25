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
        for (i = _i = 12; _i >= 1; i = --_i) {
          $scope.workers.push({
            id: "Worker 2013012041203",
            position: i,
            status: i < 5 ? "working" : "waiting",
            url: "http://www.globo.com"
          });
        }
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