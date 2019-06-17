var db = require('../database/db');

exports.loadBaiVietNoiBat=()=>{
    let sql = 'call HienThiBaiVietNoiBat();';
    return db.load(sql);
}
exports.loadXemNhieuNhat=()=>{
    let sql = `call HienThiBaiVietXemNhieuNhat ();`;
    return db.load(sql);
}
exports.loadMoiNhat=()=>{
    let sql = `call HienThiBaiVietMoiNhat ();`;
    return db.load(sql);
}
exports.loadTopChuyenMuc=()=>{
    let sql = `call HienThiTopChuyenMuc();`;
    return db.load(sql);
}