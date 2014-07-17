'use strict'

class DomainsViolationsPrefsCtrl
  constructor: (@scope, @DomainsFcty, @domainName, @DomainsViolationsPrefsFcty, @growlNotifications, @AuthSrvc) ->
    @AuthSrvc.redirectIfNotSuperUser("/domains/#{@domainName}/")
    @currentTab = ''
    @getDomainDetails()
    @getDomainsViolationsPrefs()

  _fillDomainDetails: (data) =>
    @domain_details = data

  _fillDomainsViolationsPrefs: (data) =>
    grouped = _.groupBy(data, 'category')
    sortedKeys = _.keys(grouped).sort()

    @domain_violations_prefs = {}
    for key in sortedKeys
      @domain_violations_prefs[key] = grouped[key]

    if @domain_violations_prefs?
      @currentTab = _.first(_.keys(@domain_violations_prefs))

  _fillUpdatePrefs: (data) =>
    @growlNotifications.add(data.reason, 'success', 2000)

  onClickTab: (data) =>
    @currentTab = data

  getDomainDetails: ->
    @DomainsFcty.getDomainData(@domainName).then @_fillDomainDetails, =>
      @loadedDomainDetails = null

  getDomainsViolationsPrefs: ->
    @DomainsViolationsPrefsFcty.getDomainsViolationsPrefs(@domainName).then @_fillDomainsViolationsPrefs, =>
      @loadedDomainsViolationsPrefs = null

  updatePrefs: =>
    prefs = []
    for category, elements of @domain_violations_prefs
      for el in elements
        if el['unit'] == 'list'
          # Workaround because ngTagsInput expect an array of objects
          item = _.pluck(el['value'], 'text')
        else
          item = el['value']
        prefs.push({'key': el['key'], 'value': item})

    @DomainsViolationsPrefsFcty.updateDomainsViolationsPrefs(@domainName, prefs).then @_fillUpdatePrefs, (error) =>
      @growlNotifications.add(error.data.reason, 'error', 2000)


angular.module('holmesApp') 
  .controller 'DomainsViolationsPrefsCtrl', ($scope, DomainsFcty, $routeParams, DomainsViolationsPrefsFcty, growlNotifications, AuthSrvc) ->
    $scope.model = new DomainsViolationsPrefsCtrl($scope, DomainsFcty, $routeParams.domainName, DomainsViolationsPrefsFcty, growlNotifications, AuthSrvc)
