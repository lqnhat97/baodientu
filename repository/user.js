var db = require('../database/db');

module.exports = {
    all: () => {
        return db.load('select * from NguoiDung');
    },
    add: entity => {
        let sql = `call ThemNguoiDung('${entity.userName}', '${entity.matKhau}', N'${entity.hoTen}', '${entity.gioiTinh}', '${entity.avatar}', '${entity.ngaySinh}', N'${entity.email}', '${entity.sdt}')`
        return db.load(sql);
    },
    singleByUserName: userName => {
        return db.load(`select * from NguoiDung left join  phanhenguoidung on NguoiDung.PhanHe = phanhenguoidung.IDPhanHe where UserName = '${userName}'`);
    },
    phanHe: phanHe => {
        return db.load(`select * from phanhenguoidung where IDPhanHe = ${phanHe}`);
    },
    update: entity => {
        let sql = `call SuaNguoiDung('${entity.id}','${entity.userName}', '${entity.matKhau}', N'${entity.hoTen}', '${entity.gioiTinh}', '${entity.avatar}', '${entity.ngaySinh}', N'${entity.email}', '${entity.sdt}', '${entity.phanHe}')`
        return db.load(sql);
    }
}