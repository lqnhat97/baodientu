
/* PROCEDURE Hiển thị 4 bài viết mới nhất */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietMoiNhat; 
call HienThiBaiVietMoiNhat (); */
delimiter //
create procedure HienThiBaiVietMoiNhat ()
BEGIN
	select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc,baiviet.IDBaiViet, baiviet.TieuDe, baiviet.XemTruoc, baiviet.LuotXem, baiviet.NgayDang, count(binhluan.IDBinhLuan) as slbinhluan
	from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
				left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
                
	where baiviet.XuatBan = 1
    group by baiviet.idbaiviet
	order by baiviet.NgayDang DESC 
    limit 4;
END //
delimiter ;

/*-----------------------------------*/

/* PROCEDURE Hiển thị 3 bài viết được xem nhiều nhất */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietXemNhieuNhat; 
call HienThiBaiVietXemNhieuNhat (); */
delimiter //
create procedure HienThiBaiVietXemNhieuNhat ()
BEGIN
	select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, 
    baiviet.TieuDe, baiviet.XemTruoc, baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan
	from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
    left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
	where baiviet.XuatBan = 1
    group by baiviet.idbaiviet
	order by baiviet.LuotXem DESC 
    limit 4;
END //
delimiter ;
/*-----------------------------------*/
/* PROCEDURE Hiển thị 3 bài viết nổi bật*/
/* DROP PROCEDURE IF EXISTS HienThiBaiVietNoiBat;
call HienThiBaiVietNoiBat(); */
delimiter //
create procedure HienThiBaiVietNoiBat()
BEGIN
	select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, baiviet.XemTruoc, baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan
	from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
    left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
	where baiviet.TinNoiBat = 1 and baiviet.XuatBan = 1
	group by baiviet.idbaiviet
    ORDER BY RAND() LIMIT 3;
END //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Hiển thị top 10 chuyên mục, mỗi chuyên mục 1 bài mới nhất*/
/* DROP PROCEDURE IF EXISTS HienThiTopChuyenMuc; 
call HienThiTopChuyenMuc(); */
delimiter //
create procedure HienThiTopChuyenMuc()
BEGIN
	select baiviet.AnhDaiDien, a.IDChuyenMuc, a.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan
	from baiviet left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet,( select  chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, max(baiviet.NgayDang) as NgayMoiNhat
					 from chuyenmuc inner join baiviet on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc
					 group by baiviet.ChuyenMuc ) as a
	where baiviet.ChuyenMuc = a.IDChuyenMuc and baiviet.NgayDang = a.NgayMoiNhat and baiviet.XuatBan = 1
    group by baiviet.idbaiviet
	order by rand() limit 9;
END //
delimiter ;
/*-----------------------------------*/
/* PROCEDURE Hiển thị bài viết theo chuyên mục*/
/* DROP PROCEDURE IF EXISTS HienThiBaiVietChuyenMuc; 
call HienThiBaiVietChuyenMuc('PL1',5,0); */
delimiter //
create procedure HienThiBaiVietChuyenMuc(in idchuyenmuc varchar(20), in lim int, in os int)
BEGIN
	select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.XemTruoc
	from baiviet inner join chuyenmuc on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc
    left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet 
	where baiviet.ChuyenMuc = idchuyenmuc and baiviet.XuatBan = 1
    group by baiviet.idbaiviet
    order by baiviet.NgayDang
    limit lim offset os;
END //
delimiter ;
/*-----------------------------------*/
/* PROCEDURE Hiển thị bài viết theo nhãn*/
/* DROP PROCEDURE IF EXISTS HienThiBaiVietTheoNhan; 
call HienThiBaiVietTheoNhan('Phi tang xác',2,0); */
delimiter //
create procedure HienThiBaiVietTheoNhan(in tentag varchar(20), in lim int, in os int)
BEGIN
	select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.XemTruoc
	from baiviet inner join chuyenmuc on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc
    left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet 
    left join nhan on baiviet.IDBaiViet = nhan.IDBaiViet
	where nhan.TenTag = tentag and baiviet.XuatBan = 1
    group by baiviet.idbaiviet
    order by baiviet.NgayDang
    limit lim offset os;
