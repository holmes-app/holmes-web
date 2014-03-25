'use strict'

angular.module('holmesApp')
  .directive 'nodata', ($rootScope) ->
    restrict: 'A'
    replace: true
    transclude: true
    scope:
      nodataFlagger: '=nodata'
      nodataClass: '@nodataClass'
      nodataLoading: '@nodataLoading'
      nodataText: '@nodataText'
      nodataFailed: '@nodataFailed'
      nodataHeight: '@nodataHeight'
      nodataSize: '@nodataSize'
    template:
      '<div>
        <div ng-show="nodataFlagger === undefined" class="{{nodataClass ? nodataClass : \'no-data\'}}">
          <div class="loading" ng-if="!nodataSize">{{nodataLoading ? nodataLoading : \'Loading...\'}}</div>
          <div id="fountainG" ng-if="nodataSize">
            <div id="fountainG_1" class="fountainG"></div>
            <div id="fountainG_2" class="fountainG"></div>
            <div id="fountainG_3" class="fountainG"></div>
            <div id="fountainG_4" class="fountainG"></div>
            <div id="fountainG_5" class="fountainG"></div>
            <div id="fountainG_6" class="fountainG"></div>
            <div id="fountainG_7" class="fountainG"></div>
            <div id="fountainG_8" class="fountainG"></div>
          </div>
        </div>
        <div ng-show="nodataFlagger === false || nodataFlagger == 0" class="{{nodataClass ? nodataClass : \'no-data\'}}">
          <div class="nodata">{{nodataText ? nodataText : \'No data!\'}}</div>
        </div>
        <div ng-show="nodataFlagger === null" class="{{nodataClass ? nodataClass : \'no-data\'}}">
          <div class="failed">{{nodataFailed ? nodataFailed : \'Loading failed!\'}}</div>
        </div>
        <div ng-show="nodataFlagger" class="nodata-container" ng-transclude></div>
      </div>'
    link: (scope, element, attr) ->
      if scope.nodataHeight?
        element.children().first().height(scope.nodataHeight)

      computeAndSet = (value) ->
        size = if scope.nodataSize? then scope.nodataSize else 60
        console.log size
        width = 8 * size
        height = size - 2
        marginLeft = -width / 2
        marginTop = -height
        borderRadius = height * 2 / 3

        element.find('#fountainG').css
          width: width
          height: size
          marginLeft: marginLeft
          marginTop: marginTop

        element.find('.fountainG').css
          width: height
          height: height
          borderRadius: borderRadius

        for i in [1..7]
          elementId = '#fountainG_' + (i + 1)
          console.log elementId
          element.find(elementId).css
            left: i * size

      scope.$watch 'nodataHeight', computeAndSet
      scope.$watch 'nodataSize', computeAndSet
