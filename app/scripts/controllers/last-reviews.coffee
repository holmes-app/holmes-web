'use strict'

class LastReviewsCtrl
  constructor: (@scope, @LastReviewsFcty, @DomainsFcty, @WebSocketFcty) ->
    @lastReviews = []

    @getDomainsList()
    @getLastReviews()

    @WebSocketFcty.on((message) =>
      @getLastReviews() if message.type == 'new-review'
    )

    @scope.$on '$destroy', @_cleanUp

  _cleanUp: =>
    @WebSocketFcty.clearHandlers()

  _fillReviews: (reviews) =>
    @lastReviews = reviews
    @loadedReviews = reviews.length

  _fillReviewsInLastHour: (reviews) =>
    @lastReviewsInLastHour = reviews
    @lastReviewsInLastHour.perHour = @lastReviewsInLastHour.count / @lastReviewsInLastHour.ellapsed

    @loadedReviewsInLastHour = true

  hasSelectedDomain: ->
    not @domainsSelected.placeholder?

  clearDomainDropdown: ->
    @domainsSelected = {text: 'Filter domain', placeholder: true}

  _fillDomainsList: (domains) =>
    @domainsOptions = ({text: domain.name} for domain in domains)

  getDomainsList: ->
    @DomainsFcty.getDomains().then @_fillDomainsList, =>
      @domainsOptions = []
    @clearDomainDropdown()

  getDomainParams: ->
    if @domainsSelected.placeholder == true
      {}
    else
      {domain_filter: @domainsSelected.text}

  getLastReviews: ->
    @LastReviewsFcty.getLastReviews(@getDomainParams()).then @_fillReviews, =>
      @loadedReviews = null

    @LastReviewsFcty.getReviewsInLastHour(@getDomainParams()).then @_fillReviewsInLastHour, =>
      @loadedReviewsInLastHour = null


angular.module('holmesApp')
  .controller 'LastReviewsCtrl', ($scope, LastReviewsFcty, DomainsFcty, WebSocketFcty) ->
    $scope.model = new LastReviewsCtrl($scope, LastReviewsFcty, DomainsFcty, WebSocketFcty)
