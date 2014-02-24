'use strict'

class LastReviewsCtrl
  constructor: (@scope, @LastReviewsFcty) ->
    @lastReviews = []

    @getLastReviews()


  getLastReviews: ->
    @lastReviews = @LastReviewsFcty.all('').getList().$object

angular.module('holmesApp')
  .controller 'LastReviewsCtrl', ($scope, LastReviewsFcty) ->
    $scope.model = new LastReviewsCtrl($scope, LastReviewsFcty)
