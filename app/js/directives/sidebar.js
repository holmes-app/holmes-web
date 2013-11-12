(function() {
  'use strict';
  angular.module('holmesApp').directive('sidebar', function() {
    return {
      templateUrl: 'views/sidebar.html',
      restrict: 'E',
      scope: {},
      controller: function($scope, Restangular, $location, $timeout, growl) {
        var getMostCommonViolations, getWorkers;
        $scope.model = {
          term: ''
        };
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
        $scope.getClass = function(path) {
          var isActive;
          isActive = $location.path().trim() === path.trim();
          if (isActive) {
            return "active";
          }
          if (!isActive) {
            return "";
          }
        };
        return $scope.search = function() {
          var term;
          term = $scope.model.term;
          return Restangular.all('search').getList({
            term: term
          }).then(function(pages) {
            if (pages.length === 0) {
              growl.addErrorMessage("Page with URL " + term + " was not found!");
            } else {
              $location.path('/pages/' + pages[0].uuid + '/reviews/' + pages[0].reviewId);
            }
            return $scope.model.term = '';
          });
        };
      }
    };
  });

}).call(this);

/*
//@ sourceMappingURL=sidebar.js.map
*/