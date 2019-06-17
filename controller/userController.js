var express = require('express')
// var bcrypt = require('bcrypt')
// var moment = require('moment')
var bodyParser = require ('body-parser')
var passport = require('passport')
var localStrategy = require ('passport-local').Strategy
var session = require ('express-session')
var userModel = require('../repository/user')

var router = express.Router()

//Lay du lieu tu from
router.use(bodyParser.urlencoded({extended: true}))
//Thong bao su dung passport
router.use(passport.initialize())
router.use(session ({
    secret: 'somthing',
    cookie: {
        maxAge: 1000 * 50 * 5
    }
}))
router.use(passport.session())

router.get('/login', (req, res) => {
    res.render("login", {
        layout: 'main.hbs'
    })
})

passport.use(new localStrategy (
    (username, password, done) => {
        if (username == 'vyvy71') {
            if (password == 'vyVy7197') {
                return done(null, username)
            } else {
                return done(null, false)
            }
        } else {
            return done(null, false)
        }
    }
))
passport.serializeUser((username, done) => {
    done(null, username)
})
passport.deserializeUser((name, done) => {
    if (name == 'vyVy7197') {
        return done(null, name)
    } else {
        return done(null, fase)
    }
})

router.post(passport.authenticate('local', {
    failureRedirect: '/login',
    successRedirect: '/loginOk'
}))

router.get('/loginOk', (req, res) => res.send('success!!'))

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
        res.render('/user/login')
    }).catch(err => {
        console.log(err)
    })
})

module.exports = router