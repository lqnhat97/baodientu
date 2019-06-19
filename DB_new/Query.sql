
/* PROCEDURE Hiển thị 4 bài viết mới nhất */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietMoiNhat; 
call HienThiBaiVietMoiNhat (11); */
delimiter //
create procedure HienThiBaiVietMoiNhat (in iddangnhap int)
BEGIN
	if exists (select * from nguoidung where nguoidung.id = iddangnhap and nguoidung.NgayHetHan >= now())
    then 
		select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc,baiviet.IDBaiViet, baiviet.TieuDe, 
        baiviet.XemTruoc, baiviet.LuotXem, baiviet.NgayDang, count(binhluan.IDBinhLuan) as slbinhluan, baiviet.premium
		from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
				left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
		where baiviet.XuatBan = 1 
		group by baiviet.idbaiviet
		order by baiviet.premium DESC,baiviet.NgayDang DESC 
		limit 4;
	else 
		select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc,baiviet.IDBaiViet, baiviet.TieuDe, 
        baiviet.XemTruoc, baiviet.LuotXem, baiviet.NgayDang, count(binhluan.IDBinhLuan) as slbinhluan, baiviet.premium
		from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
				left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
		where baiviet.XuatBan = 1
		group by baiviet.idbaiviet
		order by baiviet.NgayDang DESC 
		limit 4;
    end if;
END //
delimiter ;

/*-----------------------------------*/

/* PROCEDURE Hiển thị 3 bài viết được xem nhiều nhất */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietXemNhieuNhat; 
call HienThiBaiVietXemNhieuNhat (); */
delimiter //
create procedure HienThiBaiVietXemNhieuNhat (in iddangnhap int)
BEGIN
	if exists (select * from nguoidung where nguoidung.id = iddangnhap and nguoidung.NgayHetHan >= now())
    then 
		select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, 
        baiviet.XemTruoc, baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.premium
		from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
			left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
		where baiviet.XuatBan = 1
		group by baiviet.idbaiviet
		order by baiviet.premium desc, baiviet.LuotXem DESC 
		limit 10;
	else 
		select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe,
        baiviet.XemTruoc, baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.premium
		from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
			left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
		where baiviet.XuatBan = 1 
		group by baiviet.idbaiviet
		order by baiviet.LuotXem DESC 
		limit 10;
	end if;
END //
delimiter ;
/*-----------------------------------*/
/* PROCEDURE Hiển thị 4 bài viết nổi bật*/
/* DROP PROCEDURE IF EXISTS HienThiBaiVietNoiBat;
call HienThiBaiVietNoiBat(); */
delimiter //
create procedure HienThiBaiVietNoiBat(in iddangnhap int)
BEGIN
	if exists (select * from nguoidung where nguoidung.id = iddangnhap and nguoidung.NgayHetHan >= now())
    then
		select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, 
        baiviet.XemTruoc, baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.premium
		from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
				left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
		where baiviet.TinNoiBat = 1 and baiviet.XuatBan = 1
		group by baiviet.idbaiviet
		ORDER BY baiviet.premium desc,RAND() LIMIT 4;
	else 
		select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe,
        baiviet.XemTruoc, baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.premium
		from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
				left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
		where baiviet.TinNoiBat = 1 and baiviet.XuatBan = 1 
		group by baiviet.idbaiviet
		ORDER BY RAND() LIMIT 4;
        end if;
END //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Hiển thị top 10 chuyên mục, mỗi chuyên mục 1 bài mới nhất*/
/* DROP PROCEDURE IF EXISTS HienThiTopChuyenMuc; 
call HienThiTopChuyenMuc(); */
delimiter //
create procedure HienThiTopChuyenMuc(in iddangnhap int)
BEGIN
	if exists (select * from nguoidung where nguoidung.id = iddangnhap and nguoidung.NgayHetHan >= now())
    then
		select baiviet.AnhDaiDien, a.IDChuyenMuc, a.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, baiviet.NgayDang, baiviet.LuotXem,  
        count(binhluan.IDBinhLuan) as slbinhluan, baiviet.premium
		from baiviet left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet,( select  chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, max(baiviet.NgayDang) as NgayMoiNhat
						from chuyenmuc inner join baiviet on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc
						group by baiviet.ChuyenMuc ) as a
		where baiviet.ChuyenMuc = a.IDChuyenMuc and baiviet.NgayDang = a.NgayMoiNhat and baiviet.XuatBan = 1
		group by baiviet.idbaiviet
		order by baiviet.premium desc,rand() limit 9;
	else 
		select baiviet.AnhDaiDien, a.IDChuyenMuc, a.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, baiviet.NgayDang, 
        baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.premium
		from baiviet left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet,( select  chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, max(baiviet.NgayDang) as NgayMoiNhat
						from chuyenmuc inner join baiviet on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc
						group by baiviet.ChuyenMuc ) as a
		where baiviet.ChuyenMuc = a.IDChuyenMuc and baiviet.NgayDang = a.NgayMoiNhat and baiviet.XuatBan = 1 
		group by baiviet.idbaiviet
		order by rand() limit 9;
	end if;
