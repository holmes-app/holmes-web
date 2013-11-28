'use strict'

angular.module('holmesApp')
  .controller 'DomainsCtrl', ($scope, Restangular, WebSocket) ->
    $scope.model = {}

    updateDomains = ->
      Restangular.all('domains').getList().then((items) ->
        $scope.model.domains = items
      )

    updateDomains()

    WebSocket.on((message) ->
      updateDomains() if message.type == 'new-domain' or message.type == 'new-review' or message.type == 'new-page'
    )
