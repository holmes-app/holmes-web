'use strict'

angular.module('holmesApp')
  .controller 'DomainDetailsCtrl', ($scope, $routeParams, Restangular, WebSocket) ->

    isValidDate = (d) ->
      if (Object.prototype.toString.call(d) != "[object Date]")
        return false
      return !isNaN(d.getTime())

    $scope.getClass = (pageIndex) ->
      return 'active' if pageIndex == $scope.model.currentPage
      return '' unless pageIndex == $scope.model.currentPage

    $scope.model = {
      domainDetails: {
        name: $routeParams.domainName,
        url: '',
        pageCount: 0,
        numberofPages: 0
        violationCount: 0,
        violationPoints: 0
      },
      currentPage: 1,
      numberOfPages: 0,
      pages: []
    }

    updateDomainDetails = ->
      Restangular.one('domains', $routeParams.domainName).get().then((domainDetails) ->
        $scope.model.domainDetails = domainDetails
      )

    updateReviews = ->
      Restangular.one('domains', $routeParams.domainName).getList('reviews', {current_page: $scope.model.currentPage}).then((domainData) ->
        $scope.model.pageCount = domainData.pageCount
        $scope.model.numberOfPages = Math.ceil(domainData.pageCount / 10)
        $scope.model.pages = domainData.pages
        $scope.model.pagesWithoutReview = domainData.pagesWithoutReview
        $scope.model.pagesWithoutReviewCount = domainData.pagesWithoutReviewCount

        $scope.model.nextPages = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] if $scope.model.currentPage < 6

        $scope.model.prevPage = Math.max(1, $scope.model.currentPage - 5)
        $scope.model.nextPage = Math.max(6, Math.min($scope.model.numberOfPages, $scope.model.currentPage + 5))

        if $scope.model.currentPage >= 6
          $scope.model.nextPages = []

          for i in [$scope.model.currentPage - 4 .. $scope.model.currentPage + 4] by 1
            $scope.model.nextPages.push(i)
      )


    updateChartData = ->
      Restangular.one('domains', $routeParams.domainName).getList('violations-per-day').then((violations) ->
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
    updateDomainDetails()
    updateReviews()
    updateChartData()

    WebSocket.on((message) ->
      if message.type == 'new-page' or message.type == 'new-review'
        updateDomainDetails()
        updateReviews()
        updateChartData()
    )

    $scope.goToReviewPage = (pageIndex) ->
      $scope.model.currentPage = pageIndex
      updateReviews()
