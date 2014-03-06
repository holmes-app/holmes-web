'use strict'

describe 'Controller: ConcurrentCtrl', () ->

  # load the controller's module
  beforeEach module 'holmesApp'

  ConcurrentCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ConcurrentCtrl = $controller 'ConcurrentCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
