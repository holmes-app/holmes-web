(function() {
  'use strict';
  angular.module('holmesApp').controller('ViolationCtrl', function($scope, $routeParams, Restangular, WebSocket) {
    var updateViolation;
    $scope.model = {};
    updateViolation = function() {
      return Restangular.one('violation', $routeParams.keyName).get().then(function(items) {
        return $scope.model.violation = items;
      });
    };
    return updateViolation();
  });

}).call(this);

/*
//@ sourceMappingURL=violation.js.map
*/