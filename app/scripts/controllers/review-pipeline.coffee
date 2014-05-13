'use strict'

class ReviewPipelineCtrl
  constructor: (@scope, @NextJobsFcty, @WebSocketFcty, @DomainsFcty) ->
    @reviews = []
    @pageSize = 10

    @getDomainsList()
    @getReviews()

    @WebSocketFcty.on((message) =>
      @getReviews(@currentPage, @pageSize)
    )

    @scope.$on '$destroy', @_cleanUp

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillReviews: (data) =>
    @reviews = data.pages
    @reviewsLoaded = data.pages.length
    if @reviewsLoaded > 0 and not @hasReviews
      @hasReviews = true

  clearDomainDropdown: ->
    @domainsSelected = {text: 'Filter domain', placeholder: true}
    @onPageChange()

  _fillDomainsList: (domains) =>
    @domainsOptions = ({text: domain.name} for domain in domains)

  getDomainsList: ->
    @DomainsFcty.getDomains().then @_fillDomainsList, =>
      @domainsOptions = []
    @clearDomainDropdown()

  appendDomainParams: (params) ->
    if @domainsSelected.placeholder != true
      params['domain_filter'] = @domainsSelected.text
    return params

  getReviews: (currentPage, pageSize) ->
    pageSize = if not pageSize then @pageSize
    params = {current_page: currentPage, page_size: pageSize}
    @NextJobsFcty.getNextJobs(@appendDomainParams(params)).then @_fillReviews, =>
      @reviewsLoaded = null

  onPageChange: (currentPage, pageSize) =>
    pageSize = if not pageSize then @pageSize
    @currentPage = if currentPage? then currentPage else 1
    @getReviews(@currentPage, pageSize)



angular.module('holmesApp')
  .controller 'ReviewPipelineCtrl', ($scope, NextJobsFcty, WebSocketFcty, DomainsFcty) ->
    $scope.model = new ReviewPipelineCtrl($scope, NextJobsFcty, WebSocketFcty, DomainsFcty)
