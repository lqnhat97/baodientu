var express = require('express');
var router = express.Router();
var homeRepo = require('../repository/homepageRepos');
router.get('/', (req, res)=> {
    let noiBat = homeRepo.loadBaiVietNoiBat();
    let xemNhieu = homeRepo.loadXemNhieuNhat();
    let moiNhat = homeRepo.loadMoiNhat();
    Promise.all([noiBat,xemNhieu,moiNhat]).then(([noiBatRes,xemNhieuRes,moiNhatRes])=>{
        let resData = {
            layout:'main.hbs',
            tinNoiBat : noiBatRes,
            tinXemNhieu: xemNhieuRes,
            tinMoiNhat: moiNhatRes
        };
        res.render("index",resData);
    })
});

module.exports = router;