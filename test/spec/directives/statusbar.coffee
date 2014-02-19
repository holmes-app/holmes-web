'use strict'

describe 'Directive: statusbar', () ->

  # load the directive's module
  beforeEach module 'holmesApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<statusbar></statusbar>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the statusbar directive'
