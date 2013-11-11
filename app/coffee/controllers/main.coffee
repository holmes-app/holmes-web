'use strict'

angular.module('holmesApp')
  .controller 'MainCtrl', ($scope, $timeout, growl, $resource, $http, Restangular) ->
    $http.defaults.useXDomain = true

    $scope.clearForm = ->
      $scope.model =
        url: ''
        turnsOut: ''
        invalidUrl: ''

      $scope.addPageForm.url.$pristine = true if $scope.addPageForm

    $scope.clearForm()

    $scope.addPage = () ->
      url = $scope.model.url
      $scope.model.turnsOut = ''
      $scope.model.invalidUrl = ''

      pages = Restangular.all('page')
      page = pages.post({ url: url }).then((page) ->
        $scope.clearForm()

        growl.addSuccessMessage(url + ' successfully saved!')
      , (response) ->
        if response.status == 400
          if response.data.reason == 'invalid_url'
            $scope.model.invalidUrl = response.data.url

          if response.data.reason == 'redirect'
            $scope.model.turnsOut = response.data.effectiveUrl
      )
