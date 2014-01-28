'use strict'

describe 'Directive: headerbar', () ->

  # load the directive's module
  beforeEach module 'holmesApp'

  beforeEach module 'views/headerbar.html'
  beforeEach module 'views/headersearch.html'
  beforeEach module 'views/headeraddpage.html'

  scope = {}
  elements = {}

  find = (selector, root) ->
    rootElement = elements.main
    rootElement = root if root?
    return angular.element(rootElement[0].querySelectorAll(selector))

  beforeEach inject ($controller, $rootScope, $compile) ->
    scope = $rootScope.$new()

    elements.main = angular.element '<div><headerbar></headerbar></div>'
    elements.main = $compile(elements.main) scope
    scope.$digest()  # ARGHHHHHHHHHHH IF I MISS THIS THE TEMPLATE IS NOT RENDERED!

    elements.header = find('header')

  it 'should contain header', inject ($compile) ->
    expect(elements.header.length).toBe(1)
 
  it 'should contain logo', inject ($compile) ->
    logo = find('a.logo', elements.header)
    expect(logo.text()).toEqual('holmes')
    expect(logo.attr('href')).toEqual('#')

  it 'should contain navigation', inject ($compile) ->
    navbar = find('navbar', elements.header)
    expect(navbar.length).toBe(1)

    ul = find('ul', navbar)
    expect(ul.length).toBe(1)

    li = find('li', ul)
    expect(li.length).toBe(3)

    expect(li.eq(0).find('a').attr('href')).toEqual('#/domains')
    expect(li.eq(1).find('a').attr('href')).toEqual('#/violations')
    expect(li.eq(2).find('a').attr('href')).toEqual('#/status')
