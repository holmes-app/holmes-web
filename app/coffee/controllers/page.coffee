'use strict'

angular.module('holmesApp')
  .controller 'PageCtrl', ($scope) ->
    $scope.domains = []

    for i in [1..20]
      $scope.domains.push(
        name: "g1.globo.com"
        url: "http://g1.globo.com"
        id: 1
        violations: 25200
        pages: 2304
      )