END //
delimiter ;
/*-----------------------------------*/
/* PROCEDURE Hiển thị bài viết chi tiết */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietChiTiet;
call HienThiBaiVietChiTiet('2'); */
delimiter //
create procedure HienThiBaiVietChiTiet (in idbaiviet int)
BEGIN
	select baiviet.IDBaiViet, baiviet.AnhDaiDien, baiviet.TieuDe, baiviet.NoiDung,  count(binhluan.IDBinhLuan) as slbinhluan, nguoidung.HoTen as nguoidang, baiviet.NgayDang,
		   chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc
	from baiviet left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
				 inner join nguoidung on baiviet.phongvien = nguoidung.id
                 inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
	where baiviet.IDBaiViet = idbaiviet and baiviet.XuatBan = 1
    group by binhluan.IDBaiViet;
END //
delimiter ;

/*-----------------------------------*/

/* PROCEDURE Hiển thị 5 bài viết cùng chuyên mục */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietCungChuyenMuc; 
call HienThiBaiVietCungChuyenMuc('TTA1'); */
delimiter //
create procedure HienThiBaiVietCungChuyenMuc (in idchuyenmuc varchar(15))
BEGIN
	select baiviet.ChuyenMuc, baiviet.idbaiviet, baiviet.AnhDaiDien, baiviet.TieuDe, baiviet.NgayDang
	from baiviet 
	where baiviet.ChuyenMuc = idchuyenmuc and baiviet.XuatBan = 1
    order by rand()
    limit 4;
END //
delimiter ;

/*-----------------------------------*/

/* PROCEDURE Hiển thị bình luận */
/* DROP PROCEDURE IF EXISTS HienThiBinhLuan; 
call HienThiBinhLuan('2'); */
delimiter //
create procedure HienThiBinhLuan (in idbaiviet int)
BEGIN
	select baiviet.idbaiviet, binhluan.idbinhluan, nguoidung.HoTen as nguoibinhluan, binhluan.noidung, binhluan.ngaydang
	from baiviet inner join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
				 inner join nguoidung on binhluan.docgia = nguoidung.id
	where baiviet.IDBaiViet = idbaiviet;
END //
delimiter ;

/*-----------------------------------*/

/* PROCEDURE Hiển thị nhãn */
/* DROP PROCEDURE IF EXISTS HienThiNhan; 
call HienThiNhan('2'); */
delimiter //
create procedure HienThiNhan (in idbaiviet int)
BEGIN
	select baiviet.idbaiviet, nhan.tentag
	from baiviet inner join nhan on baiviet.IDBaiViet = nhan.IDBaiViet
	where baiviet.IDBaiViet = idbaiviet;
END //
delimiter ;

/*-----------------------------------*/

/* PROCEDURE Thêm bài viết */
/* DROP PROCEDURE IF EXISTS ThemBaiViet; 
call ThemBaiViet (null,'a','TT1','b','abc','xyz',2); */
delimiter //
create procedure ThemBaiViet (IN idbaiviet int, IN tieude varchar(255) CHARACTER SET utf8, IN ChuyenMuc varchar(10),
  IN AnhDaiDien  varchar(255), IN NoiDung text CHARACTER SET utf8, IN XemTruoc text CHARACTER SET utf8,
  IN PhongVien int)
BEGIN
	insert baiviet (IDBaiViet,TieuDe,ChuyenMuc,AnhDaiDien,NoiDung,XemTruoc,PhongVien) values (idbaiviet,tieude,ChuyenMuc,AnhDaiDien,NoiDung,XemTruoc,PhongVien);
END //
delimiter ;

/* PROCEDURE Lấy ID bài viết mới nhất */
/* DROP PROCEDURE IF EXISTS LayIDBaiVietMoi;
call LayIDBaiVietMoi(@idbaivietmoi); */
delimiter //
create procedure LayIDBaiVietMoi (OUT idbaivietmoi int)
begin 
	select MAX(idbaiviet) as idbaivietmoi from baiviet;
end //
delimiter ;
/*-----------------------------------*/

