var db = require('../database/db');

exports.loadChuyenMuc=()=>{
    let sql = 'select * from chuyenmuc;';
    return db.load(sql);
}