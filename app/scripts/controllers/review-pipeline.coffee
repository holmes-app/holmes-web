'use strict'

class ReviewPipelineCtrl
  constructor: (@scope, @NextJobsFcty, @WebSocketFcty) ->
    @reviews = []
    @pageSize = 10

    @getReviews()

    @WebSocketFcty.on((message) =>
      @getReviews()
    )

    @scope.$on '$destroy', @_cleanUp

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillReviews: (data) =>
    @reviews = data.pages
    @reviewsLoaded = data.pages.length
    if @reviewsLoaded > 0 and not @hasReviews
      @hasReviews = true

  getReviews: (currentPage, pageSize) ->
    pageSize = if not pageSize then @pageSize
    @NextJobsFcty.getNextJobs({current_page: currentPage, page_size: pageSize}).then @_fillReviews, =>
      @reviewsLoaded = null

  updateReviews: (currentPage, pageSize) =>
    pageSize = if not pageSize then @pageSize
    @getReviews(currentPage, pageSize)


angular.module('holmesApp')
  .controller 'ReviewPipelineCtrl', ($scope, NextJobsFcty, WebSocketFcty) ->
    $scope.model = new ReviewPipelineCtrl($scope, NextJobsFcty, WebSocketFcty)
