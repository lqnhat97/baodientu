var db = require('../database/db');

exports.loadBaiVietNoiBat=()=>{
    let sql = 'select * from baiviet where TinNoiBat = 1;';
    return db.load(sql);
}
exports.loadXemNhieuNhat=()=>{
    let sql = `select * from baiviet order by luotxem desc limit 10;`;
    return db.load(sql);
}
exports.loadMoiNhat=()=>{
    let sql = `select * from baiviet order by ngaydang desc limit 10;`;
    return db.load(sql);
}