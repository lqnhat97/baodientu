var express = require('express');
var router = express.Router();
var listPostRepo = require('../../repository/admin/admin_listPost')

router.get('/',(req,res)=>{
    listPostRepo.dsBaiVietByWriterID(req.session.passport.user.PhanHe).then(rows=>{
        resData = {
            layout:'mainAdmin.hbs',
            rows
        }
        res.render('admin/listpost',resData);
    });

})

module.exports = router;