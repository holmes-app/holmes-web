(function() {
  'use strict';
  angular.module('holmesApp').controller('ReportCtrl', function($scope, $routeParams, Restangular, $sce) {
    var isValidDate, updateDetails, updateReviews;
    $scope.asHtml = function(text) {
      return $sce.trustAsHtml(text);
    };
    isValidDate = function(d) {
      if (Object.prototype.toString.call(d) !== "[object Date]") {
        return false;
      }
      return !isNaN(d.getTime());
    };
    $('#reportTabs').tab();
    $scope.model = {
      details: {},
      reviews: {}
    };
    updateDetails = function() {
      return Restangular.one('page', $routeParams.pageId).one('review', $routeParams.reviewId).get().then(function(details) {
        return $scope.model.details = details;
      });
    };
    updateReviews = function() {
      return Restangular.one('page', $routeParams.pageId).one('reviews').get().then(function(reviews) {
        return $scope.model.reviews = reviews;
      });
    };
    updateDetails();
    return updateReviews();
  });

}).call(this);

/*
//@ sourceMappingURL=report.js.map
*/