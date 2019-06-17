var express = require('express');
var router = express.Router();
var adminHomeRepo=require('../repository/admin/admin_home');
var moment = require('moment');

var admin_postController = require('./admin/admin_postController');
var admin_listPostController = require('./admin/admin_listPostController');

router.get('/',(req,res)=>{
    let thanhVien = adminHomeRepo.countThanhVien();
    let baiViet = adminHomeRepo.countBaiViet();
    let chuyenMuc = adminHomeRepo.countChuyenMuc();
    let baiVietMoi = adminHomeRepo.baiVietMoi();
    let thanhVienMoi = adminHomeRepo.thanhVienMoi();
    Promise.all([thanhVien,baiViet,chuyenMuc,baiVietMoi,thanhVienMoi]).then(([thanhVienRes,baiVietRes,chuyenMucRes,baiVietMoiRes,thanhVienMoiRes])=>{
        let resData = {
            thanhVienRes:thanhVienRes[0],
            baiVietRes:baiVietRes[0],
            chuyenMucRes:chuyenMucRes[0],
            baiVietMoiRes,
            thanhVienMoiRes,
            layout:'mainAdmin.hbs'
        }
        res.render('admin/index',resData)
    })
    
})

router.use('/post',admin_postController);

router.use('/listPost',admin_listPostController)

module.exports=router;
