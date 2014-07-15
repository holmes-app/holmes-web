'use strict'

class UserLocaleFactory
  constructor: (@restangular) ->

  getUserLocale: ->
    @restangular.one('users').one('locale').get()

  updateUserLocale: (data) ->
    @restangular.one('users').post('locale', {locale: data})


angular.module('holmesApp')
  .factory 'UserLocaleFcty', (Restangular) ->
    return new UserLocaleFactory(Restangular)

