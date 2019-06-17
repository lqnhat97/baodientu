var db = require('../database/db');

module.exports = {
    tag:(tag)=>{
        return db.load(`select * from nhan where TenTag = '${tag}'`)
    },
    pageByTag: (tag, limit, offset) => {
        return db.load(`select * from baiviet left join nhan on nhan.IDBaiViet = baiviet.IDBaiViet left join chuyenmuc on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc where nhan.TenTag = '${tag}' order by baiviet.NgayDang desc limit ${limit} offset ${offset}`);
    },
    countByTag: tag => {
        return db.load(`select count(*) as total from nhan where tentag = '${tag}'`);
    },
}