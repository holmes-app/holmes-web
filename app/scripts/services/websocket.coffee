'use strict'

class WebSocketService
  constructor: (@wsUrl, @WebSocket) ->
    @ws = new @WebSocket(@wsUrl)
    @handlers = []

    @ws.onmessage = @_onmessage.bind(this)
    @throttledStatus = $.throttle(2000, @sendMessage)
    @throttledReview = $.throttle(500, @sendMessage)
    @throttledSendMessage = $.throttle(1000, @sendMessage)

  clearHandlers: () ->
    @handlers[..] = []

  on: (callback) ->
    @handlers.push(callback)

  sendMessage: (message) ->
    obj = JSON.parse(message.data)

    for handler in @handlers
      handler(obj)

  _onmessage: (message) ->
    if message.type == 'worker-status'
      @throttledStatus(message)

    else if message.type == 'new-review'
      @throttledReview(message)

    else
      @throttledSendMessage(message)

angular.module('holmesApp')
  .factory('WebSocketFcty', (ConfigConst, WebSocket) ->
    new WebSocketService(ConfigConst.wsUrl, WebSocket)
  )
