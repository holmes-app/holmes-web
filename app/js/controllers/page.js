(function() {
  'use strict';
  angular.module('holmesApp').controller('PageCtrl', function($scope) {
    var i, _i, _results;
    $scope.domains = [];
    _results = [];
    for (i = _i = 1; _i <= 20; i = ++_i) {
      _results.push($scope.domains.push({
        name: "g1.globo.com",
        url: "http://g1.globo.com",
        id: 1,
        violations: 25200,
        pages: 2304
      }));
    }
    return _results;
  });

}).call(this);

/*
//@ sourceMappingURL=page.js.map
*/