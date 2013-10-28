(function() {
  'use strict';
  angular.module('holmesApp').controller('DomainsCtrl', function($scope, Restangular, $timeout) {
    var updateDomains;
    $scope.model = {};
    updateDomains = function() {
      Restangular.all('domains').getList().then(function(items) {
        return $scope.model.domains = items;
      });
      return $timeout(updateDomains, 2000);
    };
    return updateDomains();
  });

}).call(this);

/*
//@ sourceMappingURL=domains.js.map
*/