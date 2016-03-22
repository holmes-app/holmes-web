module.exports = {
  replace_flags_path: {
    path: 'dist/styles/vendor.css',
    pattern: '../flags/',
    replacement: '../bower_components/flag-icon-css/flags/',
    recursive: false
  },
  replace_social_signin_buttons_image_path: {
    path: 'dist/styles/vendor.css',
    pattern: 'auth-icons.png',
    replacement: '../bower_components/css3-social-signin-buttons/auth-icons.png',
    recursive: false
  }
};