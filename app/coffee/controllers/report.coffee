'use strict'

angular.module('holmesApp')
  .controller 'ReportCtrl', ($scope, $routeParams, Restangular, $timeout) ->
    $('#reportTabs').tab()

    sinAndCos = ->
       sin = []
       cos = []

       for i in [0..100]
         sin.push(x: i, y: Math.sin(i/10))
         cos.push(x: i, y: .5 * Math.cos(i/10))

       return [
         {
           values: sin,
           key: 'Sine Wave',
           color: '#ff7f0e'
         },
         {
           values: cos,
           key: 'Cosine Wave',
           color: '#2ca02c'
         }
       ]

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

    nv.addGraph(->
      chart = nv.models.lineChart()

      chart.xAxis
        .axisLabel('Time (ms)')
        .tickFormat(d3.format(',r'))

      chart.yAxis
        .axisLabel('Voltage (v)')
        .tickFormat(d3.format('.02f'))

      d3.select('#chart svg')
        .datum(sinAndCos())
        .transition().duration(500)
        .call(chart)

      nv.utils.windowResize(->
        d3.select('#chart svg').call(chart)
      )

      return chart
    )

    updateDetails()
    updateReviews()
