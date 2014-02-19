'use strict'

describe 'Controller: WorkersCtrl', () ->

  # load the controller's module
  beforeEach module 'holmesApp'

  WorkersCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    WorkersCtrl = $controller 'WorkersCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
