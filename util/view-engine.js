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
      formatDate: val => {
        return moment(val).format("DD/MM/YYYY");
      },
      formatDate1: val => {
        return moment(val).format("YYYY-MM-DD");
      },
      ifCond: function (v1, operator, v2, options) {
        switch (operator) {
          case '==':
            return (v1 == v2) ? options.fn(this) : options.inverse(this);
          case '===':
            return (v1 === v2) ? options.fn(this) : options.inverse(this);
          case '!=':
            return (v1 != v2) ? options.fn(this) : options.inverse(this);
          case '!==':
            return (v1 !== v2) ? options.fn(this) : options.inverse(this);
          case '<':
            return (v1 < v2) ? options.fn(this) : options.inverse(this);
          case '<=':
            return (v1 <= v2) ? options.fn(this) : options.inverse(this);
          case '>':
            return (v1 > v2) ? options.fn(this) : options.inverse(this);
          case '>=':
            return (v1 >= v2) ? options.fn(this) : options.inverse(this);
          case '&&':
            return (v1 && v2) ? options.fn(this) : options.inverse(this);
          case '||':
            return (v1 || v2) ? options.fn(this) : options.inverse(this);
          default:
            return options.inverse(this);
        }
      },
      json: function (content) {
        return JSON.stringify(content);
      }
    },
  }));
}