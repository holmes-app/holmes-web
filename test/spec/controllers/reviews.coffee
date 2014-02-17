'use strict'

describe 'Controller: ReviewsCtrl', () ->

  # load the controller's module
  beforeEach module 'holmesApp'

  ReviewsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ReviewsCtrl = $controller 'ReviewsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
