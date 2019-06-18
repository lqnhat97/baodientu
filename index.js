var express = require('express');
var body_parser = require('body-parser');

var app = express();

app.use(body_parser.json());
app.use(body_parser.urlencoded({
    extended: false
}));


require('./util/view-engine')(app);
require('./util/session')(app);
require('./util/passport')(app);

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

app.use('/admin',(req, res, next)=> {
    if (req.isAuthenticated() && 1< req.session.passport.user.PhanHe){
        next();
    } else {
        res.render('error404',{
            layout:'main.hbs'
        });
    }
}, adminController);


app.use('/user', userController);

app.use(handle404);
app.listen(3000, () => {
    console.log('connected at http://localhost:3000/')
});