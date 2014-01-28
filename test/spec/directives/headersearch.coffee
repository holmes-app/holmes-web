'use strict'

describe 'Directive: headersearch', () ->

  # load the directive's module
  beforeEach module 'holmesApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<headersearch></headersearch>'
    element = $compile(element) scope
    #expect(element.text()).toBe 'this is the headersearch directive'
