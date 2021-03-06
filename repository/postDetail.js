var db = require('../database/db');

exports.loadBaiViet=(id,idBaiViet)=>{
    let sql = `call HienThiBaiVietChiTiet(${id},'${idBaiViet}')`;
    return db.load(sql);
}

exports.loadRandom1Bai=(idChuyenMuc)=>{
    let sql = `select baiviet.ChuyenMuc, baiviet.idbaiviet, baiviet.AnhDaiDien, baiviet.TieuDe ,baiviet.XemTruoc, baiviet.NgayDang
	from baiviet 
	where baiviet.ChuyenMuc = '${idChuyenMuc}'
    order by rand()
    limit 1;`;
    return db.load(sql);
}

exports.loadBaiVietCungChuyenMuc=(id,idChuyenMuc)=>{
    let sql = `call HienThiBaiVietCungChuyenMuc(${id},'${idChuyenMuc}')`;
    return db.load(sql);
}

exports.loadNhan=(idBaiViet)=>{
    let sql = `call HienThiNhan('${idBaiViet}');`;
    return db.load(sql);
}

exports.tangLuotXem=(idBaiViet)=>{
    let sql = `call TangLuotXem('${idBaiViet}');`;
    return db.load(sql);
}

exports.loadBinhLuan=(idBaiViet)=>{
    let sql = `call HienThiBinhLuan('${idBaiViet}');`;
    return db.load(sql);
}

exports.themBinhLuan=(idBaiViet,noiDung,nguoibinhluan)=>{
    let sql = `call ThemBinhLuan(null,${idBaiViet},'${nguoibinhluan}','${noiDung}');`;
    return db.load(sql);
}