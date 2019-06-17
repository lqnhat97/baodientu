var express = require('express');
var fs = require('fs');
var router = express.Router();
var postRepo = require('../../repository/admin/admin_post');
const multer = require("multer");


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
    data.nhan=tag;
    let len = data.nhan.length;
    var file = './public/img/' + req.file.filename;
    fs.rename(req.file.path, file, function (err) {
        if (err) {
            console.log(err);
            res.send(500);
        } else {
            data.img = file.slice(9);
            (async ()=>{
                var dangBai = await postRepo.themBaiViet(data);
                var idMax = await postRepo.idBaiVietMoiNhat();
                for(let i=0;i<len;i++){
                    var themNhan = await postRepo.themNhan({
                        id:idMax[0][0].idbaivietmoi,
                        nhan:data.nhan[i].trim()
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

module.exports = router;