(function() {
  'use strict';
  angular.module('holmesApp').controller('DelimiterCtrl', function($scope, growl, $routeParams, Restangular, WebSocket, $cookieStore) {
    var updateDelimiterDetails;
    $scope.model = {
      url: '',
      value: '',
      delimiterDetails: []
    };
    updateDelimiterDetails = function() {
      return Restangular.one('delimiters').get().then(function(delimiterDetails) {
        return $scope.model.delimiterDetails = delimiterDetails;
      });
    };
    updateDelimiterDetails();
    $scope.clearForm = function() {
      return $scope.model = {
        url: '',
        value: ''
      };
    };
    $scope.addDelimiter = function() {
      var data;
      data = {
        url: $scope.model.url,
        value: $scope.model.value
      };
      return Restangular.all('delimiters').post(data, {}, {
        'X-AUTH-HOLMES': $cookieStore.get('HOLMES_AUTH_TOKEN')
      }).then(function(delimiter) {
        $scope.clearForm();
        growl.addSuccessMessage('Delimiter successfully saved!');
        return updateDelimiterDetails();
      }, function(response) {
        if (response.status === 403) {
          if (response.data.reason === 'Empty access token') {
            return growl.addErrorMessage('Empty access token!');
          }
        }
      });
    };
    return $scope.addPage = function() {
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
  });

}).call(this);

/*
//@ sourceMappingURL=delimiter.js.map
*/