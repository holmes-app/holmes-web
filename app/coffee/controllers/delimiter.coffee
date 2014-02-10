'use strict'

angular.module('holmesApp')

  .controller 'DelimiterCtrl', ($scope, growl, $routeParams, Restangular, WebSocket, $cookieStore) ->

    $scope.model = {
      url: '',
      value: '',
      delimiterDetails: [],
    }

    updateDelimiterDetails = ->
      Restangular.one('delimiters').get().then((delimiterDetails) ->
        $scope.model.delimiterDetails = delimiterDetails
      )

    updateDelimiterDetails()

    $scope.clearForm = ->
      $scope.model =
        url: ''
        value: ''

    $scope.addDelimiter = ->
      data = {
        url: $scope.model.url,
        value: $scope.model.value

      }
      Restangular.all('delimiters').post(data, {}, {'X-AUTH-HOLMES': $cookieStore.get('HOLMES_AUTH_TOKEN')}).then((delimiter) ->
        $scope.clearForm()
        growl.addSuccessMessage('Delimiter successfully saved!')
        updateDelimiterDetails()
      , (response) ->
        if response.status == 403
          if response.data.reason == 'Empty access token'
              growl.addErrorMessage('Empty access token!')

      )

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
