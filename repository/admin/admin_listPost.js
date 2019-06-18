var db = require('../../database/db');

module.exports = {
    dsBaiVietByWriterID:id => {
        return db.load(`select * from baiviet left join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc where phongvien = ${id} and baiviet.DaDuyet = 0 and baiviet.XuatBan = 0 `)
    },
    dsBaiVietTuChoiByWriterID:id => {
        return db.load(`select * from baiviet left join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc where phongvien = ${id} and baiviet.DaDuyet = -1 and baiviet.XuatBan = 0 `)
    },
    dsBaiVietXuatBanByWriterID:id => {
        return db.load(`select * from baiviet left join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc where phongvien = ${id} and baiviet.XuatBan = 1 `)
    },
    dsBaiVietChoXuatBanByWriterID:id => {
        return db.load(`select * from baiviet left join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc where phongvien = ${id} and  baiviet.DaDuyet = 1 and baiviet.XuatBan = 0 `)
    }
}