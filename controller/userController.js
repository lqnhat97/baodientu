var express = require('express');
var router = express.Router();

//Đăng nhập
router.get('/login', function (req, res) {
    res.render("login", {
        layout: 'main.hbs'
    });
});

//Đăng ký
router.get('/signup', function (req, res) {
    res.render("signup", {
        layout: 'main.hbs'
    });
});

module.exports = router;