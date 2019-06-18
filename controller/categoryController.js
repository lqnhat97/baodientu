var express = require('express');
var router = express.Router();
var categoryRepo = require('../repository/categoryRepos')

router.get('/:idCategory', function (req, res,next) {
    let idUser = 0;
    if (req.session.passport)
        if (req.session.passport.user)
        idUser = req.session.passport.user.ID;
    var id = req.params.idCategory;
    var page = req.query.page || 1;
    if (page < 1) page = 1;

    var limit = 1;
    var offset = (page - 1) * limit;
    Promise.all([
        categoryRepo.pageByCat(idUser,id, limit, offset),
        categoryRepo.countByCat(id),
        categoryRepo.chuyenmuc(id),
    ]).then(([rows, count_rows,cm]) => {
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
        res.render('category', {
            layout: 'main.hbs',
            baiViet: rows[0].length > 0? rows[0]:false,
            pages,
            cm:cm[0]
        });
    }).catch(next);
});

module.exports = router;