module.exports = {
  options: {
    port: 9000,
    hostname: 'localhost',
    livereload: 35729
  },
  livereload: {
    options: {
      open: true,
      base: ['.tmp', '<%= yeoman.app %>']
    }
  },
  test: {
    options: {
      port: 9001,
      base: ['.tmp', 'test', '<%= yeoman.app %>']
    }
  },
  dist: {
    options: {
      base: '<%= yeoman.dist %>'
    }
  }
};