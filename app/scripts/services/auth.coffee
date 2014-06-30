'use strict'

class AuthService
  constructor: (@rootScope, @cookies, @location, @restangular, @googlePlus, @localStorage, @UserViolationsPrefsFcty) ->
    @cookieName = 'HOLMES_AUTH_TOKEN'
    @rootScope.isLoggedIn = true
    @bindEvents()

  bindEvents: ->
    @rootScope.$on('unauthorized-request', (event) =>
      @logout()
    )

  isAuthenticated: ->
    @restangular.one('authenticate').get()

  authenticate: (data) ->
    @restangular.all('authenticate').post(data)

  logoutIfNotAuthenticated: ->
    if @rootScope.isLoggedIn
      @isAuthenticated().then((response) =>
        if !response.authenticated
          @logout()
      )
    else
      @logout()

  redirectIfAuthenticated: ->
    if @rootScope.isLoggedIn
      @isAuthenticated().then((response) =>
        if response.authenticated
          @location.url '/'
      )

  removeAuthCookie: ->
    delete @cookies[@cookieName]

  logout: ->
    @rootScope.isLoggedIn = false
    @removeAuthCookie()
    @location.url "/login"

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
  .service('AuthSrvc', ($rootScope, $cookies, $location, Restangular, GooglePlus, $localStorage, UserViolationsPrefsFcty) ->
    return new AuthService($rootScope, $cookies, $location, Restangular, GooglePlus, $localStorage, UserViolationsPrefsFcty)
  )
