'use strict'

angular.module('holmesApp')
  .constant 'ConfigConst', {
    baseUrl: 'http://local.holmes.com:2368/'
    wsUrl: 'ws://local.holmes.com:2368/events/'
    timeToLive: 3000,
    currentLanguage: 'en_US',
    gettextDebug: true,
    googleClientId: '968129569472-1smbhidqeo3kpdj029cehmnp8qh808kv',
    googleApiKey: '68129569472-1smbhidqeo3kpdj029cehmnp8qh808kv.apps.googleusercontent.com',
    googleScopes: 'https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile'
  }
