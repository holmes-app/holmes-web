'use strict'

angular.module('holmesApp')
  .directive('headeralertmessage', () ->
    templateUrl: 'views/headeralertmessage.html'
    restrict: 'E'
    replace: true
    link: (scope, element, attrs) ->
      body = $('body')
      body.append($(element).find('.alert-message').detach())
  )
