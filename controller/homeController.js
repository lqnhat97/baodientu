var express = require('express');
var router = express.Router();
var homeRepo = require('../repository/homepageRepos');
router.get('/', (req, res)=> {
    let noiBat = homeRepo.loadBaiVietNoiBat();
    let xemNhieu = homeRepo.loadXemNhieuNhat();
    let moiNhat = homeRepo.loadMoiNhat();
    let topChuyenMuc = homeRepo.loadTopChuyenMuc();
    Promise.all([noiBat,xemNhieu,moiNhat,topChuyenMuc]).then(([noiBatRes,xemNhieuRes,moiNhatRes,topChuyenMucRes])=>{
        let resData = {
            layout:'main.hbs',
            tinNoiBat : noiBatRes[0],
            tinXemNhieu1: xemNhieuRes[0][0],
            tinXemNhieu: xemNhieuRes[0],
            tinMoiNhat: moiNhatRes[0],
            topChuyenMuc:topChuyenMucRes[0]
        };
        res.render("index",resData);
    })
});

module.exports = router;