"use strict";

 angular.module("HolmesConfig", [])

.constant("baseUrl", "http://local.holmes.com:2368/")

.constant("wsUrl", "ws://local.holmes.com:2368/events/")

.constant("timeToLive", 3000)

;