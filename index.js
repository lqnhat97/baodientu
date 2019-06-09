var express = require('express');
var exphbs = require('express-handlebars');
var mainRepos = require('./repository/main');

var app = express();

var adminController = require('./controller/adminController');
var userController = require('./controller/userController')

app.engine('hbs', exphbs({
    layoutsDir: 'views/layouts',
}));
app.set('view engine', 'hbs');
app.use(express.static('public'));
app.set('view option', {
    layout: false
})

//routing
//Trang chủ
app.get('/', function (req, res) {
    res.render("index", {
        layout: 'main.hbs'
    });
});


//Category
app.get('/category', function (req, res) {
    res.render("category", {
        layout: 'main.hbs'
    });
});

//Contact
app.get('/contact', function (req, res) {
    res.render("contact", {
        layout: 'main.hbs'
    });
});

app.use('/admin', adminController);
app.use('/user', userController);


app.listen(3000, () => {
    console.log('connected at http://localhost:3000/')
});