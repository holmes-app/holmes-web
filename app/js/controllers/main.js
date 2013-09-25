(function() {
  'use strict';
  angular.module('holmesApp').controller('MainCtrl', function($scope) {
    $scope.model = {
      url: ''
    };
    return $scope.addPage = function(url) {
      console.log(url);
      return alertify.success(url + ' successfully saved!');
    };
  });

}).call(this);

/*
//@ sourceMappingURL=main.js.map
*/