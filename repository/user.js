var db = require('../database/db');

module.exports = {
    all: () => {
        return db.load('select * from NguoiDung');
    },
    add: entity => {
        return db.add('NguoiDung', entity);
    },
    singleByUserName: userName => {
        return db.load(`select * from NguoiDung left join  phanhenguoidung on NguoiDung.PhanHe = phanhenguoidung.IDPhanHe where UserName = '${userName}'`);
    },
    phanHe: phanHe => {
        return db.load(`select * from phanhenguoidung where IDPhanHe = ${phanHe}`);
    },
}