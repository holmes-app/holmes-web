'use strict'

class ConcurrentRequestsCtrl
  constructor: (@scope, @timeout, @LimitersFcty, @cookieStore) ->
    @isFormVisible = false
    @newLimitPath = ''
    @limiters = []
    @access_token = ''
    @newLimitConcurrentConnections = 5

    @clearForm()
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

  _fillConcurrentDetails: (limiters) =>
    @limiters = limiters

  updateConcurrentDetails: ->
    @LimitersFcty.getLimiters().then(@_fillConcurrentDetails)

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


angular.module('holmesApp')
  .controller 'ConcurrentCtrl', ($scope, $timeout, LimitersFcty, $cookieStore) ->
    $scope.model = new ConcurrentRequestsCtrl($scope, $timeout, LimitersFcty, $cookieStore)
