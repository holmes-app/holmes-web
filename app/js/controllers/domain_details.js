(function() {
  'use strict';
  angular.module('holmesApp').controller('DomainDetailsCtrl', function($scope, $routeParams, Restangular) {
    $scope.model = {};
    return $scope.model.domainDetails = Restangular.one('domains', $routeParams.domainName).get();
  });

}).call(this);

/*
//@ sourceMappingURL=domain_details.js.map
*/