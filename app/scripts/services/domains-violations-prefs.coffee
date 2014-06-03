'use strict'

class DomainsViolationsPrefsFactory
  constructor: (@restangular, @cookieStore) ->

  getDomainsViolationsPrefs: (domainName) ->
    @restangular.one('domains', domainName).one('violations-prefs').get()

  updateDomainsViolationsPrefs: (domainName, data) ->
    @restangular.one('domains', domainName).post('violations-prefs', data, {}, {'X-AUTH-HOLMES': @cookieStore.get('HOLMES_AUTH_TOKEN')})


angular.module('holmesApp')
  .factory 'DomainsViolationsPrefsFcty', (Restangular, $cookieStore) ->
    return new DomainsViolationsPrefsFactory(Restangular, $cookieStore)
