'use strict'

# TODO: make it work with object not just with array, perhaps in the link function attaching an observer to the scope
angular.module('holmesApp')
  .directive 'nodata', ($rootScope) ->
    restrict: 'A'
    replace: true
    transclude: true
    scope:
      nodataCollection: '=nodata'
      nodataClass: '@nodataClass'
      nodataText: '@nodataText'
    template:
      '<div>
        <div ng-show="nodataCollection.length === undefined" class="nodata-container {{nodataClass ? nodataClass : \'no-data\'}}">Loading...</div>
        <div ng-show="nodataCollection.length === 0" class="nodata-container {{nodataClass ? nodataClass : \'no-data\'}}">{{nodataText ? nodataText : \'No data\'}}</div>
        <div ng-show="nodataCollection.length > 0" ng-transclude>XPTO</div>
      </div>'
