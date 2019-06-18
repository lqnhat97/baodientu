var express = require('express');
var router = express.Router();
var homeRepo = require('../repository/homepageRepos');
router.get('/', (req, res) => {
    let id = 0;
    if (req.session.passport)
        if (req.session.passport.user)
            id = req.session.passport.user.ID;
    let noiBat = homeRepo.loadBaiVietNoiBat(id);
    let xemNhieu = homeRepo.loadXemNhieuNhat(id);
    let moiNhat = homeRepo.loadMoiNhat(id);
    let topChuyenMuc = homeRepo.loadTopChuyenMuc(id);
    Promise.all([noiBat, xemNhieu, moiNhat, topChuyenMuc]).then(([noiBatRes, xemNhieuRes, moiNhatRes, topChuyenMucRes]) => {
        let topCM = new Array(3);
        topCM[1] = []
        topCM[2] = []
        topCM[0] = []

        let i = 0;
        while (topChuyenMucRes[0].length != 0) {
            while (i != 3 && topChuyenMucRes[0].length != 0) {
                topCM[i].push(topChuyenMucRes[0].shift());
                i++;
            }
            i = 0;
        }
        let top1 = topCM[0];
        let top2 = topCM[1];
        let top3 = topCM[2];
        let resData = {
            layout: 'main.hbs',
            tinNoiBat: noiBatRes[0],
            tinXemNhieu1: xemNhieuRes[0][0],
            tinXemNhieu: xemNhieuRes[0],
            tinMoiNhat: moiNhatRes[0],
            top1,
            top2,
            top3
        };
        res.render("index", resData);
    })
});

module.exports = router;