'use strict'

class UserViolationsPrefsFactory
  constructor: (@restangular) ->

  getInitialUserViolationsPrefs: ->
    @restangular.one('users').one('violations-prefs').get()

  updateUserViolationsPrefs: (data) ->
    @restangular.one('users').post('violations-prefs', data)


angular.module('holmesApp')
  .factory 'UserViolationsPrefsFcty', (Restangular) ->
    return new UserViolationsPrefsFactory(Restangular)
