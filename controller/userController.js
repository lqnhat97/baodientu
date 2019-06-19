var express = require('express')
var passport = require('passport');
var userModel = require('../repository/user')
var moment = require('moment')
var router = express.Router()
var fs = require('fs');
const multer = require("multer");

/*router.use(session ({
    secret: 'somthing',
    cookie: {
        maxAge: 1000 * 50 * 5
    }
}))*/
var storage = multer.diskStorage({
    destination: function (req, file, callback) {
        callback(null, './public/img');
    },
    filename: function (req, file, callback) {
        callback(null, file.originalname);
    }
});
var upload = multer({
    storage: storage
});


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

router.post("/signup", upload.single('file'), (req, res) => {
    var entity = res.body;
    var file = './public/img/' + req.file.filename;
    entity = {
        userName: req.body.username,
        matKhau: req.body.password,
        hoTen: req.body.name,
        gioiTinh: req.body.sex,
        avatar: file,
        ngaySinh: req.body.birth,
        email: req.body.email,
        sdt: req.body.phone
    }
    fs.rename(req.file.path, file, function (err) {
        if (err) {
            console.log(err);
            res.send(500);
        } else {
            entity.avatar = file.slice(9);
            (async () => {
                await userModel.add(entity);
                res.redirect('/user/login');
            })();
        }
    });
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

router.post('/profile',  upload.single('file'), (req, res) => {
    var entity = res.body
    var file = './public/img/' + req.file.filename;
    entity = {
        id: req.session.passport.user.ID,
        userName: req.body.username,
        matKhau: req.session.passport.user.MatKhau,
        hoTen: req.body.name,
        gioiTinh: req.body.sex,
        avatar: file,
        ngaySinh: req.body.birth,
        email: req.body.email,
        sdt: req.body.phone,    
        phanHe: req.session.passport.user.PhanHe
    }
    console.log(entity)

    fs.rename(req.file.path, file, function (err) {
        if (err) {
            console.log(err);
            res.send(500);
        } else {
            entity.avatar = file.slice(9);
            (async () => {
                await userModel.update(entity);
                res.redirect('/user/profile');
            })();
        }
    });
})

module.exports = router