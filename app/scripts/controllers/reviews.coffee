'use strict'

class ReviewsCtrl
  constructor: (@scope, @domainId, @reviewId) ->
    @factsVisible = false
    @violationsVisible = true

    @reviews = [
      { id: 1, violationCount: 4, finishedAt: '2014-02-17T18:42:50Z' },
      { id: 2, violationCount: 5, finishedAt: '2014-02-17T17:42:50Z' },
      { id: 3, violationCount: 6, finishedAt: '2014-02-16T18:42:50Z' },
      { id: 4, violationCount: 5, finishedAt: '2013-12-16T18:42:50Z' },
    ]

    @review =
      url: 'http://g1.globo.com/politica/noticia/2014/01/planalto-anuncia-ida-de-mercadante-para-outro-partido.html'
      violations: [
        {
          label: 'seo violations'
          value: 40,
          percentage: 40
          violationCount: 2
          violations: [
            {
              key: 'broken.links.found'
              title: 'Broken link(s) found.'
              description: '''This page contains broken links (the urls failed to load or timed-out after 10 seconds).
               This can lead your site to lose rating with Search Engines and is misleading to users.'''
              type: 'links'
              data: ['http://www.globo.com']
            },
            {
              key: 'disallow.robots'
              title: 'Disallow: / in Robots'
              description: '''This page contains broken links (the urls failed to load or timed-out after 10 seconds).
               This can lead your site to lose rating with Search Engines and is misleading to users.'''
              type: 'value'
              data: null
            }
          ]
        },
        {
          label: 'http violations',
          value: 30,
          percentage: 30,
          violationCount: 2,
          violations: [
            {
              key: 'broken.images'
              title: 'Broken image(s) found.'
              description: '''This page contains broken links (the urls failed to load or timed-out after 10 seconds).
               This can lead your site to lose rating with Search Engines and is misleading to users.'''
              type: 'images'
              data: ['http://s2.glbimg.com/U6prwoy9yJX7dolZGoLdlbq29kI=/155xorig/smart/filters:strip_icc()/s2.glbimg.com/QGjEkg7m7BfrKogqGVBin5UcYc8=/605x245:1795x1283/155x135/s.glbimg.com/jo/g1/f/original/2014/02/14/criciuma_1.jpg', 'http://s2.glbimg.com/uG4ISmUf4frYTfrNG1fJMUhspp0=/155xorig/smart/filters:strip_icc()/s2.glbimg.com/JUYXe8YUpx-WfXgTVH_qAhgSexw=/0x73:448x464/155x135/s.glbimg.com/en/ho/f/original/2014/02/14/joelhos.jpg']
            },
            {
              key: 'broken.links'
              title: 'Broken link(s) found.'
              description: '''This page contains broken links (the urls failed to load or timed-out after 10 seconds).
               This can lead your site to lose rating with Search Engines and is misleading to users.'''
              type: 'links'
              data: ['http://www.bogus.com']
            }
          ]
        }
      ],
      facts: [
        {
          label: 'seo'
          facts: [
            { key: 'total.invalid.links', title: 'total invalid links', value: 'this page has 0 invalid links', type: 'value', data: 0 },
            { key: 'invalid.links', title: 'invalid links', value: [], type: 'list', data: [] },
          ]
        },
        {
          label: 'http'
          facts: [
            { key: 'total.invalid.links', title: 'total invalid links', value: 'this page has 0 invalid links', type: 'value', data: 0 },
            { key: 'invalid.links', title: 'invalid links', value: [], type: 'list', data: [] },
          ]
        },
        {
          label: 'performance'
          facts: [
            { key: 'total.invalid.links', title: 'total invalid links', value: 'this page has 0 invalid links', type: 'value', data: 0 },
            { key: 'invalid.links', title: 'invalid links', value: [], type: 'list', data: [] },
          ]
        },
        {
          label: 'semantics'
          facts: [
            { key: 'total.invalid.links', title: 'total invalid links', value: 'this page has 0 invalid links', type: 'value', data: 0 },
            { key: 'invalid.links', title: 'invalid links', value: [], type: 'list', data: [] },
          ]
        }
      ]
      points: 2392
      violationCount: 12

  showFacts: ->
    @factsVisible = true
    @violationsVisible = false

  showViolations: ->
    @factsVisible = false
    @violationsVisible = true

angular.module('holmesApp')
  .controller 'ReviewsCtrl', ($scope, $routeParams) ->
    domainId = $routeParams.domainId
    reviewId = $routeParams.reviewId

    $scope.model = new ReviewsCtrl($scope, domainId, reviewId)
