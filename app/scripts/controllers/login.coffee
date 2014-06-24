'use strict'

class LoginCtrl
  constructor: (@scope, @location, @AuthSrvc) ->
    @AuthSrvc.redirectIfAuthenticated()

  googleLogin: ->
    @AuthSrvc.googleLogin()

angular.module('holmesApp')
  .controller 'LoginCtrl', ($scope, $location, AuthSrvc) ->
    $scope.model = new LoginCtrl($scope, $location, AuthSrvc)
