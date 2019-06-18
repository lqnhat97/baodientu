var passport = require('passport');
var localStrategy = require('passport-local').Strategy;
var bcrypt = require('bcrypt');
var userModel = require('../repository/user')

module.exports = function (app) {
  //Thong bao su dung passport
  app.use(passport.initialize());
  app.use(passport.session());

  passport.use(new localStrategy({
    usernameField: 'username',
    passwordField: 'password'
  }, (username, password, done) => {
    userModel.singleByUserName(username).then(rows => {
      if (rows.length === 0) {
        return done(null, false, {
          message: 'Sai tên đăng nhập'
        });
      }
      var user = rows[0];
      if (password == user.MatKhau) {
        return done(null, user);
      }
      return done(null, false, {
        message: 'Sai mật khẩu'
      });
    }).catch(err => {
      return done(err, false);
    })
  }))

  passport.serializeUser((user, done) => {
    return done(null, user);
  });

  passport.deserializeUser((user, done) => {
    return done(null, user);
  });
}