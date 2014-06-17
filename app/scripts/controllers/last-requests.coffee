'use strict'

class LastRequestsCtrl
  constructor: (@scope, @LastRequestsFcty, @WebSocketFcty, @StatusCodeFcty) ->
    @requests = []
    @pageSize = 10
    @domainFilter = ''
    @statusCodeFilter = ''

    @getLastRequests()
    @getRequestsInLastDay()

    @WebSocketFcty.on((message) =>
      @getLastRequests(@currentPage, @pageSize) if message.type == 'new-request'
    )

    @scope.$on '$destroy', @_cleanUp

    @watchScope()

  toggleExpanded: (request) ->
    request.expanded = not request.expanded

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillRequests: (data) =>
    @requests = data.requests
    _.map @requests, (request) =>
      request.expanded = false
      request.statusCodeTitle = @StatusCodeFcty.getTitle(request.status_code)
      request.statusCodeDesc = @StatusCodeFcty.getDescription(request.status_code)
    @loadedRequests = data.requests.length
    if @loadedRequests > 0 and not @hasRequests
      @hasRequests = true

  _fillRequestsInLastDay: (data) =>
    requests = _.filter data, (request) -> request.statusCode >= 400
    counts = _.pluck requests, 'count'
    countSum = if counts.length > 0 then counts.reduce (a, b) -> a + b else 0
    if requests.length > 5
      requests[4..] = requests[4..].reduce (req1, req2) ->
        count: req1.count + req2.count
        statusCode: null
        statusCodeTitle: null
    @failedRequests = _.map(
      requests
      (request) ->
        label: if request.statusCode then request.statusCode + ' ' + request.statusCodeTitle else 'Others'
        value: request.count
        percentage: request.count / this * 100
      countSum
    )
    @loadedRequestsInLastDay = requests.length

  getLastRequests: (currentPage, pageSize) =>
    pageSize = if not pageSize then @pageSize
    params = {current_page: currentPage, page_size: pageSize, domain_filter: @domainFilter, status_code_filter: @statusCodeFilter}
    @LastRequestsFcty.getLastRequests(params).then @_fillRequests, =>
      @loadedRequests = null

  getRequestsInLastDay: ->
    params = {domain_filter: @domainFilter}
    @LastRequestsFcty.getRequestsInLastDay(params).then @_fillRequestsInLastDay, =>
      @loadedRequestsInLastDay = null

  onPageChange: (currentPage, pageSize) =>
    @currentPage = if currentPage? then currentPage else 1
    @getLastRequests(@currentPage, pageSize)
    @getRequestsInLastDay()

  onDomainFilterChange: =>
    @onPageChange()

  onStatusCodeFilterChange: =>
    @onPageChange()

  watchScope: ->
    @scope.$watch('model.domainFilter', @onDomainFilterChange)
    @scope.$watch('model.statusCodeFilter', @onStatusCodeFilterChange)


angular.module('holmesApp')
  .controller 'LastRequestsCtrl', ($scope, LastRequestsFcty, WebSocketFcty, StatusCodeFcty) ->
    $scope.model = new LastRequestsCtrl($scope, LastRequestsFcty, WebSocketFcty, StatusCodeFcty)
