'use strict'

class ReviewPipelineCtrl
  constructor: (@scope, @NextJobsFcty, @LastReviewsFcty, @WebSocketFcty) ->
    @reviews = []
    @pageSize = 100

    @getReviews()

    @WebSocketFcty.on((message) =>
      @getReviews(@currentPage, @pageSize) if message.type == 'new-review'
    )

    @scope.$on '$destroy', @_cleanUp

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillReviewsInLastHour: (data) =>
    reviewsPerSecond = data.count / data.ellapsed
    for review in @reviews
      review.estimatedTime = new Date(Date.now() + review.num * (1 / reviewsPerSecond) * 1000).getTime()

  _fillReviews: (data) =>
    @getReviewsInLastHour()
    @reviews = data.pages
    @reviewsLoaded = data.pages.length
    if @reviewsLoaded > 0 and not @hasReviews
      @hasReviews = true

  getReviews: (currentPage, pageSize) =>
    pageSize = @pageSize if not pageSize
    params = {current_page: currentPage, page_size: pageSize}
    @NextJobsFcty.getNextJobs(params).then @_fillReviews, =>
      @reviewsLoaded = null

  onPageChange: (currentPage, pageSize) =>
    pageSize = @pageSize if not pageSize
    @currentPage = if currentPage? then currentPage else @currentPage
    @getReviews(@currentPage, pageSize)

  getReviewsInLastHour: ->
    @LastReviewsFcty.getReviewsInLastHour().then @_fillReviewsInLastHour


angular.module('holmesApp')
  .controller 'ReviewPipelineCtrl', ($scope, NextJobsFcty, LastReviewsFcty, WebSocketFcty) ->
    $scope.model = new ReviewPipelineCtrl($scope, NextJobsFcty, LastReviewsFcty, WebSocketFcty)
