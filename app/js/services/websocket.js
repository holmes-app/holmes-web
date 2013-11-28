(function() {
  var WebSocketService;

  WebSocketService = (function() {
    function WebSocketService(wsUrl, timeout) {
      this.wsUrl = wsUrl;
      this.timeout = timeout;
      if (ReconnectingWebSocket) {
        this.ws = new ReconnectingWebSocket(this.wsUrl);
      }
      if (!ReconnectingWebSocket) {
        this.ws = new WebSocket(this.wsUrl);
      }
      this.handlers = [];
      this.ws.onmessage = this._onmessage.bind(this);
      this.throttledStatus = $.throttle(2000, this.sendMessage);
      this.throttledReview = $.throttle(500, this.sendMessage);
      this.throttledSendMessage = $.throttle(1000, this.sendMessage);
    }

    WebSocketService.prototype.on = function(callback) {
      return this.handlers.push(callback);
    };

    WebSocketService.prototype.sendMessage = function(message) {
      var handler, obj, _i, _len, _ref, _results;
      obj = JSON.parse(message.data);
      _ref = this.handlers;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        handler = _ref[_i];
        _results.push(handler(obj));
      }
      return _results;
    };

    WebSocketService.prototype._onmessage = function(message) {
      if (message.type === 'worker-status') {
        return this.throttledStatus(message);
      } else if (message.type === 'new-review') {
        return this.throttledReview(message);
      } else {
        return this.throttledSendMessage(message);
      }
    };

    return WebSocketService;

  })();

  angular.module('WebSocketService', ["HolmesConfig"], function($provide) {
    return $provide.factory('WebSocket', function(wsUrl, $timeout) {
      return new WebSocketService(wsUrl, $timeout);
    });
  });

}).call(this);

/*
//@ sourceMappingURL=websocket.js.map
*/