(function() {
  'use strict';
  angular.module('holmesApp').controller('MainCtrl', function($scope, $timeout, growl, $resource, $http, Restangular) {
    var lastReviews;
    $http.defaults.useXDomain = true;
    $scope.clearForm = function() {
      $scope.model = {
        url: '',
        turnsOut: '',
        invalidUrl: ''
      };
      if ($scope.addPageForm && $scope.addPageForm.url) {
        return $scope.addPageForm.url.$pristine = true;
      }
    };
    $scope.clearForm();
    $scope.addPage = function() {
      var url;
      url = $scope.model.url;
      $scope.model.turnsOut = '';
      $scope.model.invalidUrl = '';
      return Restangular.all('page').post({
        url: url
      }).then(function(page) {
        $scope.clearForm();
        return growl.addSuccessMessage('Page successfully saved!');
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
    lastReviews = function() {
      Restangular.one('last-reviews').get().then(function(reviews) {
        return $scope.model.last_reviews = reviews;
      });
      return $timeout(lastReviews, 2000);
    };
    return lastReviews();
  });

}).call(this);

/*
//@ sourceMappingURL=main.js.map
*/