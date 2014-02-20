'use strict'

angular.module('holmesApp')
  .directive('headersearch', () ->
    templateUrl: 'views/headersearch.html'
    restrict: 'E'
    replace: true,
    link: (scope, element, attrs) ->
      body = $('body')
      body.append($(element).find('.search-form').detach())
  )
