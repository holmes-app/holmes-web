'use strict'

angular.module('holmesApp')
  .filter('userviolationsprefsreviews', ->
    (value, userPrefs, displayAll) ->
      _.filter(value,  (group) ->
        group.filteredViolations = _.filter(group.violations, (item) ->
          if userPrefs is undefined or item.category not of userPrefs
              return true
          test = _.find(userPrefs[item.category], {'key': item.key})
          displayAll or test.is_active == true
        )
        return group if group.filteredViolations.length > 0
      )
  )
