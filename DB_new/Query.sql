
/* PROCEDURE Hiển thị 3 bài viết mới nhất */
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
    limit 10;
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
    limit 10;
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
/* PROCEDURE Hiển thị bài viết chi tiết */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietChiTiet;
call HienThiBaiVietChiTiet('1'); */
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
/* DROP PROCEDURE IF EXISTS ThemBaiViet; */
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
call ThemNhan(2,'Phi tang xác'); */
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






