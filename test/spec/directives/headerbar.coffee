'use strict'

describe 'Directive: headerbar', () ->

  # load the directive's module
  beforeEach module 'holmesApp'

  beforeEach module 'views/headerbar.html'
  beforeEach module 'views/headersearch.html'
  beforeEach module 'views/headeraddpage.html'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<div><headerbar></headerbar></div>'
    element = $compile(element) scope
    scope.$digest()  # ARGHHHHHHHHHHH IF I MISS THIS THE TEMPLATE IS NOT RENDERED!

    # TODO: Improve this check to use elements
    expect(element.html()).toBe '''<header>
    <p>HEADERBAR</p>
    <div class="header-search">
    HEADER SEARCH
  </div>
    <div class="header-add-page">
    HEADER ADD PAGE
  </div>
</header>'''
