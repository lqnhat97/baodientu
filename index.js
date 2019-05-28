var express = require('express');
var exphbs  = require('express-handlebars');
var db = require('./database/db');

var app = express();

var adminController = require('./controller/adminController');

app.engine('hbs', exphbs({
    defaultLayout:'main.hbs',
    layoutsDir:'views/layouts'
}));
app.engine('hbs', exphbs({
    layoutsDir:'views/layouts'
}));
app.set('view engine', 'hbs');
app.use(express.static('public'));
app.set('view option',{layout:false})

//routing
//Trang chủ
app.get('/', function (req, res) {
    db.load('select * from NguoiDung').then(row=>{
        console.log(row);
    }).catch(e=>{
        if(e) throw e;
    })
    res.render("index",{
        layout:'main.hbs'
    });
});

//Đăng nhập
app.get('/login', function (req, res) {
    res.render("login",{
        layout:'main.hbs'
    });
});

//Đăng xuất
app.get('/signup', function (req, res) {
    res.render("signup",{
        layout:'main.hbs'
    });
});

//Category
app.get('/category', function (req, res) {
    res.render("category",{
        layout:'main.hbs'
    });
});

//Contact
app.get('/contact', function (req, res) {
    res.render("contact",{
        layout:'main.hbs'
    });
});

app.use('/admin',adminController);

app.listen(3000,()=>{
    console.log('connected at http://localhost:3000/')
});