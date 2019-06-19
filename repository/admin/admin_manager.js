var db = require('../../database/db');

module.exports = {
    loadAllChuyenMuc:() => {
        return db.load(`select a.IDChuyenMuc,a.TenChuyenMuc,a.ChuyenMucCha,b.TenChuyenMuc as TenChuyenMucCha from chuyenmuc a left join chuyenmuc b on a.ChuyenMucCha = b.IDChuyenMuc`)
    },
    loadAllTags:() => {
        return db.load(`select * from nhan group by TenTag`)
    },
    suaChuyenMuc:(idChuyenMuc,TenChuyenMuc,ChuyenMucCha) => {
        return db.load(`call SuaChuyenMuc('${idChuyenMuc}',N'${TenChuyenMuc}','${ChuyenMucCha}') ;`)
    },
    xoaChuyenMuc:(idChuyenMuc) => {
        return db.load(`call XoaChuyenMuc('${idChuyenMuc}') ;`)
    },
    xoaTag:(tag) => {
        return db.load(`call XoaNhanTheoTen('${tag}') ;`)
    },
    allPostChuaXuatBan:() => {
        return db.load(`select * from baiviet left join chuyenmuc on baiviet.ChuyenMuc =  chuyenmuc.IDChuyenMuc where baiviet.XuatBan =0 and baiviet.DaDuyet !=-1 ;`)
    },
    forwardPost:(id) => {
        return db.load(`update baiviet set baiviet.DaDuyet = '1', baiviet.NgayDang = now(), baiviet.XuatBan =1 where baiviet.IDBaiViet = '${id}';`)
    },
    allUser:(id)=>{
        return db.load(`select * from nguoidung left join phanhenguoidung on nguoidung.PhanHe = phanhenguoidung.IDPhanHe where nguoidung.ID !=${id}`)
    },
    giaHan:(id,ngay)=>{
        return db.load(`call GiaHanDocGia(${id},'${ngay}')`)
    },
    delUser:(id)=>{
        return db.load(`call XoaNguoiDung(${id})`)
    }
}