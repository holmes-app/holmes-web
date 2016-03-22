module.exports = {
  server: ['coffee:dist', 'compass:server'],
  test: ['coffee', 'compass'],
  dist: ['coffee', 'compass:dist', 'imagemin', 'svgmin']
};