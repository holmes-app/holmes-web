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
    template: (element, attr) ->
      nodeName = element[0].nodeName
      nodataClass = if attr.nodataClass? then attr.nodataClass else 'no-data'
      nodataFadeClass = if attr.nodataFade != 'no' then 'no-data-fade' else ''
      nodataLoading = if attr.nodataLoading? then attr.nodataLoading else 'Loading...'
      nodataText = if attr.nodataText? then attr.nodataText else 'No data!'
      nodataFailed = if attr.nodataFailed? then attr.nodataFailed else 'Loading failed!'
      "<div>
        <div ng-show='nodataFlagger === undefined' class='#{nodataClass}'>
          <div class='loading' ng-if='!nodataSize'>#{nodataLoading}</div>
          <div id='fountainG' ng-if='nodataSize'>
            <div id='fountainG_1' class='fountainG'></div>
            <div id='fountainG_2' class='fountainG'></div>
            <div id='fountainG_3' class='fountainG'></div>
            <div id='fountainG_4' class='fountainG'></div>
            <div id='fountainG_5' class='fountainG'></div>
            <div id='fountainG_6' class='fountainG'></div>
            <div id='fountainG_7' class='fountainG'></div>
            <div id='fountainG_8' class='fountainG'></div>
          </div>
        </div>
        <div ng-show='nodataFlagger === false || nodataFlagger == 0' class='#{nodataClass}'>
          <div ng-if='nodataText' class='nodata'>#{nodataText}</div>
        </div>
        <div ng-show='nodataFlagger === null' class='#{nodataClass}'>
          <div class='failed'>#{nodataFailed}</div>
        </div>
        <#{nodeName} ng-show='nodataFlagger' class='#{nodataFadeClass}' ng-transclude></#{nodeName}>
      </div>"
    link: (scope, element, attr) ->
      if scope.nodataHeight?
        element.children().first().height(scope.nodataHeight)

      computeAndSet = (value) ->
        size = if scope.nodataSize? then scope.nodataSize else 60
        width = 8 * size
        height = size - 2
        marginLeft = -width / 2
        marginTop = -height * 2 / 3
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
          element.find(elementId).css
            left: i * size

      scope.$watch 'nodataHeight', computeAndSet
      scope.$watch 'nodataSize', computeAndSet
