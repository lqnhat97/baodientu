var express = require('express');
var router = express.Router();
var handleRepo = require('../../repository/admin/admin_handlePost')
router.get('/',(req,res)=>{
    handleRepo.dsBaiVietByManager(req.session.passport.user.ID).then(rows=>{
        console.log(rows)
        resData = {
            layout:'mainAdmin.hbs',
            rows:rows[0],
            title:"Danh sách bài viết chưa được duyệt"
        }
        res.render('admin/handlePost',resData);
    });

})

module.exports = router;