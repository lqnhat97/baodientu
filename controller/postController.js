var express = require('express');
var postRepo = require('../repository/postDetail');
var router = express.Router();

router.get('/:idBaiViet', function (req, res) {
    let baiViet = postRepo.loadBaiViet(req.params.idBaiViet)
    Promise.all([baiViet]).then(([baiVietRes]) => {
        let resData = {
            layout: 'main.hbs',
            baiViet: baiVietRes[0]
        }
        res.render("news-details", resData);
    })

});


module.exports = router;