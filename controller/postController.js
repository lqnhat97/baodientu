var express = require('express');
var postRepo = require('../repository/postDetail');
var router = express.Router();

router.get('/:idBaiViet', function (req, res) {
    let id = 0;
    if (req.session.passport)
        if (req.session.passport.user)
            id = req.session.passport.user.ID;
    let baiViet = postRepo.loadBaiViet(id, req.params.idBaiViet);
    console.log(req.params.idBaiViet);

    let nhan = postRepo.loadNhan(req.params.idBaiViet);
    let binhLuan = postRepo.loadBinhLuan(req.params.idBaiViet);
    Promise.all([baiViet, nhan, binhLuan]).then(([baiVietRes, nhanRes, binhLuanRes]) => {
        try {
            let tangLuotXem = postRepo.tangLuotXem(req.params.idBaiViet);
            let baiVietChuyenMuc = postRepo.loadBaiVietCungChuyenMuc(id, baiVietRes[0][0].IDChuyenMuc);
            let random1bai = postRepo.loadRandom1Bai(baiVietRes[0][0].IDChuyenMuc);

            Promise.all([baiVietChuyenMuc, random1bai]).then(([baiVietChuyenMucRes, random1baiRes]) => {
                let resData = {
                    layout: 'main.hbs',
                    baiViet: baiVietRes[0][0],
                    baiVietChuyenMuc: baiVietChuyenMucRes[0],
                    random1bai: random1baiRes[0],
                    nhan: nhanRes[0],
                    binhLuan: binhLuanRes[0]
                }
                res.render("news-details", resData);
            })
        } catch (error) {
            console.log(error);
            res.render('premiumErr', {
                layout: 'main.hbs'
            })
        }
    })

});

router.post('/:idBaiViet', function (req, res) {
    let binhluan = req.body.noidung;
    let id = req.params.idBaiViet
    let nguoibinhluan = req.session.passport.user.ID
    let binhLuan = postRepo.themBinhLuan(id, binhluan, nguoibinhluan).then(rows => {
        res.redirect("/post/" + id);
    });
});

module.exports = router;