'use strict'

class LastReviewsCtrl
  constructor: (@scope, @LastReviewsFcty, @WebSocketFcty) ->
    @lastReviews = []

    @getLastReviews()

    @WebSocketFcty.on((message) =>
      @getLastReviews()
    )

  _fillReviews: (reviews) =>
    @lastReviews = reviews

  getLastReviews: ->
    @LastReviewsFcty.one('').get().then((@_fillReviews))


angular.module('holmesApp')
  .controller 'LastReviewsCtrl', ($scope, LastReviewsFcty, WebSocketFcty) ->
    $scope.model = new LastReviewsCtrl($scope, LastReviewsFcty, WebSocketFcty)
