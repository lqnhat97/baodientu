
/* PROCEDURE Hiển thị 3 bài viết mới nhất */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietMoiNhat; */
delimiter //
create procedure HienThiBaiVietMoiNhat ()
BEGIN
	select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, baiviet.XemTruoc, baiviet.NgayDang
	from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
	where baiviet.IDBaiViet = idbaiviet
	order by baiviet.NgayDang DESC 
    limit 3;
END //
delimiter ;
call HienThiBaiVietMoiNhat ();
/*-----------------------------------*/

/* PROCEDURE Hiển thị 3 bài viết được xem nhiều nhất */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietXemNhieuNhat; */
delimiter //
create procedure HienThiBaiVietXemNhieuNhat ()
BEGIN
	select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, 
    baiviet.TieuDe, baiviet.XemTruoc, baiviet.NgayDang, baiviet.LuotXem
	from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
	where baiviet.IDBaiViet = idbaiviet
	order by baiviet.LuotXem DESC 
    limit 3;
END //
delimiter ;
call HienThiBaiVietXemNhieuNhat ();
/*-----------------------------------*/

/* PROCEDURE Hiển thị 3 bài viết nổi bật*/
/* DROP PROCEDURE IF EXISTS HienThiBaiVietNoiBat; */
delimiter //
create procedure HienThiBaiVietNoiBat()
BEGIN
	select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, baiviet.XemTruoc, baiviet.NgayDang
	from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
	where baiviet.IDBaiViet = idbaiviet and baiviet.TinNoiBat = 1
    ORDER BY RAND() LIMIT 3;
END //
delimiter ;
call HienThiBaiVietNoiBat();
/*-----------------------------------*/
/* PROCEDURE Hiển thị top 10 chuyên mục, mỗi chuyên mục 1 bài mới nhất*/
/* DROP PROCEDURE IF EXISTS HienThiTopChuyenMuc; */
delimiter //
create procedure HienThiTopChuyenMuc()
BEGIN
	select baiviet.AnhDaiDien, a.IDChuyenMuc, a.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, baiviet.NgayDang
	from baiviet , ( select  chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, max(baiviet.NgayDang) as NgayMoiNhat
					 from chuyenmuc inner join baiviet on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc
					 group by baiviet.ChuyenMuc ) as a
	where baiviet.ChuyenMuc = a.IDChuyenMuc and baiviet.NgayDang = a.NgayMoiNhat
	order by rand() limit 10;
END //
delimiter ;
call HienThiTopChuyenMuc();
/*-----------------------------------*/
/* PROCEDURE Hiển thị bài viết chi tiết */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietChiTiet; */
delimiter //
create procedure HienThiBaiVietChiTiet (in idbaiviet int)
BEGIN
	select baiviet.IDBaiViet, baiviet.AnhDaiDien, baiviet.TieuDe, baiviet.NoiDung,  count(binhluan.IDBinhLuan) as slbinhluan, nguoidung.HoTen as nguoidang, baiviet.NgayDang,
		   chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc
	from baiviet left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
				 inner join nguoidung on baiviet.phongvien = nguoidung.id
                 inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
	where baiviet.IDBaiViet = idbaiviet
    group by binhluan.IDBaiViet;
END //
delimiter ;
call HienThiBaiVietChiTiet('10');
/*-----------------------------------*/

/* PROCEDURE Hiển thị 5 bài viết cùng chuyên mục */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietCungChuyenMuc; */
delimiter //
create procedure HienThiBaiVietCungChuyenMuc (in idchuyenmuc varchar(15))
BEGIN
	select baiviet.ChuyenMuc, baiviet.idbaiviet, baiviet.AnhDaiDien, baiviet.TieuDe 
	from baiviet 
	where baiviet.ChuyenMuc = idchuyenmuc
    order by rand()
    limit 4;
END //
delimiter ;
call HienThiBaiVietCungChuyenMuc('TTA1');
/*-----------------------------------*/

/* PROCEDURE Hiển thị bình luận */
/* DROP PROCEDURE IF EXISTS HienThiBinhLuan; */
delimiter //
create procedure HienThiBinhLuan (in idbaiviet int)
BEGIN
	select baiviet.idbaiviet, binhluan.idbinhluan, nguoidung.HoTen as nguoibinhluan, binhluan.noidung, binhluan.ngaydang
	from baiviet inner join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
				 inner join nguoidung on binhluan.docgia = nguoidung.id
	where baiviet.IDBaiViet = idbaiviet;
END //
delimiter ;
call HienThiBinhLuan('2');
/*-----------------------------------*/

/* PROCEDURE Hiển thị nhãn */
/* DROP PROCEDURE IF EXISTS HienThiNhan; */
delimiter //
create procedure HienThiNhan (in idbaiviet int)
BEGIN
	select baiviet.idbaiviet, nhan.tentag
	from baiviet inner join nhan on baiviet.IDBaiViet = nhan.IDBaiViet
	where baiviet.IDBaiViet = idbaiviet;
END //
delimiter ;
call HienThiNhan('2');
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
call ThemBaiViet(null, 'Chào Hè tươi mát với trang phục họa tiết hoa quả nhiệt đới','TT1','img/song-co-y-nghia-7.jpg',
'Những họa tiết hoa quả phổ biến nhất trong thời trang Hè như họa tiết quả chanh, quả cherry hay quả dứa một lần nữa nằm trong ưu tiên hàng đầu của bạn.',
'Những họa tiết hoa quả phổ biến nhất trong thời trang Hè như họa tiết quả chanh,...','1');

/* PROCEDURE Lấy ID bài viết mới nhất */
/* DROP PROCEDURE IF EXISTS LayIDBaiVietMoi; */
delimiter //
create procedure LayIDBaiVietMoi (OUT idbaivietmoi int)
begin 
	select MAX(idbaiviet) as idbaivietmoi from baiviet;
end //
delimiter ;
call LayIDBaiVietMoi(@idbaivietmoi);
/*-----------------------------------*/

/* PROCEDURE Thêm nhãn */
/* DROP PROCEDURE IF EXISTS ThemNhan; */
delimiter //
create procedure ThemNhan (in idbaiviet int, in tentag varchar(20))
begin 
	insert nhan values (idbaiviet,tentag);
end //
delimiter ;
call ThemNhan(2,'hiendai');

/*-----------------------------------*/
/* PROCEDURE Thêm bình luận */
/* DROP PROCEDURE IF EXISTS ThemBinhLuan; */
delimiter //
create procedure ThemBinhLuan (in idbinhluan int, in idbaiviet int, in docgia int, in noidung text  CHARACTER SET utf8)
begin 
	insert binhluan(idbinhluan,idbaiviet,docgia,noidung) values (idbinhluan,idbaiviet,docgia,noidung);
end //
delimiter ;

call ThemBinhLuan(null,2,'9','Xuat sac!');



