'use strict'

class LastReviewsCtrl
  constructor: (@scope, @LastReviewsFcty, @WebSocketFcty) ->
    @lastReviews = []

    @getLastReviews()

    @WebSocketFcty.clearHandlers()
    @WebSocketFcty.on((message) =>
      @getLastReviews() if message.type == 'new-review'
    )

  _fillReviews: (reviews) =>
    @lastReviews = reviews

  getLastReviews: ->
    @LastReviewsFcty.getLastReviews().then(@_fillReviews)


angular.module('holmesApp')
  .controller 'LastReviewsCtrl', ($scope, LastReviewsFcty, WebSocketFcty) ->
    $scope.model = new LastReviewsCtrl($scope, LastReviewsFcty, WebSocketFcty)
