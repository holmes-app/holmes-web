'use strict'

class ConcurrentRequestsCtrl
  constructor: (@scope, @timeout, @LimitersFcty, @DomainsFcty, @cookieStore) ->
    @isFormVisible = false
    @newLimitPath = ''
    @limiters = []
    @access_token = ''
    @newLimitConcurrentConnections = 5

    @limiterToRemove = null

    @clearForm()
    @getDomainsList()
    @updateConcurrentDetails()

    @isFormVisible = if @cookieStore.get('HOLMES_AUTH_TOKEN') then true else false

    updateDetails = =>
      @updateTimer = @timeout(=>
        @timeout.cancel(@updateTimer) if @updateTimer?
        @updateConcurrentDetails()
        @updateTimer = null
        updateDetails()
      , 1000)

    updateDetails()

    @scope.$on '$destroy', @_cleanUp

  _cleanUp: =>
    @timeout.cancel(@updateTimer) if @updateTimer?

  _fillConcurrentDetails: (limiters) =>
    @limiters = limiters
    @loadedLimiters = limiters.length

  updateConcurrentDetails: ->
    @LimitersFcty.getLimiters(@getDomainParams()).then(@_fillConcurrentDetails, =>
      @loadedLimiters = null
    )

  clearForm: =>
    @newLimitPath = ''

  limiterSaveData: (data) ->
    @LimitersFcty.postLimiters(data).then((limiters) =>
      @clearForm()
      @updateConcurrentDetails()
    , (response) ->
      if response.status == 403
        if response.data.reason == 'Empty access token'
          console.log('Empty access token!')
    )

  addLimiter: ->
    @limiterSaveData(url: @scope.model.newLimitPath, value: @scope.model.value)

  removeLimiter: (limiter) =>
    @LimitersFcty.deleteLimiter(limiter).then =>
      @clearForm()
      @updateConcurrentDetails()
    , (response) ->
      if response.status == 403
        if response.data.reason == 'Empty access token'
          console.log('Empty access token!')

  saveNewLimit: (limiter) ->
    limiter.isCurrentValueVisible = true

    @timeout.cancel(limiter.currentTimer) if limiter.currentTimer?

    limiter.currentTimer = @timeout( =>
      newValue = parseInt(limiter.maxValue , 10)
      newValue = 200 if newValue > 200
      @limiterSaveData({url: limiter.url, value: newValue})
      limiter.isCurrentValueVisible = false
      limiter.currentTimer = null
    , 1000)

  clearDomainDropdown: ->
    @domainsSelected = {text: 'Filter domain', placeholder: true}
    @updateConcurrentDetails()

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

angular.module('holmesApp')
  .controller 'ConcurrentCtrl', ($scope, $timeout, LimitersFcty, DomainsFcty, $cookieStore) ->
    $scope.model = new ConcurrentRequestsCtrl($scope, $timeout, LimitersFcty, DomainsFcty, $cookieStore)
