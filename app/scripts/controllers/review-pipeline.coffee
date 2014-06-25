'use strict'

class ReviewPipelineCtrl
  constructor: (@scope, @NextJobsFcty, @WebSocketFcty) ->
    @reviews = []
    @pageSize = 10
    @domainFilter = ''

    @getReviews()

    @WebSocketFcty.on((message) =>
      @getReviews(@currentPage, @pageSize) if message.type == 'new-review'
    )

    @scope.$on '$destroy', @_cleanUp

    @watchScope()

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillReviews: (data) =>
    @reviews = data.pages
    @reviewsLoaded = data.pages.length
    if @reviewsLoaded > 0 and not @hasReviews
      @hasReviews = true

  getReviews: (currentPage, pageSize) ->
    pageSize = if not pageSize then @pageSize
    params = {current_page: currentPage, page_size: pageSize, domain_filter: @domainFilter}
    @NextJobsFcty.getNextJobs(params).then @_fillReviews, =>
      @reviewsLoaded = null

  onPageChange: (currentPage, pageSize) =>
    pageSize = if not pageSize then @pageSize
    @currentPage = if currentPage? then currentPage else 1
    @getReviews(@currentPage, pageSize)

  onDomainFilterChange: (newVal, oldVal) =>
    if newVal != oldVal
      @onPageChange()

  watchScope: ->
    @scope.$watch('model.domainFilter', @onDomainFilterChange)


angular.module('holmesApp')
  .controller 'ReviewPipelineCtrl', ($scope, NextJobsFcty, WebSocketFcty) ->
    $scope.model = new ReviewPipelineCtrl($scope, NextJobsFcty, WebSocketFcty)
