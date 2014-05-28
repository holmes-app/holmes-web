'use strict'

class LanguageDirective
  constructor: (@scope, @element, @gettext, @storage) ->
    @supportedLanguages = [
      'en_US',
      'pt_BR'
    ]

    @loadSelectedLanguage()
    @dropdownVisible = false

  loadSelectedLanguage: ->
    @selectedLanguage = @storage.getItem("selectedLanguage")
    if not @selectedLanguage?
      @selectedLanguage = 'en_US'

    @gettext.currentLanguage = @selectedLanguage

  selectLanguage: (@selectedLanguage) ->
    @storage.setItem("selectedLanguage", @selectedLanguage)
    @dropDownVisible = false
    @gettext.currentLanguage = @selectedLanguage


angular.module('holmesApp')
  .directive('language', (gettextCatalog, $window) ->
    replace: true
    templateUrl: 'views/language.html'
    restrict: 'E'
    link: (scope, element, attrs) ->
      scope.model = new LanguageDirective(scope, element, gettextCatalog, $window.sessionStorage)
  )
