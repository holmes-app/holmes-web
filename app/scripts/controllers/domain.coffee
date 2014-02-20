'use strict'

class DomainCtrl
  constructor: (@scope, @DomainsFcty, @domainName) ->
    @selectedCategory = null
    @numberOfPages = 0
    @reviewCount = 0
    @domain_url = ''
    @reviewFilter = ''
    @reviews = {}

    @getReviewsData()
    @getDomainDetails()
    @watchScope()

    @domainCategories = [
      { id: 1, label: 'SEO Violations', value: 31.79, pageCount: 198542, color: 'color1' },
      { id: 2, label: 'Semantics Violations', value: 27.76, pageCount: 173356, color: 'color2' },
      { id: 3, label: 'Performance Violations', value: 22.79, pageCount: 142345, color: 'color3' },
      { id: 4, label: 'HTTP Violations', value: 17.65, pageCount: 110230, color: 'color4' },
    ]

    mockViolations = [
      { occurrences: 23253, title: 'Broken link(s) found.' },
      { occurrences: 35288, title: 'CSS size in kb is too big.' },
      { occurrences: 31128, title: 'Disallow in Robots not found.' },
      { occurrences: 19547, title: 'Disallow: / in Robots.' },
      { occurrences: 17354, title: 'Domain Blacklisted.' },
      { occurrences: 14225, title: 'Empty anchor(s) found.' },
      { occurrences: 12125, title: 'Image not found.' },
      { occurrences: 10251, title: 'Image(s) without alt attribute.' },
      { occurrences: 7245, title: 'itemscope attribute missing in body.' },
      { occurrences: 7245, title: 'itemtype attribute is invalid.' },
    ]

    @violationData =
      1: mockViolations
      2: mockViolations
      3: mockViolations
      4: mockViolations

    @selectedCategory =
      title: @domainCategories[0].label
      percentage: @domainCategories[0].value
      pageCount: @domainCategories[0].pageCount
      color: @domainCategories[0].color
      violations: @violationData[@domainCategories[0].id]

  getReviewsData: (currentPage, pageSize) ->
    filter = @domain_url + @reviewFilter
    @DomainsFcty.one(@domainName).one('reviews').get({current_page: currentPage, page_size: pageSize, term: filter}).then (data) =>
      @reviews = data
      @reviewCount = @reviews.reviewCount
      @numberOfPages = @reviewCount

  getDomainDetails: ->
    @DomainsFcty.one(@domainName).get().then (data) =>
      @domain_details = data
      @domain_url = if data.url.slice(-1) == '/' then data.url else "#{ data.url }/"

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

  updateReviews: (currentPage, pageSize) =>
    @getReviewsData(currentPage, pageSize)

  watchScope: ->
    updateReviewData = $.debounce(500, =>
      @getReviewsData()
    )

    @scope.$watch('model.reviewFilter', updateReviewData)

angular.module('holmesApp')
  .controller 'DomainCtrl', ($scope, DomainsFcty, $routeParams) ->
    $scope.model = new DomainCtrl($scope, DomainsFcty, $routeParams.domainName)
