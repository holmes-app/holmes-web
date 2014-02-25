'use strict'

class LastRequestsCtrl
  constructor: (@scope, @LastRequestsFcty) ->
    @requests = []
    @requestsCount = 0

    @getLastRequests()


  getLastRequests: (currentPage, pageSize) ->
    @LastRequestsFcty.one('').get({current_page: currentPage, page_size: pageSize}).then( (data) =>
      @requests = data.requests
      @requestsCount = data.requestsCount
    )

  updateLastRequests: (currentPage, pageSize) =>
    @getLastRequests(currentPage, pageSize)


angular.module('holmesApp')
  .controller 'LastRequestsCtrl', ($scope, LastRequestsFcty) ->
    $scope.model = new LastRequestsCtrl($scope, LastRequestsFcty)
