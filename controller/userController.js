var express = require('express');
var bcrypt = require('bcrypt');
var moment = require('moment');
var passport = require('passport');
var userModel = require('../repository/user');

var router = express.Router();

router.get('/login', (req, res) => {
    res.render("login", {
        layout: 'main.hbs'
    });
});

router.get('/signup', (req, res) => {
    res.render("signup", {
        layout: 'main.hbs'
    });   
});

router.post('/signup', (req, res) => {
    var saltRounds = 10;
    // var hash = bcrypt.hashSync(req.body.password, saltRounds);
    //var date = moment(req.body.birth, 'MM/DD/YYYY').format('YYYY-MM-DD');

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

module.exports = router;