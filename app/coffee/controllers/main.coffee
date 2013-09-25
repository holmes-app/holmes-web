'use strict'

angular.module('holmesApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.model =
      url: ''

    $scope.addPage = (url) ->
      console.log(url)
      alertify.success(url + ' successfully saved!')
