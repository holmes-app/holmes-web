'use strict'

angular.module('holmesApp')
  .directive('headeraddpage', ($timeout) ->
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
          urlHttpSuggest: ''
        if $scope.addPageForm and $scope.addPageForm.url
          $scope.addPageForm.url.$pristine = true

      $scope.addPage = () ->
        $timeout ->
          if !$scope.addPageForm.url.$valid
            value = $scope.addPageForm.url.$viewValue
            if value?
              $scope.clearForm()
              $scope.toggleAddPage()
              $scope.model.alertMessageVisible = true
              no_protocol_re = /^(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?$/
              if !no_protocol_re.test(value)
                $scope.model.headerWitchOne = 'form_invalid'
              else
                $scope.model.urlHttpSuggest = 'http://' + value
                $scope.model.headerWitchOne = 'missing_protocol'
          else
            Restangular.all('page').post({url: $scope.model.url}).then((page) ->
              $scope.clearForm()
              $scope.toggleAddPage()
              $scope.model.alertMessageVisible = true
              $scope.model.headerWitchOne = 'success_page'
            , (response) ->
              if response.status == 400
                if response.data.reason == 'redirect'
                  $scope.model.turnsOut = response.data.effectiveUrl
                $scope.model.alertMessageVisible = true
                $scope.model.headerWitchOne = response.data.reason
            )
  )
