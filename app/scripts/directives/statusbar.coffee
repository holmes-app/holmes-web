'use strict'

angular.module('holmesApp')
  .directive('statusbar', () ->
    replace: true
    scope:
      index: "="
    template: """
      <div class="tabs status-bar">
        <div class="tab-header ib grey">
          <a href="#/status/workers">workers</a>
        </div>
        <div class="tab-header ib">
          <a href="#/status/last-reviews">last reviews</a>
        </div>
        <div class="tab-header ib">
          <a href="#/status/pipeline">review pipeline</a>
        </div>
        <div class="tab-header ib">
          <a href="#/status/requests">last requests</a>
        </div>
        <div class="tab-header ib">
          <a href="#/status/concurrent">concurrent requests</a>
        </div>
      </div>
    """
    restrict: 'E'
    link: (scope, element, attrs) ->
      index = parseInt(scope.index, 10) - 1
      $(element).find('.tab-header').eq(index).addClass('selected')
  )
