'use strict'

angular.module('holmesApp')
  .directive('holmesfooter', ->
    replace: true
    templateUrl: 'views/footer.html'
    restrict: 'E'
    controller: ($scope, APIVersionFcty, packageJson, AuthSrvc) ->

      APIVersionFcty.getAPIVersion().then( (version) ->
        $scope.apiVersion = version
      )

      $scope.holmesWebVersion = packageJson.version

      $scope.auth = AuthSrvc

  )
