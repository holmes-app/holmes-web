'use strict'

angular.module('holmesApp')
  .controller 'ReportCtrl', ($scope, $routeParams, Restangular, $sce) ->
    $scope.asHtml = (text) ->
      return $sce.trustAsHtml(text)

    isValidDate = (d) ->
      if (Object.prototype.toString.call(d) != "[object Date]")
        return false
      return !isNaN(d.getTime())

    $('#reportTabs').tab()

    $scope.model = {
      details: {},
      reviews: {}
    }

    updateDetails = ->
      Restangular.one('page', $routeParams.pageId).one('review', $routeParams.reviewId).get().then((details) ->
        $scope.model.details = details

      )

    updateReviews = ->
      Restangular.one('page', $routeParams.pageId).one('reviews').get().then((reviews) ->
        $scope.model.reviews = reviews
      )

    updateDetails()
    updateReviews()