/* PROCEDURE Thêm nhãn */
/* DROP PROCEDURE IF EXISTS ThemNhan;
call ThemNhan(15,'Phi tang xác');
call ThemNhan(15,'Chặt xác');  */
delimiter //
create procedure ThemNhan (in idbaiviet int, in tentag varchar(20))
begin 
	if not exists (select * from nhan where nhan.IDBaiViet = idbaiviet and nhan.TenTag = tentag)
    then  
		insert nhan values (idbaiviet,tentag);
	end if;
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Thêm bình luận */
/* DROP PROCEDURE IF EXISTS ThemBinhLuan; 
call ThemBinhLuan(null,2,'9','Xuat sac!'); */
delimiter //
create procedure ThemBinhLuan (in idbinhluan int, in idbaiviet int, in docgia int, in noidung text  CHARACTER SET utf8)
begin 
	insert binhluan(idbinhluan,idbaiviet,docgia,noidung) values (idbinhluan,idbaiviet,docgia,noidung);
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Tăng lượt xem */
/* DROP PROCEDURE IF EXISTS TangLuotXem; 
call TangLuotXem('1'); */
delimiter //
create procedure TangLuotXem (in idbaiviet int)
begin 
	update BaiViet set LuotXem = LuotXem+1 where BaiViet.idbaiviet = idbaiviet; 
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Hiệu chỉnh bài viết */
/* DROP PROCEDURE IF EXISTS SuaBaiViet;
call SuaBaiViet(1,'tieude','ChuyenMuc','AnhDaiDien','NoiDung','XemTruoc') */
delimiter //
create procedure SuaBaiViet(in idbaiviet int, IN tieude varchar(255) CHARACTER SET utf8, IN ChuyenMuc varchar(10),
  IN AnhDaiDien  varchar(255), IN NoiDung text CHARACTER SET utf8, IN XemTruoc text CHARACTER SET utf8)
begin 
	update baiviet set baiviet.TieuDe = tieude, baiviet.ChuyenMuc = ChuyenMuc, baiviet.AnhDaiDien = AnhDaiDien, baiviet.NoiDung = NoiDung,baiviet.XemTruoc = XemTruoc
	where baiviet.IDBaiViet = idbaiviet;
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Xóa  nhãn */
/* DROP PROCEDURE IF EXISTS XoaNhan; 
call XoaNhan('15'); */
delimiter //
create procedure XoaNhan(in idbaiviet int)
begin 
	if exists (select * from nhan where nhan.IDBaiViet = idbaiviet)
    then 
		delete from nhan where nhan.IDBaiViet = idbaiviet;
	end if;
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Xem danh sách bài viết  trong chuyên mục do mình quản lý */
/* DROP PROCEDURE IF EXISTS XemBaiVietDoMinhQuanLy; 
call XemBaiVietDoMinhQuanLy(6); */
delimiter //
create procedure XemBaiVietDoMinhQuanLy(in idbtv int)
begin 
	select baiviet.TieuDe, chuyenmuc.TenChuyenMuc, baiviet.NgayViet
    from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
    inner join bientap_chuyenmuc on chuyenmuc.IDChuyenMuc = bientap_chuyenmuc.IDChuyenMuc
    where bientap_chuyenmuc.IDBTV = idbtv;
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Duyệt bài và xác định ngày xuất bản */
/* DROP PROCEDURE IF EXISTS DuyetBaiVaXacDinhNgayXuatBan ; 
call DuyetBaiVaXacDinhNgayXuatBan  */
delimiter //
create procedure DuyetBaiVaXacDinhNgayXuatBan (in idbtv int,in idbaiviet int, in ngayxuatban datetime)
begin 
	update baiviet set baiviet.DaDuyet = '1', baiviet.NgayDang = ngayxuatban 
    where baiviet.IDBaiViet = idbaiviet;
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Xóa bài viết */
/* DROP PROCEDURE IF EXISTS XoaBaiViet ; 
call XoaBaiViet(14) ; */
delimiter //
create procedure XoaBaiViet(in idbaiviet int)
begin 
	if exists (select * from baiviet where baiviet.IDBaiViet = idbaiviet)
    then 
		delete from baiviet where baiviet.IDBaiViet = idbaiviet;
	end if;
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Xóa chuyên mục */
/* DROP PROCEDURE IF EXISTS XoaChuyenMuc ; 
call XoaChuyenMuc('LD1') ; */
delimiter //
create procedure XoaChuyenMuc(in idchuyenmuc varchar(15))
begin 
	if exists (select * from chuyenmuc where chuyenmuc.IDChuyenMuc = idchuyenmuc)
    then 
		delete from bientap_chuyenmuc where bientap_chuyenmuc.IDChuyenMuc = idchuyenmuc;
        delete from chuyenmuc where chuyenmuc.IDChuyenMuc = idchuyenmuc;
	end if;
end //
delimiter ;

















