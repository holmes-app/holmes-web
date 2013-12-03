(function() {
  'use strict';
  angular.module('holmesApp').directive('sidebar', function() {
    return {
      templateUrl: 'views/sidebar.html',
      restrict: 'E',
      scope: {},
      controller: function($scope, Restangular, $location, $timeout, growl, WebSocket) {
        var getWorkers;
        $scope.model = {
          term: ''
        };
        $scope.model.workers = [];
        getWorkers = function() {
          return Restangular.one('workers').getList().then(function(activeWorkers) {
            return $scope.model.workers = activeWorkers;
          });
        };
        getWorkers();
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
        $scope.search = function() {
          var term;
          term = $scope.model.term;
          return Restangular.all('search').getList({
            term: term
          }).then(function(page) {
            if (page === null || page === void 0) {
              growl.addErrorMessage("Page with URL " + term + " was not found or does not have any reviews associated with it!");
            } else {
              $location.path('/pages/' + page.uuid + '/reviews/' + page.reviewId);
            }
            return $scope.model.term = '';
          });
        };
        return WebSocket.on(function(message) {
          if (message.type === 'worker-status') {
            return getWorkers();
          }
        });
      }
    };
  });

}).call(this);

/*
//@ sourceMappingURL=sidebar.js.map
*/