'use strict';

module.exports = function (grunt) {

  require('load-grunt-tasks')(grunt);
  require('time-grunt')(grunt);

  var path = require('path');
  var configs = require('load-grunt-config')(grunt, {
      configPath: path.join(process.cwd(), 'grunt-tasks'),
      init: true,
  });

  grunt.initConfig(configs);
};
