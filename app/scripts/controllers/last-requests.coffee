'use strict'

class LastRequestsCtrl
  constructor: (@scope, @LastRequestsFcty, @WebSocketFcty) ->
    @requests = []
    @pageSize = 10
    @domainFilter = ''

    @defaultStatusCodeDropdown()

    @getLastRequests()
    @getRequestsInLastDay()
    @getStatusCode()

    @WebSocketFcty.on((message) =>
      @getLastRequests(@currentPage, @pageSize) if message.type == 'new-request'
    )

    @scope.$on '$destroy', @_cleanUp

    @watchScope()

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillRequests: (data) =>
    @requests = data.requests
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
        statusCode: ''
        statusCodeTitle: 'Others'
    @failedRequests = _.map(
      requests
      (request) ->
        label: request.statusCode + ' ' + request.statusCodeTitle
        value: request.count
        percentage: request.count / this * 100
      countSum
    )
    @loadedRequestsInLastDay = requests.length

  _fillStatusCode: (status_code) =>
    @statusCodeOptions = ({label: item.statusCode + ' ' + item.statusCodeTitle, text: item.statusCode} for item in status_code)

  defaultStatusCodeDropdown: =>
    @statusCodeSelected = {label: 'Filter status code', placeholder: true}

  clearStatusCodeDropdown: ->
    @defaultStatusCodeDropdown()
    @onPageChange()

  getStatusCode: ->
    @LastRequestsFcty.getStatusCode().then @_fillStatusCode, =>
      @statusCodeOptions = []

  appendDomainParams: (params) ->
    if not params?
      params = {}

    if @statusCodeSelected.placeholder != true
      params['status_code_filter'] = @statusCodeSelected.text

    return params

  getLastRequests: (currentPage, pageSize) =>
    pageSize = if not pageSize then @pageSize
    params = {current_page: currentPage, page_size: pageSize, domain_filter: @domainFilter}
    @LastRequestsFcty.getLastRequests(@appendDomainParams(params)).then @_fillRequests, =>
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

  watchScope: ->
    @scope.$watch('model.domainFilter', @onDomainFilterChange)


angular.module('holmesApp')
  .controller 'LastRequestsCtrl', ($scope, LastRequestsFcty, WebSocketFcty) ->
    $scope.model = new LastRequestsCtrl($scope, LastRequestsFcty, WebSocketFcty)
