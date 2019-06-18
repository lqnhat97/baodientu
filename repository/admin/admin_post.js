var db = require('../../database/db');

exports.loadChuyenMuc=()=>{
    let sql = `select * from ChuyenMuc;`;
    return db.load(sql);
};

exports.loadBaiVietDeSua=(idBaiViet)=>{
    let sql = `select * from baiviet bv left join chuyenmuc cm on bv.ChuyenMuc = cm.IDChuyenMuc where bv.IDBaiViet = ${idBaiViet};`;
    return db.load(sql);
};

exports.loadNhan=(idBaiViet)=>{
    let sql = `select * from nhan where IDBaiViet = ${idBaiViet};`;
    return db.load(sql);
};

exports.themBaiViet=(data)=>{
    let sql = `call ThemBaiViet(null,N'${data.tieuDe}','${data.chuyenMuc}','${data.img}',N'${data.noiDung}',N'${data.xemTruoc}',${data.ID})`;
    return db.load(sql);
}

exports.suaBaiViet=(data)=>{
    let sql = `call SuaBaiViet(${data.id},N'${data.tieuDe}','${data.chuyenMuc}','${data.img}',N'${data.noiDung}',N'${data.xemTruoc}')`;
    return db.load(sql);
}

exports.xoaBaiViet=(id)=>{
    let sql = `call XoaBaiViet(${id});`;
    return db.load(sql);
}

exports.idBaiVietMoiNhat=()=>{
    let sql = `call LayIDBaiVietMoi(@idbaivietmoi);`;
    return db.load(sql);
}

exports.themNhan=(data)=>{
    let sql = `call ThemNhan(${data.id},'${data.nhan}');`;
    return db.load(sql);
}

exports.xoaNhan=(idBaiViet)=>{
    let sql = `call XoaNhan('${idBaiViet}');`;
    return db.load(sql);
}