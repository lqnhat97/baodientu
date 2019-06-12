var express = require('express');
var router = express.Router();

router.get('/:idBaiViet', function (req, res) {
    res.render("category", {
        layout: 'main.hbs'
    });
});

module.exports = router;
