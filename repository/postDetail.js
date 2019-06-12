var db = require('../database/db');

exports.loadBaiViet=(idBaiViet)=>{
    let sql = `select * from BaiViet where IDBaiViet = '${idBaiViet}';`;
    return db.load(sql);
}