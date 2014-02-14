'use strict'

class DomainCtrl
  constructor: (@scope) ->
    @defaultDetails = [
      { title: 'SEO Violations', percentage: 31.79, pageCount: 198542 },
      { title: 'Semantics Violations', percentage: 27.76, pageCount: 173356 },
      { title: 'Performance Violations', percentage: 22.79, pageCount: 142345},
      { title: 'HTTP Violations', percentage: 17.65, pageCount: 110230},
    ]

    @domainViolations = [
      {label: "SEO Violations", value: 198542, id: 1, details:[
        { title: 'SEO Violations', percentage: 31.79, pageCount: 198542 },
        { title: 'HTTP Violations', percentage: 17.65, pageCount: 110230},
      ]},
      {label: "Semantics Violations", value: 173356, id: 2, details:[
        { title: 'Performance Violations', percentage: 22.79, pageCount: 142345},
        { title: 'HTTP Violations', percentage: 17.65, pageCount: 110230},
      ]},
      {label: "Performance Violations", value: 142345, id: 3, details:[
        { title: 'SEO Violations', percentage: 31.79, pageCount: 198542 },
        { title: 'Semantics Violations', percentage: 27.76, pageCount: 173356 },
      ]},
      {label: "HTTP Violations", value: 110230, id: 4, details:[
        { title: 'HTTP Violations', percentage: 17.65, pageCount: 110230},
        { title: 'SEO Violations', percentage: 31.79, pageCount: 198542 },
      ]}
    ]

  onSelect: (value, data) =>
    if data?
      @details = data.details
    else
      @details = @defaultDetails unless data?

angular.module('holmesApp')
  .controller 'DomainCtrl', ($scope) ->
    $scope.model = new DomainCtrl($scope)
