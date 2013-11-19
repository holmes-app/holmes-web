'use strict'

LIVERELOAD_PORT = 35729
lrSnippet = require('connect-livereload') port: LIVERELOAD_PORT

mountFolder = (connect, dir) ->
  return connect.static(require('path').resolve(dir))


module.exports = (grunt) ->
  require('load-grunt-tasks') grunt
  require('time-grunt') grunt
  urlRewrite = require('./grunt-connect-rewrite')

  grunt.initConfig(
    watch: {
      coffee: {
        files: ['app/coffee/{,*/}*.coffee'],
        tasks: ['coffee:dist']
      },
      coffeeTest: {
        files: ['test/spec/{,*/}*.coffee'],
        tasks: ['coffee:test']
      },
      compass: {
        files: ['app/scss/{,*/}*.{scss,sass}'],
        tasks: ['compass']
      },
      livereload: {
        options: {
          livereload: LIVERELOAD_PORT
        },
        files: [
          'app/{,*/}*.html',
          'app/css/{,*/}*.css',
          'app/js/{,*/}*.js',
          'app/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
        ]
      }
    },

    connect: {
      options: {
        port: 9000,
        # Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost'
      },
      livereload: {
        options: {
          #middleware: (connect) ->
            #return [
              #lrSnippet,
              #mountFolder(connect, 'app')
            #]
          middleware: (connect, options) ->
            return [
              lrSnippet,

              urlRewrite('app', 'index.html'),

              mountFolder(connect, 'app')
            ]
        }

      },
      test: {
        options: {
          middleware: (connect) ->
            return [
              mountFolder(connect, 'app'),
              mountFolder(connect, 'test')
            ]
        }
      }
    },

    concurrent: {
      server: [
        'coffee:dist',
        'compass:server'
      ]
    },


    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      all: [
        'Gruntfile.js',
        'app/js/{,*/}*.js'
      ]
    },

    coffee: {
      options: {
        sourceMap: true,
        sourceRoot: ''
      },
      dist: {
        files: [{
          expand: true,
          cwd: 'app/coffee',
          src: '{,*/}*.coffee',
          dest: 'app/js',
          ext: '.js'
        }]
      },
      test: {
        files: [{
          expand: true,
          cwd: 'test/coffee/spec',
          src: '{,*/}*.coffee',
          dest: 'test/js/spec',
          ext: '.js'
        }]
      }
    },

    compass: {
      options: {
        sassDir: 'app/scss',
        cssDir: 'app/css',
        generatedImagesDir: 'app/images/generated',
        imagesDir: 'app/images',
        javascriptsDir: 'app/js',
        fontsDir: 'app/css/fonts',
        importPath: 'app/bower_components',
        httpImagesPath: '/images',
        httpGeneratedImagesPath: '/images/generated',
        httpFontsPath: '/css/fonts',
        relativeAssets: false
      },
      server: {
        options: {
          debugInfo: true
        }
      }
    },
    ngconstant: {
      options: {
        space: '  '
      },

      holmesConfig: [{
        dest: 'app/js/config.js',
        wrap: '"use strict";\n\n <%= __ngModule %>',
        name: 'HolmesConfig',
        constants: {
          'baseUrl': 'http://local.holmes.com:2368/',
          'wsUrl': 'ws://local.holmes.com:2368/events/',
          'timeToLive': 3000,
        }
      }],
    }
  )

  grunt.registerTask('default', [
    'build',
  ])

  grunt.registerTask('build', [
    'ngconstant:holmesConfig',
    'coffee',
    'jshint',
    'compass'
  ])

  grunt.registerTask('run', [
    'ngconstant:holmesConfig',
    'concurrent:server',
    'connect:livereload',
    'watch',
  ])
