var db = require('../database/db');

exports.loadChuyenMuc=()=>{
    let sql = 'select * from ChuyenMuc;';
    return db.load(sql);
}