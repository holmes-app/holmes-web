"use strict";

module.exports = function (grunt, options) {

    return {
        serve: [
          'clean:server',
          'ngconstant',
          'bower-install',
          'concurrent:server',
          'autoprefixer',
          'connect:livereload',
          'watch'
        ],
        server_dist: [
          'build',
          'connect:dist:keepalive'
        ],
        test: [
          'clean:server',
          'concurrent:test',
          'autoprefixer',
          'connect:test',
          'karma'
        ],
        build: [
          'clean:dist',
          'ngconstant',
          'file-creator',
          'bower-install',
          'useminPrepare',
          'concurrent:dist',
          'autoprefixer',
          'concat',
          'ngmin',
          'copy:dist',
          'cdnify',
          'cssmin',
          'uglify',
          'sed',
          'rev',
          'usemin',
          'htmlmin'
        ],
        default: [
          'newer:jshint',
          'test',
          'build'
        ],
        extract_translations: [
          'coffee:dist',
          'nggettext_extract'
        ],
        compile_translations: [
          'nggettext_compile'
        ]
    };
};
