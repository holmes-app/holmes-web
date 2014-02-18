'use strict'

class ViolationCtrl
  constructor: (@scope, @violationKey) ->

    @violation =
      label: 'SiteMap file contains unencoded links'
      domains: [
        {
          id: 1
          percentage: 1.0         # this should be calculated by percentage of the max value (ask if you don't understand)
          label: 'g1.globo.com'
        },
        {
          id: 2
          percentage: 0.8
          label: 'globoesporte.globo.com'
        },
        {
          id: 3
          percentage: 0.5
          label: 'gshow.globo.com'
        },
        {
          id: 4
          percentage: 0.3
          label: 'techtudo.globo.com'
        }
      ],
      pageCount: 153

  updateReviews: ->


angular.module('holmesApp')
  .controller 'ViolationCtrl', ($scope, $routeParams) ->
    $scope.model = new ViolationCtrl($scope, $routeParams.violationKey)

