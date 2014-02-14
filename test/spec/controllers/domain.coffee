'use strict'

describe 'Controller: DomainCtrl', () ->

  # load the controller's module
  beforeEach module 'holmesApp'

  DomainCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DomainCtrl = $controller 'DomainCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
