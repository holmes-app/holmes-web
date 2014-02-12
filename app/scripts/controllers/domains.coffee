'use strict'

class DomainsCtrl
  constructor: (@scope) ->
    @domainsVisible = false
    @getDomainData()
    @getMostFrequentViolations()

  toggleDomainVisibility: ->
    @domainsVisible = !@domainsVisible

  getDomainData: ->
    @domains = [
      {
        id: 1
        name: 'g1.globo.com'
        pageCount: 14004009
        violationCount: 110618783
        errorPercentage: 3
        averageResponseTime: 40
      },
      {
        id: 2
        name: 'ego.globo.com'
        pageCount: 404009
        violationCount: 1618783
        errorPercentage: 3
        averageResponseTime: 40
      },
      {
        id: 3
        name: 'globoesporte.globo.com'
        pageCount: 404009
        violationCount: 1618783
        errorPercentage: 3
        averageResponseTime: 40
      },
      {
        id: 4
        name: 'gshow.globo.com'
        pageCount: 404009
        violationCount: 1618783
        errorPercentage: 3
        averageResponseTime: 40
      },
      {
        id: 5
        name: 'g1.globo.com'
        pageCount: 404009
        violationCount: 1618783
        errorPercentage: 3
        averageResponseTime: 40
      },
      {
        id: 6
        name: 'ego.globo.com'
        pageCount: 404009
        violationCount: 1618783
        errorPercentage: 3
        averageResponseTime: 40
      },
      {
        id: 7
        name: 'globoesporte.globo.com'
        pageCount: 404009
        violationCount: 1618783
        errorPercentage: 3
        averageResponseTime: 40
      },
      {
        id: 8
        name: 'gshow.globo.com'
        pageCount: 404009
        violationCount: 1618783
        errorPercentage: 3
        averageResponseTime: 40
      },
      {
        id: 9
        name: 'globoesporte.globo.com'
        pageCount: 404009
        violationCount: 1618783
        errorPercentage: 3
        averageResponseTime: 40
      }
    ]

  getMostFrequentViolations: ->
    @mostFrequentViolations = [
      {
        key: 'meta.missing'
        position: 1
        name: 'Meta tags not present'
      },
      {
        key: 'moved.temporarily'
        position: 2
        name: 'Moved Temporarily'
      },
      {
        key: 'og.missing'
        position: 3
        name: 'OpenGraph tags missing'
      },
      {
        key: 'body.missing'
        position: 4
        name: 'Page body not found'
      },
      {
        key: 'title.missing'
        position: 5
        name: 'Page title not found'
      },
      {
        key: 'metatags.missing'
        position: 6
        name: 'Required Meta Tags missing'
      },
      {
        key: 'robots.missing'
        position: 7
        name: 'Robots file missing'
      },
      {
        key: 'robots.empty'
        position: 8
        name: 'Robots file is empty'
      },
      {
        key: 'image.size'
        position: 9
        name: 'Single image size in kb is too big'
      },
      {
        key: 'sitemap.size'
        position: 10
        name: 'Sitemap contains too many links'
      }
    ]


angular.module('holmesApp')
  .controller 'DomainsCtrl', ($scope) ->

    $scope.model = new DomainsCtrl($scope)
