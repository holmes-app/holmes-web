'use strict'

class LastRequestsCtrl
  constructor: (@scope, @LastRequestsFcty, @WebSocketFcty) ->
    @requests = []
    @requestsCount = 0
    @pageSize = 10

    @getLastRequests()

    @WebSocketFcty.clearHandlers()
    @WebSocketFcty.on((message) =>
      @getLastRequests() if message.type == 'new-request'
    )

  _fillRequests: (data) =>
    @requests = data.requests
    @requestsCount = data.requestsCount
    @requestsLoaded = data.requests.length

  getLastRequests: (currentPage, pageSize) ->
    pageSize = if not pageSize then @pageSize
    delete(@requestsLoaded)
    @LastRequestsFcty.getLastRequests({current_page: currentPage, page_size: pageSize}).then @_fillRequests, =>
      @requestsLoaded = null

  updateLastRequests: (currentPage, pageSize) =>
    pageSize = if not pageSize then @pageSize
    @getLastRequests(currentPage, pageSize)


angular.module('holmesApp')
  .controller 'LastRequestsCtrl', ($scope, LastRequestsFcty, WebSocketFcty) ->
    $scope.model = new LastRequestsCtrl($scope, LastRequestsFcty, WebSocketFcty)
