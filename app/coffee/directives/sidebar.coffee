'use strict'

angular.module('holmesApp')
  .directive('sidebar', () ->
    templateUrl: 'views/sidebar.html',
    restrict: 'E',
    scope: {},
    controller: ($scope, Restangular, $location, $timeout, growl, WebSocket) ->
      $scope.model =
        term: ''

      $scope.model.workers_total = 0

      $scope.search = ->
        term = $scope.model.term
        Restangular.all('search').getList({term: term}).then((page) ->
          if page == null or page == undefined
            growl.addErrorMessage("Page with URL " + term + " was not found or does not have any reviews associated with it!")
          else
            $location.path('/pages/' + page.uuid + '/reviews/' + page.reviewId)

        )

      getWorkersInfo = ->
        Restangular.one('workers').one('info').get().then((data) ->
          $scope.model.workers_total = data.total

          updateChart(data.active, data.inactive)
        )

      drawChart = ->
        nv.addGraph(->
          chart = nv.models.pieChart()
                           .showLabels(false)
                           .tooltips(false)
                           .donut(true)

          $scope.model.chart = chart
        )

      updateChart = (active, inactive) ->
        d3.select('#workers-chart svg')
            .datum(chartData(active, inactive))
            .transition()
            .duration(1200)
            .call($scope.model.chart)

      chartData = (active, inactive) ->
        return [{ x: "Active",   y: active },
                { x: "Inactive", y: inactive}]

      drawChart()
      getWorkersInfo()

      WebSocket.on((message) ->
        getWorkersInfo() if message.type == 'worker-status'
      )

      return true

  )
