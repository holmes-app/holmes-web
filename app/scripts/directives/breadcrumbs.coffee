'use strict'

class BreadcrumbsCtrl
  constructor: (@scope, @breadcrumbs) ->
    @breadcrumbs.options = {}
    @scope.$watch('labels', (newValue, oldValue) =>
      @setBreadcrumbsOptions()
    )

  setBreadcrumbsOptions: () ->
    if @scope.labels?
      for key, value of @scope.labels
        if key? and value?
          if not @breadcrumbs.options?
            @breadcrumbs.options = {}
          @breadcrumbs.options[key] = value


angular.module('holmesApp')
  .directive('breadcrumbs', (breadcrumbs, $timeout) ->
    replace: true
    transclude: true
    restrict: 'E'
    scope:
      labels: '='
      labelkey: '@'
      labelvalue: '='
    templateUrl: 'views/breadcrumbs.html'
    link: (scope, element, attrs) ->
      $timeout ->
        scope.model = new BreadcrumbsCtrl(scope, breadcrumbs)
  )
