var express = require('express');
var router = express.Router();
var admin_postController = require('./admin/admin_postController')

router.get('/',(req,res)=>{
    res.render('admin/index',{
        layout:'mainAdmin.hbs'
    })
})

router.use('/post',admin_postController);

router.get('/listpost',(req,res)=>{
    res.render('admin/listpost',{
        layout:'mainAdmin.hbs'
    })
})

module.exports=router;
