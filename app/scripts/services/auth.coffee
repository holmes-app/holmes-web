'use strict'

class AuthService
  constructor: (@rootScope, @cookies, @location, @restangular, @googlePlus) ->
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
          if response.first_login
            @location.path "/user/violations/prefs"
          @location.path "/"
        else
          @logout()
      , ->
        @logout()
      )
    , (err) ->
      @logout()
    )

angular.module('holmesApp')
  .service('AuthSrvc', ($rootScope, $cookies, $location, Restangular, GooglePlus) ->
    return new AuthService($rootScope, $cookies, $location, Restangular, GooglePlus)
  )
