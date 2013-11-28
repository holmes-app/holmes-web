(function() {
  'use strict';
  angular.module('holmesApp').controller('DomainsCtrl', function($scope, Restangular, WebSocket) {
    var updateDomains;
    $scope.model = {};
    updateDomains = function() {
      return Restangular.all('domains').getList().then(function(items) {
        return $scope.model.domains = items;
      });
    };
    updateDomains();
    return WebSocket.on(function(message) {
      if (message.type === 'new-domain' || message.type === 'new-review' || message.type === 'new-page') {
        return updateDomains();
      }
    });
  });

}).call(this);

/*
//@ sourceMappingURL=domains.js.map
*/