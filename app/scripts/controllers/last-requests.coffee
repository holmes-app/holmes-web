'use strict'

class LastRequestsCtrl
  constructor: (@scope, @LastRequestsFcty, @WebSocketFcty, @DomainsFcty) ->
    @requests = []
    @pageSize = 10

    @getDomainsList()
    @getLastRequests()
    @getRequestsInLastDay()

    @WebSocketFcty.on((message) =>
      @getLastRequests(@currentPage, @pageSize) if message.type == 'new-request'
    )

    @scope.$on '$destroy', @_cleanUp

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

  clearDomainDropdown: ->
    @domainsSelected = {text: 'Filter domain', placeholder: true}
    @onPageChange()

  _fillDomainsList: (domains) =>
    @domainsOptions = ({text: domain.name} for domain in domains)

  getDomainsList: ->
    @DomainsFcty.getDomains().then @_fillDomainsList, =>
      @domainsOptions = []
    @clearDomainDropdown()

  appendDomainParams: (params) ->
    if not params?
      params = {}
    if @domainsSelected.placeholder != true
      params['domain_filter'] = @domainsSelected.text
    return params

  getLastRequests: (currentPage, pageSize) =>
    pageSize = if not pageSize then @pageSize
    params = {current_page: currentPage, page_size: pageSize}
    @LastRequestsFcty.getLastRequests(@appendDomainParams(params)).then @_fillRequests, =>
      @loadedRequests = null

  getRequestsInLastDay: ->
    console.log 'getRequestsInLastDay'
    @LastRequestsFcty.getRequestsInLastDay(@appendDomainParams()).then @_fillRequestsInLastDay, =>
      @loadedRequestsInLastDay = null

  onPageChange: (currentPage, pageSize) =>
    @currentPage = if currentPage? then currentPage else 1
    @getLastRequests(@currentPage, pageSize)
    @getRequestsInLastDay()


angular.module('holmesApp')
  .controller 'LastRequestsCtrl', ($scope, LastRequestsFcty, WebSocketFcty, DomainsFcty) ->
    $scope.model = new LastRequestsCtrl($scope, LastRequestsFcty, WebSocketFcty, DomainsFcty)
