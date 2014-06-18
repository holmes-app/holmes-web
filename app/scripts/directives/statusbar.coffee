'use strict'

angular.module('holmesApp')
  .directive('statusbar', () ->
    replace: true
    scope:
      index: "="
    template: """
      <div class="tabs status-bar">
        <div class="tab-header ib grey">
          <a data-named-route="workers">workers</a>
        </div>
        <div class="tab-header ib">
          <a data-named-route="last-reviews">last reviews</a>
        </div>
        <div class="tab-header ib">
          <a data-named-route="pipeline">review pipeline</a>
        </div>
        <div class="tab-header ib">
          <a data-named-route="last-requests">last requests</a>
        </div>
        <div class="tab-header ib">
          <a data-named-route="concurrent">concurrent requests</a>
        </div>
      </div>
    """
    restrict: 'E'
    link: (scope, element, attrs) ->
      index = parseInt(scope.index, 10) - 1
      $(element).find('.tab-header').eq(index).addClass('selected')
  )
