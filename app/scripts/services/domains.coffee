'use strict'

class DomainsFactory
  constructor: (@restangular) ->

  getDomains: ->
    @restangular.all('domains').getList()

  getDomainsDetails: ->
    @restangular.all('domains-details').getList()


angular.module('holmesApp')
  .factory 'DomainsFcty', (Restangular) ->
    return new DomainsFactory(Restangular)
    #Restangular.withConfig (RestangularConfigurer) ->
      #RestangularConfigurer.setBaseUrl(RestangularConfigurer.baseUrl + '/domains')
