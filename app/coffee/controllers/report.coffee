'use strict'

angular.module('holmesApp')
  .controller 'ReportCtrl', ($scope, $routeParams, Restangular, $timeout) ->

    isValidDate = (d) ->
      if (Object.prototype.toString.call(d) != "[object Date]")
        return false
      return !isNaN(d.getTime())

    $('#reportTabs').tab()

    $scope.model = {
      details: {},
      reviews: {}
    }

    updateDetails = ->
      Restangular.one('page', $routeParams.pageId).one('review', $routeParams.reviewId).get().then((details) ->
        $scope.model.details = details
      )

    updateReviews = ->
      Restangular.one('page', $routeParams.pageId).one('reviews').get().then((reviews) ->
        $scope.model.reviews = reviews
      )

    updateChartData = ->
      Restangular.one('page', $routeParams.pageId).getList('violations-per-day').then((violations) ->
        violations = violations.violations
        buildCharts(violations)
      )

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
    updateDetails()
    updateReviews()
    updateChartData()
