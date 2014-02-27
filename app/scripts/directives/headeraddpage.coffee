'use strict'

angular.module('holmesApp')
  .directive('headeraddpage', () ->
    templateUrl: 'views/headeraddpage.html'
    restrict: 'E'
    replace: true
    link: (scope, element, attrs) ->
      body = $('body')
      body.append($(element).find('.add-page-form').detach())
    controller: ($scope, Restangular) ->
      $scope.clearForm = () ->
        $scope.model =
            url: ''
            turnsOut: ''
            invalidUrl: ''
        $scope.addPageForm.url.$pristine = true if $scope.addPageForm and $scope.addPageForm.url

      $scope.addPage = () ->
        url = $scope.model.url

        Restangular.all('page').post({url: url}).then((page) ->
          $scope.clearForm()
          $scope.toggleAddPage()
        , (response) ->
          if response.status == 400
            if response.data.reason == 'invalid_url'
              $scope.model.invalidUrl = response.data.url

            if response.data.reason == 'redirect'
              $scope.model.turnsOut = response.data.effectiveUrl
        )
  )
