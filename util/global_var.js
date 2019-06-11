var categoryRepos = require('../repository/main');

module.exports =(req,res,next)=>{
    categoryRepos.loadChuyenMuc().then(rows =>{
        res.locals._category = rows;
        next();
    })
}