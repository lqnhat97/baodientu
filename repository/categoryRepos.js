var db = require('../database/db');

module.exports = {
    chuyenmuc:(id)=>{
        return db.load(`select * from chuyenmuc where IDChuyenMuc = '${id}'`)
    },
    pageByCat: (idChuyenMuc, limit, offset) => {
        return db.load(`select * from baiviet left join chuyenmuc on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc where baiviet.ChuyenMuc = '${idChuyenMuc}' order by baiviet.NgayDang desc limit ${limit} offset ${offset}`);
    },
    countByCat: catId => {
        return db.load(`select count(*) as total from baiviet where ChuyenMuc = '${catId}'`);
    },
}