'use strict'

angular.module('holmesApp')
  .filter('userviolationsprefsdomains', ->
    (value, userPrefs, displayAll) ->
      _.filter(value,  (items, key) ->
        group = _.filter(items, (item) ->
          if userPrefs is undefined or item.category not of userPrefs
            return true
          test = _.find(userPrefs[item.category], {'key': item.key})
          displayAll or test.is_active == true
        )
        return group.length > 0
      )
  )
