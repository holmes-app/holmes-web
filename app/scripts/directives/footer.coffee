'use strict'

angular.module('holmesApp')
  .directive('holmesfooter', ->
    replace: true
    templateUrl: 'views/footer.html'
    restrict: 'E'
    controller: ($scope, $rootScope, $location, $cookies, APIVersionFcty, packageJson, WebSocketFcty, AuthSrvc) ->

      APIVersionFcty.getAPIVersion().then( (version) ->
        $scope.apiVersion = version
      )

      $scope.holmesWebVersion = packageJson.version

      $scope.auth = AuthSrvc

  )
