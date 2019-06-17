var exphbs = require('express-handlebars');
var hbs_sections = require('express-handlebars-sections');
var moment = require('moment');
module.exports = function (app) {
  app.engine('hbs', exphbs({
    layoutsDir: 'views/layouts',
    helpers: {
      section: hbs_sections(),
      format: val => {
        return moment(val).format("DD/MM/YYYY hh:MM:ss");
      },

    }
  }));
}