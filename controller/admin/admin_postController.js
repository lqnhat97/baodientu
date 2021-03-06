var express = require('express');
var fs = require('fs');
var router = express.Router();
var postRepo = require('../../repository/admin/admin_post');
const multer = require("multer");
const {
    convertHtmlToDelta
} = require('node-quill-converter');

var moment = require('moment');

var storage = multer.diskStorage({
    destination: function (req, file, callback) {
        callback(null, './public/img');
    },
    filename: function (req, file, callback) {
        callback(null, file.originalname);
    }
});
var upload = multer({
    storage: storage
});

router.post("/upload", upload.single('file'), function (req, res) {
    let data = req.body;
    let tag = data.nhan.split(",");
    data.nhan = tag;
    let len = data.nhan.length;
    var file = './public/img/' + req.file.filename;
    data.ID = req.session.passport.user.ID
    fs.rename(req.file.path, file, function (err) {
        if (err) {
            console.log(err);
            res.send(500);
        } else {
            data.img = file.slice(9);
            (async () => {
                var dangBai = await postRepo.themBaiViet(data);
                var idMax = await postRepo.idBaiVietMoiNhat();
                for (let i = 0; i < len; i++) {
                    var themNhan = await postRepo.themNhan({
                        id: idMax[0][0].idbaivietmoi,
                        nhan: data.nhan[i].trim()
                    })
                }
                res.redirect('/');
            })();
        }
    });
});

router.get('/', (req, res) => {
    let chuyenMuc = postRepo.loadChuyenMuc()
    Promise.all([chuyenMuc]).then(([chuyenMucRes]) => {
        let resData = {
            layout: 'mainAdmin.hbs',
            chuyenMuc: chuyenMucRes
        }
        res.render('admin/post', resData)
    })
})

router.get('/edit', (req, res) => {
    var id = req.query.idBaiViet;
    let baiViet = postRepo.loadBaiVietDeSua(id)
    let tag = postRepo.loadNhan(id);
    let chuyenMuc = postRepo.loadChuyenMuc()

    Promise.all([baiViet, tag, chuyenMuc]).then(([baiVietRes, tagRes, chuyenMucRes]) => {
        baiVietRes[0].NoiDung = convertHtmlToDelta(baiVietRes[0].NoiDung);
        if (tagRes.length > 0)
            var tags = tagRes.reduce((tags, value, index, tagRes) => {
                if (index == tagRes.length - 1)
                    return tags += value.TenTag;
                return tags += value.TenTag + ",";
            }, "")
        let resData = {
            layout: 'mainAdmin.hbs',
            baiViet: baiVietRes[0],
            tags,
            chuyenMuc: chuyenMucRes
        }
        res.render('admin/editpost', resData)
    })
})

router.post("/edit", upload.single('file'), function (req, res) {
    let data = req.body;
    let tag = data.nhan.split(",");
    data.nhan = tag;
    let len = data.nhan.length;
    var file = './public/img/' + req.file.filename;
    data.id = req.query.idBaiViet
    fs.rename(req.file.path, file, function (err) {
        if (err) {
            console.log(err);
            res.send(500);
        } else {
            data.img = file.slice(9);
            (async () => {
                var dangBai = await postRepo.suaBaiViet(data);
                var xoaNhan = await postRepo.xoaNhan(data.id);
                for (let i = 0; i < len; i++) {
                    var themNhan = await postRepo.themNhan({
                        id: data.id,
                        nhan: data.nhan[i].trim()
                    })
                }
                res.redirect('/');
            })();

        }
    });
});

router.get('/delete', (req, res) => {
    let id = req.query.idBaiViet;
    let delPost = postRepo.xoaBaiViet(id)
    let delTag = postRepo.xoaNhan(id);
    Promise.all([delPost, delTag]).then(([delPostRes, delTagRes]) => {
        try {
            res.redirect(req.headers.referer);
        } catch (error) {
            render('admin/listpost', {
                layout: 'mainAdmin.hbs',
                message: "Thao tác bị lỗi"
            })
        }
    })
})

router.get('/preview', (req, res) => {
    var id = req.query.idBaiViet;
    let baiViet = postRepo.loadBaiVietDeSua(id)
    Promise.all([baiViet]).then(([baiVietRes]) => {
        baiVietRes[0].NoiDung = convertHtmlToDelta(baiVietRes[0].NoiDung);
        let resData = {
            layout: 'mainAdmin.hbs',
            baiViet: baiVietRes[0],
        }
        res.render('admin/previewPost', resData)
    })
})

router.post('/preview', (req, res) => {
    var id = req.query.idBaiViet;
    // var find = '/';
    // var re = new RegExp(find, 'g');

    // var date = req.body.date.replace(re, '-') + " 00:00:00";
    var date = moment(date).format('YYYY-MM-YY');
    postRepo.xuatBan(req.session.passport.user.ID, id, date).then(() => {
        res.redirect('/admin/handlePost')
    })
})

router.get('/refuse', (req, res) => {
    let id = req.query.idBaiViet;
    postRepo.tuChoiBaiViet(id).then(rows => {
        try {
            res.redirect('/admin/handlePost')
        } catch (error) {
            render('admin/listpost', {
                layout: 'mainAdmin.hbs',
                message: "Thao tác bị lỗi"
            })
        }
    })
})
module.exports = router;