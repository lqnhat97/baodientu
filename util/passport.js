var passport = require('passport');
var localStrategy = require('passport-local').Strategy;
var bcrypt = require('bcrypt');
var userModel = require('../repository/user')

module.exports = function (app) {
  //Thong bao su dung passport
  app.use(passport.initialize());
  app.use(passport.session());

  /*var ls = new LocalStrategy({
    usernameField: 'username',
    passwordField: 'password'
  }, (username, password, done) => {
    userModel.singleByUserName(username).then(rows => {
      if (rows.length === 0) {
        return done(null, false, {
          message: 'Invalid username.'
        });
      }

      var user = rows[0];
      var ret = bcrypt.compareSync(password, rows[0].f_Password);
      if (ret) {
        return done(null, user);
      }

      return done(null, false, {
        message: 'Invalid password.'
      });
    }).catch(err => {
      return done(err, false);
    })
  });

  passport.use(ls); */

  passport.use(new localStrategy({
    usernameField: 'username',
    passwordField: 'password'
  }, (username, password, done) => {
    userModel.singleByUserName(username).then(rows => {
      console.log(rows)
      if (rows.length === 0) {
        return done(null, false, {
          message: 'Sai tên đăng nhập'
        });
      }
      var user = rows[0];
      if (password == rows[0].MatKhau){
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