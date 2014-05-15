'use strict'

class LastReviewsCtrl
  constructor: (@scope, @LastReviewsFcty, @WebSocketFcty) ->
    @lastReviews = []
    @domainFilter = ''

    @getLastReviews()

    @WebSocketFcty.on((message) =>
      @getLastReviews(@currentPage, @pageSize) if message.type == 'new-review'
    )

    @scope.$on '$destroy', @_cleanUp

    @watchScope()

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillReviews: (reviews) =>
    @lastReviews = reviews
    @loadedReviews = reviews.length

  _fillReviewsInLastHour: (reviews) =>
    @lastReviewsInLastHour = reviews
    @lastReviewsInLastHour.perHour = @lastReviewsInLastHour.count / @lastReviewsInLastHour.ellapsed

    @loadedReviewsInLastHour = true

  getLastReviews: ->
    @LastReviewsFcty.getLastReviews({domain_filter: @domainFilter}).then @_fillReviews, =>
      @loadedReviews = null

    @LastReviewsFcty.getReviewsInLastHour({domain_filter: @domainFilter}).then @_fillReviewsInLastHour, =>
      @loadedReviewsInLastHour = null

  onDomainFilterChange: =>
    @getLastReviews()

  watchScope: ->
    @scope.$watch('model.domainFilter', @onDomainFilterChange)


angular.module('holmesApp')
  .controller 'LastReviewsCtrl', ($scope, LastReviewsFcty, WebSocketFcty) ->
    $scope.model = new LastReviewsCtrl($scope, LastReviewsFcty, WebSocketFcty)
