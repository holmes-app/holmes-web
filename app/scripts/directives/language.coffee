'use strict'

class LanguageDirective
  constructor: (@scope, @element, @gettext, @storage, @window) ->
    @supportedLanguages = [
      'en_US',
      'pt_BR'
    ]

    @loadSelectedLanguage()
    @languageDropdownVisible = false
    @bindEvents()

  loadSelectedLanguage: ->
    @selectedLanguage = @storage.getItem("selectedLanguage")
    if not @selectedLanguage?
      @selectedLanguage = 'en_US'

    @gettext.currentLanguage = @selectedLanguage

  selectLanguage: (@selectedLanguage) ->
    @storage.setItem("selectedLanguage", @selectedLanguage)
    @languageDropdownVisible = false
    @gettext.currentLanguage = @selectedLanguage

  toggleDropDown: (ev) =>
    @languageDropdownVisible = not @languageDropdownVisible
    ev.preventDefault()
    ev.stopPropagation()

  bindEvents: ->
    @window.addEventListener('click', (ev) =>
      @scope.$apply(=>
        @languageDropdownVisible = false
      )
    )

angular.module('holmesApp')
  .directive('language', (gettextCatalog, $window) ->
    replace: true
    templateUrl: 'views/language.html'
    restrict: 'E'
    scope: {}
    link: (scope, element, attrs) ->
      scope.model = new LanguageDirective(scope, element, gettextCatalog, $window.sessionStorage, $window)
  )
