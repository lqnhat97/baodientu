var db = require('../database/db');

exports.loadBaiVietNoiBat=(id)=>{
    let sql = `call HienThiBaiVietNoiBat(${id});`;
    return db.load(sql);
}
exports.loadXemNhieuNhat=(id)=>{
    let sql = `call HienThiBaiVietXemNhieuNhat (${id});`;
    return db.load(sql);
}
exports.loadMoiNhat=(id)=>{
    let sql = `call HienThiBaiVietMoiNhat (${id});`;
    return db.load(sql);
}
exports.loadTopChuyenMuc=(id)=>{
    let sql = `call HienThiTopChuyenMuc(${id});`;
    return db.load(sql);
}