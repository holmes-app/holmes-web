'use strict'

angular.module('holmesApp')
  .directive('headersearch', ($timeout) ->
    templateUrl: 'views/headersearch.html'
    restrict: 'E'
    replace: true,
    link: (scope, element, attrs) ->
      body = $('body')
      body.append($(element).find('.search-form').detach())
    controller: ($scope, Restangular, $location, $NamedRouteService) ->
      $scope.clearForm = () ->
        $scope.model =
          term: ''
          urlHttpSuggest: ''
          urlHttpSuggestMethod: ''
          urlHttpSuggestAct: ''
        if $scope.searchForm and $scope.searchForm.url
          $scope.searchForm.url.$pristine = true

      $scope.search = () ->
        $timeout ->
          if !$scope.searchForm.url.$valid
            value = $scope.searchForm.url.$viewValue
            if value?
              $scope.toggleSearch()
              no_protocol_re = /^(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?$/
              if !no_protocol_re.test(value)
                $scope.model.headerWitchOne = 'form_invalid'
              else
                $scope.model.urlHttpSuggest = 'http://' + value
                $scope.model.urlHttpSuggestMethod = $scope.search
                $scope.model.urlHttpSuggestAct = 'search for'
                $scope.model.headerWitchOne = 'missing_protocol'
              $scope.model.alertMessageVisible = true
          else
            Restangular.one('search').get({term: $scope.model.url}).then((page) ->
              page = JSON.parse(page) if typeof page == 'string'
              if page?
                # FIXME: Remove replace
                review_url = $NamedRouteService.reverse('review', [page.domain, page.uuid , page.reviewId]).replace('#!', '')
                $location.path(review_url)
                $scope.toggleSearch()
              else
                $scope.model.headerWitchOne = 'invalid_page'
                $scope.model.alertMessageVisible = true
            )
  )
