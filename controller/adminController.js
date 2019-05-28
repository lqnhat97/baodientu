var express = require('express');
var router = express.Router();

router.get('/',(req,res)=>{
    res.render('admin/index',{
        layout:'mainAdmin.hbs'
    })
})

router.get('/post',(req,res)=>{
    res.render('admin/post',{
        layout:'mainAdmin.hbs'
    })
})

router.get('/listpost',(req,res)=>{
    res.render('admin/listpost',{
        layout:'mainAdmin.hbs'
    })
})

module.exports=router;
