module.exports = {
  coffee: {
    files: ['<%= yeoman.app %>/scripts/{,*/}*.{coffee,litcoffee,coffee.md}'],
    tasks: ['newer:coffee:dist']
  },
  coffeeTest: {
    files: ['test/spec/{,*/}*.{coffee,litcoffee,coffee.md}'],
    tasks: ['newer:coffee:test', 'karma']
  },
  compass: {
    files: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}'],
    tasks: ['compass:server', 'autoprefixer']
  },
  gruntfile: {
    files: ['Gruntfile.js']
  },
  livereload: {
    options: {
      livereload: '<%= connect.options.livereload %>'
    },
    files: ['<%= yeoman.app %>/{,*/}*.html',
      '.tmp/styles/{,*/}*.css',
      '.tmp/scripts/{,*/}*.js',
      '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
    ]
  }
};