END //
delimiter ;
/*-----------------------------------*/
/* PROCEDURE Hiển thị bài viết theo chuyên mục*/
/* DROP PROCEDURE IF EXISTS HienThiBaiVietChuyenMuc; 
call HienThiBaiVietChuyenMuc(); */
delimiter //
create procedure HienThiBaiVietChuyenMuc(in iddangnhap int,in idchuyenmuc varchar(20), in lim int, in os int)
BEGIN
	if exists (select * from nguoidung where nguoidung.id = iddangnhap and nguoidung.NgayHetHan >= now())
    then
		select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, 
        baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.XemTruoc, baiviet.premium
		from baiviet inner join chuyenmuc on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc
				left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet 
		where baiviet.ChuyenMuc = idchuyenmuc and baiviet.XuatBan = 1
		group by baiviet.idbaiviet
		order by baiviet.premium desc, baiviet.NgayDang desc
		limit lim offset os;
	else 
		select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, 
        baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.XemTruoc, baiviet.premium
		from baiviet inner join chuyenmuc on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc
				left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet 
		where baiviet.ChuyenMuc = idchuyenmuc and baiviet.XuatBan = 1 
		group by baiviet.idbaiviet
		order by baiviet.NgayDang desc
		limit lim offset os;
    end if;
END //
delimiter ;
/*-----------------------------------*/
/* PROCEDURE Hiển thị bài viết theo nhãn*/
/* DROP PROCEDURE IF EXISTS HienThiBaiVietTheoNhan; 
call HienThiBaiVietTheoNhan('Phi tang xác',2,0); */
delimiter //
create procedure HienThiBaiVietTheoNhan(in iddangnhap int,in tentag varchar(20), in lim int, in os int)
BEGIN
	if exists (select * from nguoidung where nguoidung.id = iddangnhap and nguoidung.NgayHetHan >= now())
	then
		select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, 
        baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.XemTruoc, baiviet.premium
		from baiviet inner join chuyenmuc on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc
				left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet 
				left join nhan on baiviet.IDBaiViet = nhan.IDBaiViet
		where nhan.TenTag = tentag and baiviet.XuatBan = 1
		group by baiviet.idbaiviet
		order by baiviet.premium desc, baiviet.NgayDang desc
		limit lim offset os;
	else 
		select baiviet.AnhDaiDien, chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc, baiviet.IDBaiViet, baiviet.TieuDe, 
        baiviet.NgayDang, baiviet.LuotXem,  count(binhluan.IDBinhLuan) as slbinhluan, baiviet.XemTruoc, baiviet.premium
		from baiviet inner join chuyenmuc on chuyenmuc.IDChuyenMuc = baiviet.ChuyenMuc
				left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet 
				left join nhan on baiviet.IDBaiViet = nhan.IDBaiViet
		where nhan.TenTag = tentag and baiviet.XuatBan = 1 
		group by baiviet.idbaiviet
		order by baiviet.NgayDang desc
		limit lim offset os;
    end if;
END //
delimiter ;
/*-----------------------------------*/

