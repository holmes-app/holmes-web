'use strict'

class LastReviewsCtrl
  constructor: (@scope) ->
    @lastReviews = []

    for i in [1..20]
      @lastReviews.push(
        id: "12345-12345-12345-12345-#{ i }",
        pageId: '12345-12345-12345-12345-12345',
        domainName: 'globoesporte.globo.com',
        url: 'http://g1.globo.com/rio-de-janeiro/noticia/2014/01/sobrevivi-disse-isis-valver-
de-em-hospital-apos-acidente-conta-assessor.html',
        date: '2014-02-16T18:42:50Z'
      )

angular.module('holmesApp')
  .controller 'LastReviewsCtrl', ($scope) ->
    $scope.model = new LastReviewsCtrl($scope)
