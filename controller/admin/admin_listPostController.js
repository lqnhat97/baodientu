var express = require('express');
var router = express.Router();
var listPostRepo = require('../../repository/admin/admin_listPost')

router.get('/',(req,res)=>{
    listPostRepo.dsBaiVietByWriterID(req.session.passport.user.PhanHe).then(rows=>{
        resData = {
            layout:'mainAdmin.hbs',
            rows,
            title:"Danh sách bài viết chưa được duyệt"
        }
        res.render('admin/listpost',resData);
    });

})

router.get('/refuse',(req,res)=>{
    listPostRepo.dsBaiVietTuChoiByWriterID(req.session.passport.user.PhanHe).then(rows=>{
        resData = {
            layout:'mainAdmin.hbs',
            rows,
            title:"Danh sách bài viết đã bị từ chối"
        }
        res.render('admin/listRefuse',resData);
    });

})

router.get('/exported',(req,res)=>{
    listPostRepo.dsBaiVietXuatBanByWriterID(req.session.passport.user.PhanHe).then(rows=>{
        resData = {
            layout:'mainAdmin.hbs',
            rows,
            title:"Danh sách bài viết đã xuất bản"
        }
        res.render('admin/listExport',resData);
    });
})

router.get('/waitExport',(req,res)=>{
    listPostRepo.dsBaiVietChoXuatBanByWriterID(req.session.passport.user.PhanHe).then(rows=>{
        resData = {
            layout:'mainAdmin.hbs',
            rows,
            title:"Danh sách bài viết đã xuất bản"
        }
        res.render('admin/listWait',resData);
    });
})

router.get('/delete',(req,res)=>{
    let qr = req.query.idBaiViet;
    res.redirect('/admin/post/delete?idBaiViet='+qr)
})

module.exports = router;