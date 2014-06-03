'use strict'

class DomainsViolationsPrefsUnitsDirective
  constructor: (@scope) ->


angular.module('holmesApp')
  .directive('domainsviolationsprefsunit', () ->
    replace: true
    templateUrl: 'views/domains-violations-prefs-units.html'
    restrict: 'E'
    scope:
      prefData: '='
    link: (scope, element, attrs) ->
      scope.model = new DomainsViolationsPrefsUnitsDirective(scope)
  )
