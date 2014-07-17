'use strict'

class UserViolationsPrefsCtrl
  constructor: (@scope, @UserViolationsPrefsFcty, @growlNotifications, @localStorage) ->
    @getPrefs()
    @selectedFlag = {}

  _fillPrefs: (data) =>
    @prefs = data
    @groupData = _.groupBy(@prefs, 'category')
    @localStorage.userprefs = @groupData

    for x of @groupData
      @selectedFlag[x] = ! _.some(@groupData[x], {'is_active': false})

  _fillUpdatePrefs: (data) =>
    @localStorage.userprefs = @groupData
    @growlNotifications.add(data.reason, 'success', 2000)

  getPrefs: ->
    @UserViolationsPrefsFcty.getInitialUserViolationsPrefs().then @_fillPrefs

  updatePrefs: =>
    @UserViolationsPrefsFcty.updateUserViolationsPrefs(@prefs).then @_fillUpdatePrefs, (error) =>
      @growlNotifications.add(error.data.reason, 'error', 2000)

  selectToggle: (category) =>
    for x in @groupData[category]
      x.is_active = ! @selectedFlag[category]
    @selectedFlag[category] = ! @selectedFlag[category]


angular.module('holmesApp')
  .controller 'UserViolationsPrefsCtrl', ($scope, UserViolationsPrefsFcty, growlNotifications, $localStorage) ->
    $scope.model = new UserViolationsPrefsCtrl($scope, UserViolationsPrefsFcty, growlNotifications, $localStorage)
