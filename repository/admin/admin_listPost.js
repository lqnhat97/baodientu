var db = require('../../database/db');

module.exports = {
    dsBaiVietByWriterID:() => {
        return db.load(`select * from baiviet left join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc where phongvien = 1`)
    }
}