'use strict'

class ReviewsCtrl
  constructor: (@scope, @domainId, @reviewId) ->
    console.log(@domainId, @reviewId)
    
    @reviews = [
      { id: 1, violationCount: 4, finishedAt: '2012-10-10 10:10:10' },
      { id: 2, violationCount: 5, finishedAt: '2012-10-10 10:10:10' },
      { id: 3, violationCount: 6, finishedAt: '2012-10-10 10:10:10' },
      { id: 4, violationCount: 5, finishedAt: '2012-10-10 10:10:10' },
    ]

    @review =
      url: 'http://g1.globo.com/politica/noticia/2014/01/planalto-anuncia-ida-de-mercadante-para-outro-partido.html'
      violations: {
        'seo': {
          percentage: 40,
          violationCount: 2,
          violations: [
            {
              title: 'Broken link(s) found.'
              description: '''This page contains broken links (the urls failed to load or timed-out after 10 seconds).
               This can lead your site to lose rating with Search Engines and is misleading to users.'''
              type: 'links'
              data: ['http://www.globo.com']
            },
            {
              title: 'Disallow: / in Robots'
              description: '''This page contains broken links (the urls failed to load or timed-out after 10 seconds).
               This can lead your site to lose rating with Search Engines and is misleading to users.'''
              type: 'value'
              data: null
            }
          ]
        },
        'http': {
          percentage: 30,
          violationCount: 2,
          violations: [
            {
              title: 'Broken image(s) found.'
              description: '''This page contains broken links (the urls failed to load or timed-out after 10 seconds).
               This can lead your site to lose rating with Search Engines and is misleading to users.'''
              type: 'images'
              data: ['http://s2.glbimg.com/U6prwoy9yJX7dolZGoLdlbq29kI=/155xorig/smart/filters:strip_icc()/s2.glbimg.com/QGjEkg7m7BfrKogqGVBin5UcYc8=/605x245:1795x1283/155x135/s.glbimg.com/jo/g1/f/original/2014/02/14/criciuma_1.jpg', 'http://s2.glbimg.com/uG4ISmUf4frYTfrNG1fJMUhspp0=/155xorig/smart/filters:strip_icc()/s2.glbimg.com/JUYXe8YUpx-WfXgTVH_qAhgSexw=/0x73:448x464/155x135/s.glbimg.com/en/ho/f/original/2014/02/14/joelhos.jpg']
            },
            {
              title: 'Broken link(s) found.'
              description: '''This page contains broken links (the urls failed to load or timed-out after 10 seconds).
               This can lead your site to lose rating with Search Engines and is misleading to users.'''
              type: 'links'
              data: ['http://www.bogus.com']
            }
          ]
        }
      },
      facts: [
        'seo': [
          { title: 'total invalid links', value: 'this page has 0 invalid links', type: 'value', data: 0 },
          { title: 'invalid links', value: [], type: 'list', data: [] },
        ],
        'http': [
          { title: 'total invalid links', value: 'this page has 0 invalid links', type: 'value', data: 0 },
          { title: 'invalid links', value: [], type: 'list', data: [] },
        ],
        'performance': [
          { title: 'total invalid links', value: 'this page has 0 invalid links', type: 'value', data: 0 },
          { title: 'invalid links', value: [], type: 'list', data: [] },
        ],
        'semantics': [
          { title: 'total invalid links', value: 'this page has 0 invalid links', type: 'value', data: 0 },
          { title: 'invalid links', value: [], type: 'list', data: [] },
        ]
      ]
      points: 2392
      violationCount: 12


angular.module('holmesApp')
  .controller 'ReviewsCtrl', ($scope, $routeParams) ->
    domainId = $routeParams.domainId
    reviewId = $routeParams.reviewId

    $scope.model = new ReviewsCtrl($scope, domainId, reviewId)
