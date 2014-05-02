'use strict'

class WebSocketService
  constructor: (@wsUrl, @WebSocket, @rootScope) ->
    @ws = new @WebSocket(@wsUrl)
    @handlers = []

    @rootScope.wsOpened = false
    @ws.onmessage = @_onmessage.bind(this)
    @ws.onopen = @_onopen.bind(this)
    @ws.onclose = @_onclose.bind(this)
    @throttledSendMessage = $.throttle(500, @sendMessage)

  clearHandlers: () ->
    @handlers[..] = []

  on: (callback) ->
    @handlers.push(callback)

  sendMessage: (message) ->
    obj = JSON.parse(message.data)

    for handler in @handlers
      handler(obj)

  _onmessage: (message) ->
    if message.type == "worker-status"
      @_onMessage(message)
    else
      @throttledSendMessage(message)

  _onopen: (event) ->
    @rootScope.wsOpened = true

  _onclose: (event) ->
    @rootScope.wsOpened = false


angular.module('holmesApp')
  .factory('WebSocketFcty', (ConfigConst, WebSocket, $rootScope) ->
    new WebSocketService(ConfigConst.wsUrl, WebSocket, $rootScope)
  )
