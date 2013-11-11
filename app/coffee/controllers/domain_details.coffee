'use strict'

angular.module('holmesApp')
  .controller 'DomainDetailsCtrl', ($scope, $routeParams, Restangular, $timeout) ->

    isValidDate = (d) ->
      if (Object.prototype.toString.call(d) != "[object Date]")
        return false
      return !isNaN(d.getTime())

    $scope.model = {
      domainDetails: {
        name: $routeParams.domainName,
        url: '',
        pageCount: 0,
        violationCount: 0,
        violationPoints: 0
      },
      pageCount: 0,
      pages: []
    }

    updateDomainDetails = ->
      Restangular.one('domains', $routeParams.domainName).get().then((domainDetails) ->
        $scope.model.domainDetails = domainDetails
      )

      Restangular.one('domains', $routeParams.domainName).getList('reviews').then((domainData) ->
        $scope.model.pageCount = domainData.pageCount
        $scope.model.pages = domainData.pages
        $scope.model.pagesWithoutReview = domainData.pagesWithoutReview
        $scope.model.pagesWithoutReviewCount = domainData.pagesWithoutReviewCount
      )

      $timeout(updateDomainDetails, 2000)

    updateChartData = ->
      Restangular.one('domains', $routeParams.domainName).getList('violations-per-day').then((violations) ->
        violations = violations.violations
        buildCharts(violations)
      )

      $timeout(updateChartData, 10000)

    buildCharts = (violations) ->
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

      console.log(violationPoints)
      console.log(violationCount)

      nv.addGraph(->
        chart = nv.models.lineChart()

        chart.yAxis
             .tickFormat(d3.format('.02f'))
        chart.xAxis
             .tickFormat((d) -> return (d3.time.format("%d-%b"))(new Date(d)))

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
             .tickFormat((d) -> return (d3.time.format("%d-%b"))(new Date(d)))

        d3.select('#violation-points-chart svg')
          .datum(violationPointsData)
          .transition().duration(500)
          .call(chart)

        nv.utils.windowResize(->
          d3.select('#violation-points-chart svg').call(chart)
        )

        return chart
      )

    buildCharts([])
    updateDomainDetails()
    updateChartData()
