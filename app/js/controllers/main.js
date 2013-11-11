(function() {
  'use strict';
  angular.module('holmesApp').controller('MainCtrl', function($scope, $timeout, growl, $resource, $http, Restangular) {
    $http.defaults.useXDomain = true;
    $scope.clearForm = function() {
      $scope.model = {
        url: '',
        turnsOut: '',
        invalidUrl: ''
      };
      if ($scope.addPageForm) {
        return $scope.addPageForm.url.$pristine = true;
      }
    };
    $scope.clearForm();
    return $scope.addPage = function() {
      var page, pages, url;
      url = $scope.model.url;
      $scope.model.turnsOut = '';
      $scope.model.invalidUrl = '';
      pages = Restangular.all('page');
      return page = pages.post({
        url: url
      }).then(function(page) {
        $scope.clearForm();
        return growl.addSuccessMessage(url + ' successfully saved!');
      }, function(response) {
        if (response.status === 400) {
          if (response.data.reason === 'invalid_url') {
            $scope.model.invalidUrl = response.data.url;
          }
          if (response.data.reason === 'redirect') {
            return $scope.model.turnsOut = response.data.effectiveUrl;
          }
        }
      });
    };
  });

}).call(this);

/*
//@ sourceMappingURL=main.js.map
*/