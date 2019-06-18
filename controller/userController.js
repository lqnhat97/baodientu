var express = require('express')
// var bcrypt = require('bcrypt')
// var moment = require('moment')
var passport = require('passport');
var userModel = require('../repository/user')
var restrict = require('../util/restrict');
var router = express.Router()

/*router.use(session ({
    secret: 'somthing',
    cookie: {
        maxAge: 1000 * 50 * 5
    }
}))*/

router.get('/login', (req, res) => {
    console.log(req.session);
    if (req.session.passport) {
        if (req.session.passport.user) {
            res.redirect('/');
        }
        else res.render("login", {
            layout: 'main.hbs'
        })
    } else
        res.render("login", {
            layout: 'main.hbs'
        })
})



router.post('/login', (req, res, next) => {
    passport.authenticate('local', (err, user, info) => {
        if (err)
            return next(err);

        if (!user) {
            return res.render('login', {
                layout: 'main.hbs',
                err_message: info.message
            })
        }

        req.logIn(user, err => {
            if (err)
                return next(err);
            var url = '/';
            if (req.query.retUrl) {
                url = req.query.retUrl;
            }
            return res.redirect(url);
        });
    })(req, res, next);
})

router.get('/signup', (req, res) => {
    res.render("signup", {
        layout: 'main.hbs'
    })
})

router.post('/signup', (req, res) => {
    var saltRounds = 10
    // var hash = bcrypt.hashSync(req.body.password, saltRounds)
    //var date = moment(req.body.birth, 'MM/DD/YYYY').format('YYYY-MM-DD')

    var entity = {
        UserName: req.body.username,
        MatKhau: req.body.password,
        HoTen: req.body.name,
        GioiTinh: req.body.sex,
        NgaySinh: req.body.birth,
        Email: req.body.email,
        SDT: req.body.phone
    }

    userModel.add(entity).then(id => {
        res.redirect('/user/login')
    }).catch(err => {
        console.log(err)
    })
})

router.get('/logout', (req, res, next) => {
    req.logout();
    res.redirect(req.headers.referer);
})

router.get('/profile', (req, res, next) => {
    if (!req.session.passport) {
        res.redirect('/user/login').end();

    } else {
        if (req.session.passport.user)
            res.render("profile", {
                layout: 'main.hbs'
            })
        else
            res.redirect('/user/login');
    }
})
module.exports = router