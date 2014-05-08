'use strict'

class Pager
  constructor: (@scope, @element, @attrs) ->
    @elements = {}
    @options = {}

    @getOptions()
    @gatherElements()
    @updatePager()
    @bindEvents()
    @watchScope()

  getOptions: ->
    @options.noCount = @scope.nocount == true
    @options.visiblePageCount = if @options.noCount then 1 else @scope.visiblepagecount || 10
    @options.pageSize = @scope.pagesize || 10
    @options.pageCount = Math.ceil(@scope.pagecount / @options.pageSize)
    @options.currentPage = @scope.current || 1
    @options.onPageChange = @scope.pagechange

  gatherElements: ->
    @elements.previous = @element.find('.previous')
    @elements.pages = @element.find('.pages')
    @elements.next = @element.find('.next')

  bindEvents: ->
    @elements.pages.on 'click', 'a', (ev) =>
      link = $(ev.currentTarget)
      page = link.attr('data-current-page')
      @options.currentPage = parseInt(page, 10)
      @options.onPageChange(@options.currentPage, @options.pageSize)
      @updatePager()

    @elements.previous.on 'click', (ev) =>
      @options.currentPage -= @options.visiblePageCount
      @options.currentPage = 1 if @options.currentPage <= 1
      @options.onPageChange(@options.currentPage, @options.pageSize)
      @updatePager()

    @elements.next.on 'click', (ev) =>
      @options.currentPage += @options.visiblePageCount
      @options.currentPage = @options.pageCount if @options.currentPage > @options.pageCount
      @options.onPageChange(@options.currentPage, @options.pageSize)
      @updatePager()

  watchScope: ->
    @scope.$watch('pagecount', =>
      @options.pageCount = Math.ceil(@scope.pagecount / @options.pageSize)
      @updatePager()
    )
    @scope.$watch('pagesize', =>
      @options.pageSize = @scope.pagesize || 10
      @options.pageCount = Math.ceil(@scope.pagecount / @options.pageSize)
      @updatePager()
    )

  updatePager: ->
    @elements.pages.html('')
    halfPages = (@options.visiblePageCount / 2)

    if @options.noCount
      start = @options.currentPage
      end = @options.currentPage
    else if @options.currentPage <= halfPages
      start = 1
      end = @options.visiblePageCount
    else if @options.currentPage > @options.pageCount - halfPages
      start = @options.pageCount - @options.visiblePageCount + 1
      end = @options.pageCount
    else
      start = @options.currentPage - halfPages + 1
      end = @options.currentPage + halfPages

    start = 1 if start < 0
    end = @options.pageCount if end > @options.pageCount

    for i in [start..end]
      kls = ''
      kls = ' current' if i == @options.currentPage
      @elements.pages.append("<li class=\"page#{ kls }\"><a data-current-page=\"#{i}\">#{ i }</a></li>")

    @elements.previous.addClass('hidden') if @options.currentPage <= 1
    @elements.previous.removeClass('hidden') unless @options.currentPage <= 1

    @elements.next.addClass('hidden') if @options.currentPage >= @options.pageCount
    @elements.next.removeClass('hidden') unless @options.currentPage >= @options.pageCount

angular.module('holmesApp')
  .directive('pager', () ->
    template: '<div class="pager"><a class="previous"><i></i></a><ul class="pages"></ul><a class="next"><i></i></a></div>'
    restrict: 'E'
    replace: true
    scope:
        nocount: '='
        pagecount: '='
        current: '='
        pagesize: '='
        pagechange: '='
    link: (scope, element, attrs) ->
      pager = new Pager(scope, element, attrs)
  )
