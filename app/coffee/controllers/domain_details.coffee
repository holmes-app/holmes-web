'use strict'

angular.module('holmesApp')
  .controller 'DomainDetailsCtrl', ($scope, $routeParams, Restangular) ->

    isValidDate = (d) ->
      if (Object.prototype.toString.call(d) != "[object Date]")
        return false
      return !isNaN(d.getTime())

    $scope.model = {}

    $scope.model.domainDetails = Restangular.one('domains', $routeParams.domainName).get()

    Restangular.one('domains', $routeParams.domainName).getList('violations-per-day').then((violations) ->
      violations = violations.violations
      console.log(violations)

      violationPoints = []
      violationCount = []

      for own date, obj of violations
        dt = new Date(date)
        if (!isValidDate(dt))
          continue

        violationPoints.push(
          x: new Date(date),
          y: obj.violation_points
        )

        violationCount.push(
          x: new Date(date),
          y: obj.violation_count
        )

      violationPointsData = [
        {
          values: violationPoints,
          key: 'Violation Points',
          color: '#ff7f0e'
        }
      ]
      violationCountData = [
        {
          values: violationCount,
          key: 'Violation Count',
          color: '#2ca02c'
        }
      ]

      nv.addGraph(->
        chart = nv.models.lineChart()

        chart.yAxis
             .tickFormat(d3.format('.02f'))
        chart.xAxis
             .tickFormat((d) -> return (d3.time.format("%d-%b-%Y"))(new Date(d)))

        d3.select('#violation-count-chart svg')
          .datum(violationCountData)
          .transition().duration(500)
          .call(chart)

        nv.utils.windowResize(->
          d3.select('#violation-count-chart svg').call(chart)
        )

        return chart
      )

      nv.addGraph(->
        chart = nv.models.lineChart()

        chart.yAxis
             .tickFormat(d3.format('.02f'))
        chart.xAxis
             .tickFormat((d) -> return (d3.time.format("%d-%b-%Y"))(new Date(d)))

        d3.select('#violation-points-chart svg')
          .datum(violationPointsData)
          .transition().duration(500)
          .call(chart)

        nv.utils.windowResize(->
          d3.select('#violation-points-chart svg').call(chart)
        )

        return chart
      )
    )
