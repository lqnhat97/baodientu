var db = require('../database/db');

exports.loadBaiViet=(idBaiViet)=>{
    let sql = `select * from baiviet where IDBaiViet = '${idBaiViet}';`;
    return db.load(sql);
}