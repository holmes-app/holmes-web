'use strict'

describe 'Controller: LastReviewsCtrl', () ->

  # load the controller's module
  beforeEach module 'holmesApp'

  LastReviewsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    LastReviewsCtrl = $controller 'LastReviewsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
