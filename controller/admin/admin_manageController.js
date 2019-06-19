var express = require('express');
var router = express.Router();
var managerRepo = require('../../repository/admin/admin_manager')
var moment = require('moment');

router.get('/categories', (req, res) => {
    let cm = managerRepo.loadAllChuyenMuc();
    let tags = managerRepo.loadAllTags();
    Promise.all([cm, tags]).then(([cmRes, tagsRes]) => {
        resData = {
            layout: 'mainAdmin.hbs',
            cmRes,
            tagsRes,
            title: "Danh sách chuyên mục"
        }
        res.render('admin/manageCategory', resData);
    });
})

router.get('/posts', (req, res) => {
    let post = managerRepo.allPostChuaXuatBan().then(rows => {
        resData = {
            layout: 'mainAdmin.hbs',
            rows,
            title: "Danh sách bài viết chưa xuất bản"
        }
        res.render('admin/managePost', resData);
    });
    // let tags = managerRepo.loadAllTags();
    // Promise.all([cm,tags]).then(([cmRes,tagsRes])=>{

    // });
})

router.get('/users', (req, res) => {
    let post = managerRepo.allUser(req.session.passport.user.ID).then(rows => {
        resData = {
            layout: 'mainAdmin.hbs',
            rows,
            title: "Danh sách người dùng"
        }
        res.render('admin/manageUser', resData);
    });
})

router.post('/changeNameCategory', (req, res) => {
    req.query.cmCha == null ? 'null' : req.query.cmCha;
    managerRepo.suaChuyenMuc(req.query.id, req.body.name, req.query.cmCha).then(rows => {
        res.redirect('/admin/manage/categories')
    }).catch(err => {
        console.log(err);
        res.render('error404', {
            layout: 'mainAdmin.hbs'
        })
    })
})

router.get('/delCategory', (req, res) => {
    console.log(req.query)
    managerRepo.xoaChuyenMuc(req.query.id).then(rows => {
        res.redirect('/admin/manage/categories')
    }).catch(err => {
        console.log(err);
        res.render('error404', {
            layout: 'mainAdmin.hbs'
        })
    })
})

router.get('/delTag', (req, res) => {
    console.log(req.query)
    managerRepo.xoaChuyenMuc(req.query.tag).then(rows => {
        res.redirect('/admin/manage/categories')
    }).catch(err => {
        console.log(err);
        res.render('error404', {
            layout: 'mainAdmin.hbs'
        })
    })
})

router.get('/forward',(req,res)=>{
    let id = req.query.idBaiViet;
    managerRepo.forwardPost(id).then(rows => {
        res.redirect('/admin/manage/posts')
    }).catch(err => {
        console.log(err);
        res.render('error404', {
            layout: 'mainAdmin.hbs'
        })
    })
})

router.get('/giahan',(req,res)=>{
    let id = req.query.id;
    var date = new Date();
    date =(moment(date.setDate(date.getDate()+7)).format('YYYY-MM-DD'));
    managerRepo.giaHan(id,date).then(rows => {
        res.redirect('/admin/manage/users')
    }).catch(err => {
        console.log(err);
        res.render('error404', {
            layout: 'mainAdmin.hbs'
        })
    })
})

router.get('/delUser',(req,res)=>{
    let id = req.query.id;
    managerRepo.delUser(id).then(rows => {
        res.redirect('/admin/manage/users')
    }).catch(err => {
        console.log(err);
        res.render('error404', {
            layout: 'mainAdmin.hbs'
        })
    })
})

module.exports = router;