'use strict'

angular.module('holmesApp')
  .directive('holmesfooter', () ->
    replace: true
    templateUrl: 'views/footer.html'
    restrict: 'E'
    controller: ($scope, $cookieStore, GooglePlus, APIVersionFcty, packageJson) ->
      reloadPage = ->
        window.location.reload(true)

      APIVersionFcty.getAPIVersion().then( (version) ->
        $scope.apiVersion = version
      )

      $scope.holmesWebVersion = packageJson.version

      $scope.isFormVisible = if $cookieStore.get('HOLMES_AUTH_TOKEN') then true else false

      $scope.logout = () ->
        $cookieStore.remove('HOLMES_AUTH_TOKEN')
        reloadPage()

      $scope.login = () ->
        GooglePlus.login().then((data) =>
          authResult = GooglePlus.getToken()
          $cookieStore.put('HOLMES_AUTH_TOKEN', authResult.access_token)
          reloadPage()
        , (err) ->
          $scope.logout()
        )

  )
