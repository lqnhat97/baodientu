var express = require('express');
var router = express.Router();
var tagRepo = require('../repository/tagRepos')

router.get('/:tag', function (req, res,next) {
    var tag = req.params.tag;
    var page = req.query.page || 1;
    if (page < 1) page = 1;

    var limit = 1;
    var offset = (page - 1) * limit;
    Promise.all([
        tagRepo.pageByTag(tag, limit, offset),
        tagRepo.countByTag(tag),
        tagRepo.tag(tag),
    ]).then(([rows, count_rows,tg]) => {
        var total = count_rows[0].total;
        var nPages = Math.floor(total / limit);
        if (total % limit > 0) nPages++;
        var pages = [];
        for (i = 1; i <= nPages; i++) {
            var obj = {
                value: i,
                active: i === +page
            };
            pages.push(obj);
        }
        console.log(tg[0]);
        rows.length > 0? rows:undefined
        res.render('tag', {
            layout: 'main.hbs',
            baiViet: rows,
            pages,
            tg:tg[0]
        });
    }).catch(next);
});

module.exports = router;