/* PROCEDURE Hiển thị bài viết chi tiết */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietChiTiet;
call HienThiBaiVietChiTiet(iddangnhap,idbaiviet); */
delimiter //
create procedure HienThiBaiVietChiTiet (in iddangnhap int,in idbaiviet int)
BEGIN
	if exists (select * from nguoidung where nguoidung.id = iddangnhap and nguoidung.NgayHetHan >= now())
	then
		select baiviet.IDBaiViet, baiviet.AnhDaiDien, baiviet.TieuDe, baiviet.NoiDung,  count(binhluan.IDBinhLuan) as slbinhluan, nguoidung.HoTen as nguoidang, baiviet.NgayDang,
		chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc
		from baiviet left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
				 inner join nguoidung on baiviet.phongvien = nguoidung.id
                 inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
		where baiviet.IDBaiViet = idbaiviet and baiviet.XuatBan = 1
		group by binhluan.IDBaiViet;
	else 
		select baiviet.IDBaiViet, baiviet.AnhDaiDien, baiviet.TieuDe, baiviet.NoiDung,  count(binhluan.IDBinhLuan) as slbinhluan, nguoidung.HoTen as nguoidang, baiviet.NgayDang,
		chuyenmuc.IDChuyenMuc, chuyenmuc.TenChuyenMuc
		from baiviet left join binhluan on baiviet.IDBaiViet = binhluan.IDBaiViet
				 inner join nguoidung on baiviet.phongvien = nguoidung.id
                 inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
		where baiviet.IDBaiViet = idbaiviet and baiviet.XuatBan = 1 and baiviet.premium = 0
		group by binhluan.IDBaiViet;
    end if;
END //
delimiter ;
/*-----------------------------------*/

/* PROCEDURE Hiển thị 5 bài viết cùng chuyên mục */
/* DROP PROCEDURE IF EXISTS HienThiBaiVietCungChuyenMuc; 
call HienThiBaiVietCungChuyenMuc('TTA1'); */
delimiter //
create procedure HienThiBaiVietCungChuyenMuc (in iddangnhap int,in idchuyenmuc varchar(15))
BEGIN
	if exists (select * from nguoidung where nguoidung.id = iddangnhap and nguoidung.NgayHetHan >= now())
	then
		select baiviet.ChuyenMuc, baiviet.idbaiviet, baiviet.AnhDaiDien, baiviet.TieuDe, baiviet.NgayDang
		from baiviet 
		where baiviet.ChuyenMuc = idchuyenmuc and baiviet.XuatBan = 1
		order by baiviet.premium desc, rand() limit 4;
	else
        select baiviet.ChuyenMuc, baiviet.idbaiviet, baiviet.AnhDaiDien, baiviet.TieuDe, baiviet.NgayDang
		from baiviet 
		where baiviet.ChuyenMuc = idchuyenmuc and baiviet.XuatBan = 1 
		order by rand() limit 4;
    end if;    
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

/* PROCEDURE Sửa bài viết */
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

/* PROCEDURE Sửa chuyên mục */
/* DROP PROCEDURE IF EXISTS SuaChuyenMuc ; 
call SuaChuyenMuc('TS1','Tâm sự và cuộc sống','DS1') ; */
delimiter //
create procedure SuaChuyenMuc(in idchuyenmuc varchar(15), in tenchuyenmuc varchar(50) charset utf8, in chuyenmuccha varchar(15) )
begin 
	if exists (select * from chuyenmuc where chuyenmuc.IDChuyenMuc = idchuyenmuc)
    then 
		update chuyenmuc set chuyenmuc.TenChuyenMuc = tenchuyenmuc, chuyenmuc.ChuyenMucCha = chuyenmuccha
        where chuyenmuc.IDChuyenMuc = idchuyenmuc;
	end if;
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

/* PROCEDURE Xóa  nhãn  theo ten*/
/* DROP PROCEDURE IF EXISTS XoaNhanTheoTen; 
call XoaNhan('15'); */
delimiter //
create procedure XoaNhanTheoTen(in nhan varchar(20) charset utf8)
begin 
	if exists (select * from nhan where nhan.TenTag = nhan)
    then 
		delete from nhan where nhan.TenTag = nhan;
	end if;
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

