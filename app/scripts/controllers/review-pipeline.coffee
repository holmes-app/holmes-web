'use strict'

class ReviewPipelineCtrl
  constructor: (@scope, @NextJobsFcty, @WebSocketFcty) ->
    @reviews = []
    @pageSize = 100

    @getReviews()

    @WebSocketFcty.on((message) =>
      @getReviews(@currentPage, @pageSize) if message.type == 'new-review'
    )

    @scope.$on '$destroy', @_cleanUp

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillReviews: (data) =>
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


angular.module('holmesApp')
  .controller 'ReviewPipelineCtrl', ($scope, NextJobsFcty, WebSocketFcty) ->
    $scope.model = new ReviewPipelineCtrl($scope, NextJobsFcty, WebSocketFcty)
