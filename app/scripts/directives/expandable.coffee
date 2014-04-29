'use strict'

class ExpandableCtrl
  constructor: (@scope, @contentHeight, @elementHeight, @scrollToOffset) ->
    @inverse = false
    @inverse = @scope.inverse if @scope.inverse?
    if !@inverse
      @expanded = false
    else
      @expanded = true
      @expandContent(false)

  getMaxHeight: ->
    return if @expanded then "max-height: #{@contentHeight}px" else ''

  hasOverflow: ->
    return @contentHeight > @elementHeight

  isExpandable: ->
    if @hasOverflow() and !@expanded then true else false

  isCollapsable: ->
    if @expanded then true else false

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
