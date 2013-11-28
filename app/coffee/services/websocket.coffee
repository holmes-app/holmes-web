class WebSocketService
  constructor: (@wsUrl, @timeout) ->
    @ws = new ReconnectingWebSocket(@wsUrl) if ReconnectingWebSocket
    @ws = new WebSocket(@wsUrl) unless ReconnectingWebSocket
    @handlers = []

    @ws.onmessage = @_onmessage.bind(this)
    @throttledStatus = $.throttle(2000, @sendMessage)
    @throttledReview = $.throttle(500, @sendMessage)
    @throttledSendMessage = $.throttle(1000, @sendMessage)

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

angular.module('WebSocketService', ["HolmesConfig"], ($provide) ->
  $provide.factory('WebSocket', (wsUrl, $timeout) ->
    new WebSocketService(wsUrl, $timeout)
  )
)
