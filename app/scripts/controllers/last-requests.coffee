'use strict'

class LastRequestsCtrl
  constructor: (@scope, @LastRequestsFcty, @WebSocketFcty) ->
    @requests = []
    @requestsCount = 0
    @pageSize = 10

    @getLastRequests()
    @getRequestsInLastDay()

    @WebSocketFcty.on((message) =>
      @getLastRequests() if message.type == 'new-request'
    )

    @scope.$on '$destroy', @_cleanUp

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillRequests: (data) =>
    @requests = data.requests
    @requestsCount = data.requestsCount
    @loadedRequests = data.requests.length

  _fillRequestsInLastDay: (data) =>
    requests = _.filter data, (request) -> request.statusCode >= 400
    counts = _.pluck requests, 'count'
    countSum = if counts.length > 0 then counts.reduce (a, b) -> a + b else 0
    @failedRequests = _.map(
      requests
      (request) ->
        label: request.statusCode + ' - ' + request.statusCodeTitle
        value: request.count
        percentage: request.count / this * 100
      countSum
    )
    @loadedRequestsInLastDay = requests.length

  getLastRequests: (currentPage, pageSize) ->
    pageSize = if not pageSize then @pageSize
    @LastRequestsFcty.getLastRequests({current_page: currentPage, page_size: pageSize}).then @_fillRequests, =>
      @loadedRequests = null

  getRequestsInLastDay: ->
    @LastRequestsFcty.getRequestsInLastDay().then @_fillRequestsInLastDay, =>
      @loadedRequestsInLastDay = null

  updateLastRequests: (currentPage, pageSize) =>
    pageSize = if not pageSize then @pageSize
    @getLastRequests(currentPage, pageSize)


angular.module('holmesApp')
  .controller 'LastRequestsCtrl', ($scope, LastRequestsFcty, WebSocketFcty) ->
    $scope.model = new LastRequestsCtrl($scope, LastRequestsFcty, WebSocketFcty)
