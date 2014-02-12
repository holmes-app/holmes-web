'use strict'

angular.module('holmesApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.model = {}

    #$scope.model.data = [
      #{label: "download sales", value: 100, id: 1},
      #{label: "in-store sales", value: 80, id: 2},
      #{label: "in-store sales", value: 70, id: 3},
      #{label: "in-store sales", value: 60, id: 4},
      #{label: "in-store sales", value: 50, id: 5},
      #{label: "in-store sales", value: 40, id: 6},
      #{label: "in-store sales", value: 30, id: 7},
      #{label: "in-store sales", value: 20, id: 8},
      #{label: "mail-order sales", value: 10, id: 9}
    #]

    #$scope.model.onSelect = (value, data) ->
      #console.log(value, data)
