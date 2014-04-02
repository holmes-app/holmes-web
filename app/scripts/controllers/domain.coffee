'use strict'

class DomainCtrl
  constructor: (@scope, @DomainsFcty, @domainName, @WebSocketFcty) ->
    @selectedCategory = null
    @numberOfPages = 0
    @reviewCount = 0
    @domain_url = ''
    @reviewFilter = ''
    @reviews = {}
    @domainStatus = false
    @pageSize = 10

    @getDomainViolations()
    @getDomainDetails()
    @watchScope()

    @WebSocketFcty.on((message) =>
      if message.type == 'new-page' or message.type == 'new-review'
        @getDomainDetails()
        @getReviewsData()
        @getDomainViolations()
    )

    @violationData = {}

    @scope.$on '$destroy', @_cleanUp

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillViolationData: (data) =>
    @violationData[data.categoryId] = data.violations

  _fillDomainGroupedViolations: (data) =>
    if data.violations?
      for violation in data.violations
        @DomainsFcty.getDomainMostCommonViolations(data.domainName, violation.categoryId).then(@_fillViolationData)
      @loadedViolations = data.violations.length

      @domainGroupedViolations = _.map(
        data.violations,
        (violation, i) ->
          id: violation.categoryId
          label: violation.categoryName + ' Violations'
          value: 100 * violation.count / this.total
          pageCount: violation.count
          color: 'color' + (i + 1)
        data)
    else
      @loadedViolations = 0

  _fillReviews: (data) =>
    @reviews = data
    @reviewCount = @reviews.reviewCount
    @numberOfPages = @reviewCount
    @loadedReviews = if data.pages? then data.pages.length else 0

  _fillDomainDetails: (data) =>
    @domain_details = data
    @domainStatus = data.is_active
    @domain_url = if data.url.slice(-1) == '/' then data.url else "#{ data.url }/"

  _fillChangeDomainStatus: =>
    @domainStatus = !@domainStatus

  getDomainViolations: ->
    @DomainsFcty.getDomainGroupedViolations(@domainName).then @_fillDomainGroupedViolations, =>
      @loadedViolations = null

  getReviewsData: (currentPage, pageSize) =>
    filter = if @reviewFilter then @domain_url + @reviewFilter else ''
    params =
      current_page: currentPage
      page_size: if not pageSize then @pageSize
      term: filter
    @DomainsFcty.getDomainReviews(@domainName, params).then @_fillReviews, =>
      @loadedReviews = null

  getDomainDetails: ->
    @DomainsFcty.getDomainData(@domainName).then @_fillDomainDetails, =>
      @loadedDomainDetails = null

  onSelect: (value, data) =>
    if data?
      @selectedCategory =
        title: data.label
        percentage: data.value
        pageCount: data.pageCount
        color: data.color
        violations: @violationData[data.id]
    else
      @selectedCategory = null

  watchScope: ->
    updateReviewData = $.debounce(500, =>
      delete(@loadedReviews)
      @getReviewsData()
    )

    @scope.$watch('model.reviewFilter', updateReviewData)

  changeDomainStatus: ->
    @DomainsFcty.postChangeDomainStatus(@domainName).then(@_fillChangeDomainStatus)


angular.module('holmesApp')
  .controller 'DomainCtrl', ($scope, DomainsFcty, $routeParams, WebSocketFcty) ->
    $scope.model = new DomainCtrl($scope, DomainsFcty, $routeParams.domainName, WebSocketFcty)
