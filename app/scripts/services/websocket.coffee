'use strict'

class WebSocketService
  constructor: (@wsUrl, @WebSocket) ->
    @ws = new @WebSocket(@wsUrl)
    @handlers = []

    @ws.onmessage = @_onmessage.bind(this)
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

angular.module('holmesApp')
  .factory('WebSocketFcty', (ConfigConst, WebSocket) ->
    new WebSocketService(ConfigConst.wsUrl, WebSocket)
  )
