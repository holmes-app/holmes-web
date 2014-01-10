(function() {
  'use strict';
  angular.module('holmesApp').controller('ViolationsCtrl', function($scope, Restangular, WebSocket) {
    var updateViolations;
    $scope.model = {};
    updateViolations = function() {
      return Restangular.all('violations').getList().then(function(items) {
        return $scope.model.violations = items;
      });
    };
    return updateViolations();
  });

}).call(this);

/*
//@ sourceMappingURL=violations.js.map
*/