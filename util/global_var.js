var categoryRepos = require('../repository/main');

module.exports =(req,res)=>{
    categoryRepos.loadChuyenMuc().then(rows =>{
        res.local._category = rows;
    })
}