/*-----------------------------------*/
/* PROCEDURE Xem danh sách bài viết  trong chuyên mục do mình quản lý */
/* DROP PROCEDURE IF EXISTS XemBaiVietDoMinhQuanLy; 
call XemBaiVietDoMinhQuanLy(6); */
delimiter //
create procedure XemBaiVietDoMinhQuanLy(in idbtv int)
begin 
	select baiviet.IDBaiViet,baiviet.TieuDe, chuyenmuc.TenChuyenMuc, baiviet.NgayViet, nguoidung.HoTen as PhongVien
    from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
    inner join bientap_chuyenmuc on chuyenmuc.IDChuyenMuc = bientap_chuyenmuc.IDChuyenMuc
    inner join nguoidung on baiviet.PhongVien = nguoidung.ID
    where bientap_chuyenmuc.IDBTV = idbtv and baiviet.DaDuyet=0 and baiviet.XuatBan = 0;
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Xem danh sách bài viết  trong chuyên mục do mình quản lý đã xử lý */
/* DROP PROCEDURE IF EXISTS XemBaiVietDoMinhDaXuLy; 
call XemBaiVietDoMinhDaXuLy(6); */
delimiter //
create procedure XemBaiVietDoMinhDaXuLy(in idbtv int)
begin 
	select baiviet.IDBaiViet,baiviet.TieuDe, chuyenmuc.TenChuyenMuc, baiviet.NgayViet, nguoidung.HoTen as PhongVien,baiViet.NgayDang,baiviet.DaDuyet,baiviet.XuatBan
    from baiviet inner join chuyenmuc on baiviet.ChuyenMuc = chuyenmuc.IDChuyenMuc
    inner join bientap_chuyenmuc on chuyenmuc.IDChuyenMuc = bientap_chuyenmuc.IDChuyenMuc
    inner join nguoidung on baiviet.PhongVien = nguoidung.ID
    where bientap_chuyenmuc.IDBTV = idbtv and baiviet.DaDuyet!=0;
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Duyệt bài và xác định ngày xuất bản */
/* DROP PROCEDURE IF EXISTS DuyetBaiVaXacDinhNgayXuatBan ; 
call DuyetBaiVaXacDinhNgayXuatBan (6,2,'07-07-2019 01:00:00')  */
delimiter //
create procedure DuyetBaiVaXacDinhNgayXuatBan (in idbtv int,in idbaiviet int, in ngayxuatban datetime)
begin 
	update baiviet set baiviet.DaDuyet = '1', baiviet.NgayDang = ngayxuatban 
    where baiviet.IDBaiViet = idbaiviet;
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Thêm người dùng */
/* DROP PROCEDURE IF EXISTS ThemNguoiDung ; 
call ThemNguoiDung('abc','abc','abc','abc','abc','1997-06-10','abc','abc');  */
delimiter //
create procedure ThemNguoiDung (in username varchar(50), in matkhau varchar(50), in hoten varchar(50) CHARACTER SET utf8, in gioitinh varchar(10) CHARACTER SET utf8,
								in anhdaidien varchar(255), in ngaysinh datetime , in email varchar(50), in sdt varchar(15) )
begin 
	insert nguoidung values (null,username,matkhau,hoten,gioitinh,anhdaidien,ngaysinh,email,sdt,1,curdate(),null);
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Xóa người dùng */
/* DROP PROCEDURE IF EXISTS XoaNguoiDung ; 
call XoaNguoiDung(9);  */
delimiter //
create procedure XoaNguoiDung (in idnguoidung int )
begin 
	delete from nguoidung where nguoidung.id = idnguoidung;
end //
delimiter ;

/*-----------------------------------*/
/* PROCEDURE Sửa người dùng */
/* DROP PROCEDURE IF EXISTS SuaNguoiDung ; 
call SuaNguoiDung();  */
create procedure SuaNguoiDung (in idnguoidung int, in username varchar(50), in matkhau varchar(50), in hoten varchar(50) CHARACTER SET utf8, in gioitinh varchar(10) CHARACTER SET utf8,
								in anhdaidien varchar(255), in ngaysinh datetime , in email varchar(50), in sdt varchar(15), in phanhe int )
begin 
	update nguoidung set nguoidung.username = username,nguoidung.matkhau = matkhau, nguoidung.hoten = hoten ,nguoidung.gioitinh = gioitinh,
    nguoidung.anhdaidien = anhdaidien,nguoidung.ngaysinh = ngaysinh, nguoidung.email,nguoidung.sdt = sdt, nguoidung.phanhe = phanhe
    where nguoidung.id = idnguoidung
end //
delimiter ;

/* PROCEDURE Gia hạn cho độc giả */
/* DROP PROCEDURE IF EXISTS GiaHanDocGia ; 
call GiaHanDocGia(10,'2019-06-21');  */
delimiter //
create procedure GiaHanDocGia(in iddocgia int, in ngaygiahan date )
begin
	update nguoidung set nguoidung.NgayHetHan = ngaygiahan
    where nguoidung.ID = iddocgia;
end //
delimiter ;

/* PROCEDURE Phân công chuyên mục cho biên tập viên */
/* DROP PROCEDURE IF EXISTS PhanCongChuyenMuc ; 
call PhanCongChuyenMuc(7,'TH1');  */
delimiter //
create procedure PhanCongChuyenMuc(in idbtv int, in idchuyenmuc varchar(15) )
begin
	insert bientap_chuyenmuc values  (idbtv, idchuyenmuc);
end //
delimiter ;










