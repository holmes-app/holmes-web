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
    @loadedReviews = reviews.length

  _fillReviewsInLastHour: (reviews) =>
    @lastReviewsInLastHour = reviews.count
    @loadedReviewsInLastHour = true

  getLastReviews: ->
    @LastReviewsFcty.getLastReviews().then @_fillReviews, =>
      @loadedReviews = null

    @LastReviewsFcty.getReviewsInLastHour().then @_fillReviewsInLastHour, =>
      @loadedReviewsInLastHour = null


angular.module('holmesApp')
  .controller 'LastReviewsCtrl', ($scope, LastReviewsFcty, WebSocketFcty) ->
    $scope.model = new LastReviewsCtrl($scope, LastReviewsFcty, WebSocketFcty)
