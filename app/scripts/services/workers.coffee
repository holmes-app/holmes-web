'use strict'

class WorkersFactory
  constructor: (@WebSocketFcty) ->

    @activeWorkers = []
    @idleWorkers = []

  listen: (onWorkersChanged) ->
    @WebSocketFcty.on((message) =>
      if message.type != 'worker-status'
        return
      @processMessage(message, onWorkersChanged)
    )

  processMessage: (message, onWorkersChanged) =>
    expiration = (new Date() - 200000) / 1000  # IN SECONDS

    @activeWorkers = _.filter(@activeWorkers, (item) ->
      (item.workerId != message.workerId) and (new Date(item.dt) >= expiration)
    )

    @idleWorkers = _.filter(@idleWorkers, (item) ->
      (item.workerId != message.workerId) and (new Date(item.dt) >= expiration)
    )

    if message.url?
      @activeWorkers.push(message)
    else
      @idleWorkers.push(message)

    onWorkersChanged(@activeWorkers, @idleWorkers)

  stopListen: ->
    @WebSocketFcty.clearHandlers()


angular.module('holmesApp')
  .factory 'WorkersFcty', (WebSocketFcty) ->
    return new WorkersFactory(WebSocketFcty)
