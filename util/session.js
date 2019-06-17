var session = require('express-session');
var MySQLStore = require('express-mysql-session')(session);

var sessionStore = new MySQLStore({
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: '',
  database: 'baodientu',
  createDatabaseTable: true,
  schema: {
      tableName: 'sessions',
      columnNames: {
          session_id: 'session_id',
          expires: 'expires',
          data: 'data'
      }
  }
});
module.exports = function (app) {
  app.use(session({
    secret: 'fgzaaflpt20imorsst20',
    resave: true,
    store: sessionStore,
    saveUninitialized: true
  }));
}