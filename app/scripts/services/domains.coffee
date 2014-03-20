'use strict'

class DomainsFactory
  constructor: (@restangular) ->

  getDomains: ->
    @restangular.all('domains-details').getList()

  getDomainReviews: (domainName, params) ->
    @restangular.one('domains', domainName).one('reviews').get(params)

  getDomainGroupedViolations: (domainName) ->
    @restangular.one('domains', domainName).one('violations').get()

  getDomainMostCommonViolations: (domainName, key_category_id) ->
    @restangular.one('domains', domainName).one('violations', key_category_id).get()

  getDomainData: (domainName) ->
    @restangular.one('domains', domainName).get()

  postChangeDomainStatus: (domainName) ->
    @restangular.one('domains', domainName).post('change-status')


angular.module('holmesApp')
  .factory 'DomainsFcty', (Restangular) ->
    return new DomainsFactory(Restangular)
