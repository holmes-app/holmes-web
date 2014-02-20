'use strict'

describe 'Controller: ReviewPipelineCtrl', () ->

  # load the controller's module
  beforeEach module 'holmesApp'

  ReviewPipelineCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ReviewPipelineCtrl = $controller 'ReviewPipelineCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
