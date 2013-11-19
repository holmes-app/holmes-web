(function() {
  var WebSocketService;

  WebSocketService = (function() {
    function WebSocketService(wsUrl, timeout) {
      this.wsUrl = wsUrl;
      this.timeout = timeout;
      this.ws = new WebSocket(this.wsUrl);
      this.handlers = [];
      this.ws.onmessage = this._onmessage.bind(this);
    }

    WebSocketService.prototype.on = function(callback) {
      return this.handlers.push(callback);
    };

    WebSocketService.prototype._onmessage = function(message) {
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