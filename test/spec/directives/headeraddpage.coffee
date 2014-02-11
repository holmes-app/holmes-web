'use strict'

describe 'Directive: headeraddpage', () ->

  # load the directive's module
  beforeEach module 'holmesApp'
  beforeEach module 'views/headeraddpage.html'

  scope = {}
  elements = {}

  find = (selector, root) ->
    rootElement = elements.main
    rootElement = root if root?
    return angular.element(rootElement[0].querySelectorAll(selector))

  beforeEach inject ($controller, $rootScope, $compile) ->
    scope = $rootScope.$new()

    elements.main = angular.element '<div><headeraddpage></headeraddpage></div>'
    elements.main = $compile(elements.main) scope
    scope.$digest()  # ARGHHHHHHHHHHH IF I MISS THIS THE TEMPLATE IS NOT RENDERED!

    elements.addPage = find('.header-add-page')

  it 'should contain add button', inject ($compile) ->
    expect(find('.add-page-button', elements.addPage).length).toBe(1)

  it 'should contain div with input', inject ($compile) ->
    expect(find('.add-page-form', elements.addPage).length).toBe(1)
