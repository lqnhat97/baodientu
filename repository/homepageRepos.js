var db = require('../database/db');

exports.loadBaiVietNoiBat=()=>{
    let sql = 'select * from BaiViet where TinNoiBat = 1;';
    return db.load(sql);
}
exports.loadXemNhieuNhat=()=>{
    let sql = `select * from BaiViet order by luotxem desc limit 10;`;
    return db.load(sql);
}
exports.loadMoiNhat=()=>{
    let sql = `select * from BaiViet order by ngaydang desc limit 10;`;
    return db.load(sql);
}