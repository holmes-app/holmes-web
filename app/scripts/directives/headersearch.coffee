'use strict'

angular.module('holmesApp')
  .directive('headersearch', () ->
    templateUrl: 'views/headersearch.html'
    restrict: 'E'
    replace: true,
    link: (scope, element, attrs) ->
      body = $('body')
      body.append($(element).find('.search-form').detach())
    controller: ($scope, Restangular, $location) ->
      $scope.model =
        term: ''

      $scope.search = () ->
        term = $scope.model.term
        Restangular.one('search').get({term: term}).then((page) ->
          page = JSON.parse(page) if typeof page == 'string'
          if page?
            $location.path('/page/' + page.uuid + '/review/' + page.reviewId)
            $scope.toggleSearch()
          else
            $scope.model.headerWitchOne = 'invalid_page'
            $scope.model.alertMessageVisible = true
        )
  )
