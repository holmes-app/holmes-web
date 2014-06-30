'use strict'

angular.module('holmesApp')
  .filter('userviolationsprefsdomainsfrequency', ->
    (value, userPrefs, displayAll) ->
      _.filter(value, (item) ->
        if userPrefs is undefined or item.category not of userPrefs
          return true
        test = _.find(userPrefs[item.category], {'key': item.key})
        displayAll or test.is_active == true
      )
  )
