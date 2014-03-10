'use strict'

class LastRequestsCtrl
  constructor: (@scope, @LastRequestsFcty, @WebSocketFcty) ->
    @requests = []
    @requestsCount = 0

    @getLastRequests()

    @WebSocketFcty.on((message) =>
      @getLastRequests() if message.type == 'new-request'
    )

  _fillRequests: (data) =>
    @requests = data.requests
    @requestsCount = data.requestsCount

  getLastRequests: (currentPage, pageSize) ->
    @LastRequestsFcty.getLastRequests({current_page: currentPage, page_size: pageSize}).then(@_fillRequests)

  updateLastRequests: (currentPage, pageSize) =>
    @getLastRequests(currentPage, pageSize)


angular.module('holmesApp')
  .controller 'LastRequestsCtrl', ($scope, LastRequestsFcty, WebSocketFcty) ->
    $scope.model = new LastRequestsCtrl($scope, LastRequestsFcty, WebSocketFcty)
