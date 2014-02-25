'use strict'

class ReviewPipelineCtrl
  constructor: (@scope, @NextJobsFcty) ->
    @reviews = []
    @reviewCount = 0

    @getReviews()


  getReviews: (currentPage, pageSize) ->
    @NextJobsFcty.one('').get({current_page: currentPage, page_size: pageSize}).then( (data) =>
      @reviews = data.pages
      @reviewCount = data.reviewCount
    )

  updateReviews: (currentPage, pageSize) =>
    @getReviews(currentPage, pageSize)


angular.module('holmesApp')
  .controller 'ReviewPipelineCtrl', ($scope, NextJobsFcty) ->
    $scope.model = new ReviewPipelineCtrl($scope, NextJobsFcty)
