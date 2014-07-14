'use strict'

class DomainsViolationsPrefsFactory
  constructor: (@restangular) ->

  getDomainsViolationsPrefs: (domainName) ->
    @restangular.one('domains', domainName).one('violations-prefs').get()

  updateDomainsViolationsPrefs: (domainName, data) ->
    @restangular.one('domains', domainName).post('violations-prefs', data)


angular.module('holmesApp')
  .factory 'DomainsViolationsPrefsFcty', (Restangular) ->
    return new DomainsViolationsPrefsFactory(Restangular)
