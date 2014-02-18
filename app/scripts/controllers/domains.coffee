'use strict'

class DomainsCtrl
  constructor: (@scope, @DomainsFcty) ->
    @domainsVisible = false
    @groupsVisible = true
    @mostFrequentVisible = false

    @getDomainData()
    @getMostFrequentViolations()
    @getLeastFrequentViolations()
    @getGroups()

  toggleDomainVisibility: ->
    @domainsVisible = !@domainsVisible

  showGroups: ->
    @groupsVisible = true
    @mostFrequentVisible = false

  showMostFrequent: ->
    console.log(@mostFrequentVisible)
    @groupsVisible = false
    @mostFrequentVisible = true

  getDomainData: ->
    @domains = @DomainsFcty.all('').getList().$object

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
        name: 'Sitemap contains too many links mofo!'
      }
    ]

  getLeastFrequentViolations: ->
    @leastFrequentViolations = []

    for i in [1..30]
      @leastFrequentViolations.push(
        key: "meta.missing.#{ i }"
        position: 10 + i
        name: "Meta tags not present #{ i }"
      )

  getGroups: ->
    @groupData = [
      {
        name: 'SEO',
        violations: [
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
            key: 'meta.missing.5'
            position: 4
            name: 'Meta tags not present'
          },
          {
            key: 'moved.temporarily.5'
            position: 5
            name: 'Moved Temporarily'
          },
          {
            key: 'og.missing.5'
            position: 6
            name: 'OpenGraph tags missing'
          }
        ]
      },
      {
        name: 'PERFORMANCE',
        violations: [
          {
            key: 'meta.missing.2'
            position: 1
            name: 'Meta tags not present'
          },
          {
            key: 'moved.temporarily.2'
            position: 2
            name: 'Moved Temporarily'
          },
          {
            key: 'og.missing.2'
            position: 3
            name: 'OpenGraph tags missing'
          }
        ]
      },
      {
        name: 'SEMANTICS',
        violations: [
          {
            key: 'meta.missing.3'
            position: 1
            name: 'Meta tags not present'
          },
          {
            key: 'moved.temporarily.3'
            position: 2
            name: 'Moved Temporarily'
          },
          {
            key: 'og.missing.3'
            position: 3
            name: 'OpenGraph tags missing'
          }
        ]
      },
      {
        name: 'HTTP',
        violations: [
          {
            key: 'meta.missing.4'
            position: 1
            name: 'Meta tags not present'
          },
          {
            key: 'moved.temporarily.4'
            position: 2
            name: 'Moved Temporarily'
          },
          {
            key: 'og.missing.4'
            position: 3
            name: 'OpenGraph tags missing'
          }
        ]
      }
      #{
        #name: 'SEO 2',
        #violations: [
          #{
            #key: 'meta.missing'
            #position: 1
            #name: 'Meta tags not present'
          #},
          #{
            #key: 'moved.temporarily'
            #position: 2
            #name: 'Moved Temporarily'
          #},
          #{
            #key: 'og.missing'
            #position: 3
            #name: 'OpenGraph tags missing'
          #},
          #{
            #key: 'meta.missing.5'
            #position: 4
            #name: 'Meta tags not present'
          #},
          #{
            #key: 'moved.temporarily.5'
            #position: 5
            #name: 'Moved Temporarily'
          #},
          #{
            #key: 'og.missing.5'
            #position: 6
            #name: 'OpenGraph tags missing'
          #}
        #]
      #},
      #{
        #name: 'PERFORMANCE 2',
        #violations: [
          #{
            #key: 'meta.missing.2'
            #position: 1
            #name: 'Meta tags not present'
          #},
          #{
            #key: 'moved.temporarily.2'
            #position: 2
            #name: 'Moved Temporarily'
          #},
          #{
            #key: 'og.missing.2'
            #position: 3
            #name: 'OpenGraph tags missing'
          #}
        #]
      #},
      #{
        #name: 'SEMANTICS 2',
        #violations: [
          #{
            #key: 'meta.missing.3'
            #position: 1
            #name: 'Meta tags not present'
          #},
          #{
            #key: 'moved.temporarily.3'
            #position: 2
            #name: 'Moved Temporarily'
          #},
          #{
            #key: 'og.missing.3'
            #position: 3
            #name: 'OpenGraph tags missing'
          #}
        #]
      #},
      #{
        #name: 'HTTP 2',
        #violations: [
          #{
            #key: 'meta.missing.4'
            #position: 1
            #name: 'Meta tags not present'
          #},
          #{
            #key: 'moved.temporarily.4'
            #position: 2
            #name: 'Moved Temporarily'
          #},
          #{
            #key: 'og.missing.4'
            #position: 3
            #name: 'OpenGraph tags missing'
          #}
        #]
      #}
    ]


angular.module('holmesApp')
  .controller 'DomainsCtrl', ($scope, DomainsFcty) ->

    $scope.model = new DomainsCtrl($scope, DomainsFcty)
