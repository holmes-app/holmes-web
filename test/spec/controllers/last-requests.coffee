'use strict'

describe 'Controller: LastRequestsCtrl', () ->

  # load the controller's module
  beforeEach module 'holmesApp'

  LastRequestsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    LastRequestsCtrl = $controller 'LastRequestsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
