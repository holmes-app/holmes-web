'use strict'

class LanguageDirective
  constructor: (@scope, @element, @gettext, @storage, @window, @UserLocaleFcty) ->
    @supportedLanguages = [
      'en_US',
      'pt_BR'
    ]

    @loadSelectedLanguage()
    @languageDropdownVisible = false
    @bindEvents()

  _fillUpdateLocale: (data) =>
    @storage.setItem("selectedLanguage", @gettext.currentLanguage)
    @reloadPage()

  _fillGetLocale: (data) =>
    if data.locale?
      @storage.setItem("selectedLanguage", data.locale)
      @selectedLanguage = data.locale
    else
      @selectedLanguage = 'en_US'

    @gettext.currentLanguage = @selectedLanguage

  loadSelectedLanguage: ->
    @selectedLanguage = @storage.getItem("selectedLanguage")

    if not @selectedLanguage
      @UserLocaleFcty.getUserLocale().then @_fillGetLocale

    @gettext.currentLanguage = @selectedLanguage

  selectLanguage: (@selectedLanguage) ->
    @languageDropdownVisible = false
    @gettext.currentLanguage = @selectedLanguage
    @UserLocaleFcty.updateUserLocale(@gettext.currentLanguage).then @_fillUpdateLocale

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

  reloadPage: ->
    window.location.reload(true)

angular.module('holmesApp')
  .directive('language', (gettextCatalog, $window, UserLocaleFcty) ->
    replace: true
    templateUrl: 'views/language.html'
    restrict: 'E'
    scope: {}
    link: (scope, element, attrs) ->
      scope.model = new LanguageDirective(scope, element, gettextCatalog, $window.localStorage, $window, UserLocaleFcty)
  )
