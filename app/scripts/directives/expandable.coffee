'use strict'

class ExpandableCtrl
  constructor: (@scope, @contentHeight, @elementHeight, @scrollToOffset) ->
    @inverse = if @scope.inverse? then @scope.inverse else false
    if !@inverse
      @collapseContent(false)
    else
      @expandContent(false)

  getMaxHeight: ->
    if @expanded then "max-height: #{@contentHeight}px" else ''

  hasOverflow: ->
    @contentHeight > @elementHeight

  isExpandable: ->
    @hasOverflow() and !@expanded

  isCollapsable: ->
    @hasOverflow() and @expanded

  expandContent: (doScroll=true) ->
    @expanded = true
    if doScroll
      @scrollToOffset()

  collapseContent: (doScroll=true) ->
    @expanded = false
    if doScroll
      @scrollToOffset()


angular.module('holmesApp')
  .directive('expandable', ($timeout) ->
    replace: true
    transclude: true
    restrict: 'E'
    scope:
      inverse: '='
    templateUrl: 'views/expandable.html'
    link: (scope, element, attrs) ->
      scrollToOffset = ->
        window.scrollTo('top', element.offset().top)

      $timeout ->
        contentHeight = element.find('.expandable-content :first-child')
                        .innerHeight()
        elementHeight = element.height()
        scope.model = new ExpandableCtrl(
          scope, contentHeight, elementHeight, scrollToOffset)
  )
