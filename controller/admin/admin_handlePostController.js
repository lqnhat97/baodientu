var express = require('express');
var router = express.Router();
var handleRepo = require('../../repository/admin/admin_handlePost')
router.get('/',(req,res)=>{
    handleRepo.dsBaiVietByManager(req.session.passport.user.ID).then(rows=>{
        resData = {
            layout:'mainAdmin.hbs',
            rows:rows[0],
            title:"Danh sách bài viết chưa được xử lý"
        }
        res.render('admin/handlePost',resData);
    });
})

router.get('/handled',(req,res)=>{
    handleRepo.dsBaiVietAllByManager(req.session.passport.user.ID).then(rows=>{
        resData = {
            layout:'mainAdmin.hbs',
            rows:rows[0],
            title:"Danh sách bài viết đã được xử lý"
        }
        res.render('admin/handledPost',resData);
    });
})

module.exports = router;