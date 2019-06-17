var express = require('express');
var exphbs = require('express-handlebars');
var express_hbs_sections = require('express-handlebars-sections');
var body_parser = require('body-parser');
var session = require('express-session');
var MySQLStore = require('express-mysql-session')(session);

var app = express();

app.engine('hbs', exphbs({
    layoutsDir: 'views/layouts',
    helpers: {
        section: express_hbs_sections(),
	}
}));

app.use(body_parser.json());
app.use(body_parser.urlencoded({
    extended: false
}));

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



app.use(session({
    key: 'session_cookie_name',
    secret: 'session_cookie_secret',
    store: sessionStore,
    resave: false,
    saveUninitialized: false
}));

app.use(require('./util/global_var'))
app.set('view engine', 'hbs');
app.use(express.static('public'));
app.set('view option', {
    layout: false
})

//routing
var adminController = require('./controller/adminController');
var userController = require('./controller/userController');
var homeController = require('./controller/homeController');
var categoryController = require('./controller/categoryController');
var tagController = require('./controller/tagController');
var postController = require('./controller/postController')

var handle404 = require('./util/handle404');

//Trang chủ
app.use('/',homeController);


//Category
app.use('/category', categoryController);

//tag
app.use('/tag', tagController);

//Post
app.use('/post', postController);

//Contact
app.get('/contact', function (req, res) {
    res.render("contact", {
        layout: 'main.hbs'
    });
});

app.use('/admin', adminController);
app.use('/user', userController);

app.use(handle404);
app.listen(3000, () => {
    console.log('connected at http://localhost:3000/')
});