class WebSocketService
  constructor: (@wsUrl, @timeout) ->
    @ws = new WebSocket(@wsUrl)
    @handlers = []

    @ws.onmessage = @_onmessage.bind(this)

  on: (callback) ->
    @handlers.push(callback)

  _onmessage: (message) ->
    obj = JSON.parse(message.data)

    for handler in @handlers
      handler(obj)


angular.module('WebSocketService', ["HolmesConfig"], ($provide) ->
  $provide.factory('WebSocket', (wsUrl, $timeout) ->
    new WebSocketService(wsUrl, $timeout)
  )
)
