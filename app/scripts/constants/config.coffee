'use strict'

angular.module('holmesApp')
  .constant 'ConfigConst', {
    baseUrl: 'http://local.holmes.com:2368/'
    wsUrl: 'ws://local.holmes.com:2368/events/'
    timeToLive: 3000,
    currentLanguage: 'en_US',
    gettextDebug: true
  }
