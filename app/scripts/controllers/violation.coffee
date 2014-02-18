'use strict'

class ViolationCtrl
  constructor: (@scope, @violationKey) ->

    @violation =
      label: 'SiteMap file contains unencoded links'
      domains: 4
      pageCount: 153


angular.module('holmesApp')
  .controller 'ViolationCtrl', ($scope, $routeParams) ->
    $scope.model = new ViolationCtrl($scope, $routeParams.violationKey)

