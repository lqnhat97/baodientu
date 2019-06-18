var db = require('../database/db');

module.exports = {
    chuyenmuc:(id)=>{
        return db.load(`select * from chuyenmuc where IDChuyenMuc = '${id}'`)
    },
    pageByCat: (idChuyenMuc, limit, offset) => {
        return db.load(`call HienThiBaiVietChuyenMuc('${idChuyenMuc}',${limit},${offset});`);
    },
    countByCat: catId => {
        return db.load(`select count(*) as total from baiviet where ChuyenMuc = '${catId}' and baiviet.XuatBan =1`);
    },
}