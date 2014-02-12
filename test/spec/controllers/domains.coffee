'use strict'

describe 'Controller: DomainsCtrl', () ->

  # load the controller's module
  beforeEach module 'holmesApp'

  DomainsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DomainsCtrl = $controller 'DomainsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
