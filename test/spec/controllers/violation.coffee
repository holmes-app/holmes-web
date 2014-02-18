'use strict'

describe 'Controller: ViolationCtrl', () ->

  # load the controller's module
  beforeEach module 'holmesApp'

  ViolationCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ViolationCtrl = $controller 'ViolationCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
