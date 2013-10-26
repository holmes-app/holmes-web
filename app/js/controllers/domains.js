(function() {
  'use strict';
  angular.module('holmesApp').controller('DomainsCtrl', function($scope, Restangular) {
    $scope.model = {};
    return $scope.model.domains = Restangular.all('domains').getList();
  });

}).call(this);

/*
//@ sourceMappingURL=domains.js.map
*/