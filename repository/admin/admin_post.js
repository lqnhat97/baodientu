var db = require('../../database/db');

exports.loadChuyenMuc=()=>{
    let sql = `select * from ChuyenMuc;`;
    return db.load(sql);
};

exports.themBaiViet=(data)=>{
    let sql = `call ThemBaiViet(null,N'${data.tieuDe}','${data.chuyenMuc}','${data.img}',N'${data.noiDung}',N'${data.xemTruoc}',${data.ID})`;
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