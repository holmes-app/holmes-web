(function() {
  'use strict';
  angular.module('holmesApp').controller('WorkersCtrl', function($scope, Restangular, WebSocket) {
    var updateWorkers;
    $scope.model = {};
    updateWorkers = function() {
      return Restangular.all('workers').getList().then(function(items) {
        return $scope.model.workers = items;
      });
    };
    updateWorkers();
    return WebSocket.on(function(message) {
      if (message.type === 'worker-status') {
        return updateWorkers();
      }
    });
  });

}).call(this);

/*
//@ sourceMappingURL=workers.js.map
*/