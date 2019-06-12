
/* PROCEDURE HienThiBaiVietTrangChu */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietTrangChu; */
delimiter //
create procedure HienThiBaiVietTrangChu (IN idbaiviet int)
BEGIN
	select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, baiviet.XemTruoc
	from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
	where baiviet.IDBaiViet = idbaiviet;
END //
delimiter ;
call HienThiBaiVietTrangChu ('1');
/*-----------------------------------*/
/* PROCEDURE HienThiBaiVietChiTiet */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietChiTiet; */
delimiter //
create procedure HienThiBaiVietChiTiet (in idbaiviet int)
BEGIN
	select baiviet.IDBaiViet, baiviet.AnhDaiDien, baiviet.TieuDe, baiviet.NoiDung, count(binhluan.IDBinhLuan) as slbinhluan, nguoidung.HoTen as nguoidang
	from baiviet inner join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
				 inner join nguoidung on baiviet.phongvien = nguoidung.id
	where baiviet.IDBaiViet = idbaiviet
    group by binhluan.IDBaiViet;
END //
delimiter ;
call HienThiBaiVietChiTiet('2');
/*-----------------------------------*/
/* PROCEDURE HienThiBinhLuan */
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
/* PROCEDURE HienThiNhan */
/* DROP PROCEDURE IF EXISTS HienThiNhan; */
delimiter //
create procedure HienThiNhan (in idbaiviet int)
BEGIN
	select baiviet.idbaiviet, nhan.idtag, nhan.tentag
	from baiviet inner join nhan on baiviet.IDBaiViet = nhan.IDBaiViet
	where baiviet.IDBaiViet = idbaiviet;
END //
delimiter ;
call HienThiNhan('2');
/*-----------------------------------*/
/* PROCEDURE ThemBaiViet; */
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
call ThemBaiViet(null, '9 cách tận hưởng cuộc sống theo cách thực sự ý nghĩa','TS1','img/song-co-y-nghia-7.jpg',
'Cuộc sống của mỗi người chúng ta giống như một chuyến đi dài vô tận không có bản đồ',
'Cuộc sống của mỗi người chúng ta giống như một...','4');
call ThemBaiViet(null, '8 điểm đến gần Hà Nội và dễ đi trong dịp 30/4','DL1','img/song-co-y-nghia-7.jpg',
'Chỉ mất từ một tới hai tiếng chạy xe, du khách có thể chọn cho mình những chuyến picnic ngắn ngày, hòa mình cùng thiên nhiên trong dịp nghỉ lễ.chọn cho mình những chuyến picnic ngắn ngày, hòa mình cùng thiên nhiên trong dịp nghỉ lễ.',
'Chỉ mất từ một tới hai tiếng chạy xe, du khách có thể...','6');

/*-----------------------------------*/
/* PROCEDURE LayIDBaiVietMoi */
/* DROP PROCEDURE IF EXISTS LayIDBaiVietMoi; */
delimiter //
create procedure LayIDBaiVietMoi (OUT idbaivietmoi int)
begin 
	select MAX(idbaiviet) as idbaivietmoi from baiviet;
end //
delimiter ;
call LayIDBaiVietMoi(@idbaivietmoi);

/*-----------------------------------*/
/* PROCEDURE ThemNhan */
/* DROP PROCEDURE IF EXISTS ThemNhan; */
delimiter //
create procedure ThemNhan (in idtag int, in idbaiviet int, in tentag varchar(20))
begin 
	insert nhan values (idtag,idbaiviet,tentag);
end //
delimiter ;
call ThemNhan(null,2,'hiendai');
call ThemNhan(null,2,'phongcachsong');


/*-----------------------------------*/
/* PROCEDURE ThemBinhLuan */
/* DROP PROCEDURE IF EXISTS ThemBinhLuan; */
delimiter //
create procedure ThemBinhLuan (in idbinhluan int, in idbaiviet int, in docgia int, in noidung text  CHARACTER SET utf8)
begin 
	insert binhluan(idbinhluan,idbaiviet,docgia,noidung) values (idbinhluan,idbaiviet,docgia,noidung);
end //
delimiter ;
call ThemBinhLuan(null,2,'10','Bai nay hay vl');
call ThemBinhLuan(null,2,'10','Cam on!');



