'use strict'

angular.module('holmesApp')
  .controller 'MainCtrl', ($scope, $timeout, growl, $resource, $http, Restangular, WebSocket) ->
    $http.defaults.useXDomain = true

    $scope.clearForm = ->
      $scope.model =
        url: ''
        turnsOut: ''
        invalidUrl: ''

      $scope.addPageForm.url.$pristine = true if $scope.addPageForm and $scope.addPageForm.url

    $scope.clearForm()

    $scope.addPage = () ->
      url = $scope.model.url
      $scope.model.turnsOut = ''
      $scope.model.invalidUrl = ''

      Restangular.all('page').post({ url: url }).then((page) ->
        $scope.clearForm()
        growl.addSuccessMessage('Page successfully saved!')
      , (response) ->
        if response.status == 400
          if response.data.reason == 'invalid_url'
            $scope.model.invalidUrl = response.data.url

          if response.data.reason == 'redirect'
            $scope.model.turnsOut = response.data.effectiveUrl
      )

    lastReviews = ->
      Restangular.one('last-reviews').get().then((reviews) ->
        $scope.model.last_reviews = reviews
      )
      #$timeout(lastReviews, 2000)

    lastReviews()

    WebSocket.on((message) ->
      lastReviews()
    )

    return true
