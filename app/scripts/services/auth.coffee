'use strict'

class AuthService
  constructor: (@rootScope, @location, @restangular, @googlePlus, @localStorage, @UserViolationsPrefsFcty) ->
    @bindEvents()

  bindEvents: ->
    @rootScope.$on('unauthorizedRequest', (event) =>
      @logout()
    )
    @rootScope.$on('$locationChangeStart', (e, n, p) =>
      @getAuthenticationFlags()
    )

  getAuthentication: ->
    @restangular.one('authenticate').get()

  removeAuthentication: ->
    @restangular.one('authenticate').remove()

  authenticate: (data) ->
    @restangular.all('authenticate').post(data)

  getAuthenticationFlags: ->
    @getAuthentication().then((response) =>
      @rootScope.isLoggedIn = response.authenticated
      @rootScope.isSuperUser = response.isSuperUser
      @logoutIfNotAuthenticated()
    )

  logoutIfNotAuthenticated: ->
    if @rootScope.isLoggedIn is false
      @logout()

  redirectIfAuthenticated: ->
    if @rootScope.isLoggedIn is true
      @location.url '/'

  redirectIfNotSuperUser: (path) ->
    if @rootScope.isSuperUser is false
      @location.url path

  logout: ->
    @removeAuthentication().then((result) =>
      if result.loggedOut
        @rootScope.isLoggedIn = false
        @location.url "/login"
    )

  googleLogin: ->
    @googlePlus.login().then((authResult) =>
      data = {
        access_token: authResult.access_token,
        provider: 'GooglePlus'
      }
      @authenticate(data).then((response) =>
        if response.authenticated
          @rootScope.isLoggedIn = true

          @UserViolationsPrefsFcty.getInitialUserViolationsPrefs().then((data) =>
            @localStorage.userprefs = _.groupBy(data, 'category')
          )

          if response.first_login
            @location.url "/user/violations/prefs/"
          else
            @location.url "/"
        else
          @logout()
      , ->
        @logout()
      )
    , (err) ->
      @logout()
    )

angular.module('holmesApp')
  .service('AuthSrvc', ($rootScope, $location, Restangular, GooglePlus, $localStorage, UserViolationsPrefsFcty, WebSocketFcty) ->
    return new AuthService($rootScope, $location, Restangular, GooglePlus, $localStorage, UserViolationsPrefsFcty)
  )
