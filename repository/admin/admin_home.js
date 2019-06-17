var db = require('../../database/db');

module.exports = {
    countChuyenMuc:()=>{
        return db.load(`select count(*) as total from chuyenmuc`)
    },
    countBaiViet:()=>{
        return db.load(`select count(*) as total from baiviet`)
    },
    countThanhVien:()=>{
        return db.load(`select count(*) as total from nguoidung`)
    },
    baiVietMoi:()=>{
        return db.load(`select * from baiviet order by NgayDang desc limit 4`)
    },
    thanhVienMoi:()=>{
        return db.load(`select * from nguoidung left join phanhenguoidung on nguoidung.PhanHe = phanhenguoidung.IDPhanHe order by nguoidung.NgayDangKy desc limit 4;`)
    }
}