var express = require('express');
var router = express.Router();

router.get('/', function (req, res) {
    res.render("category", {
        layout: 'main.hbs'
    });
});

module.exports = router;
