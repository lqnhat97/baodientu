drop database baodientu;create database baodientu;use baodientu;

create table PhanHeNguoiDung
(	IDPhanHe varchar(10) not null primary key,
	TenPhanHe varchar(50) not null
	);

create table TaiKhoanThe
(	SKT varchar(15) not null primary key,
	ChuSoHuu int,
	SoDu FLOAT
	);
create table NguoiDung
( ID INT  not null primary KEY auto_increment,
	UserName varchar(50) not null unique,
	MatKhau varchar(50) not null,
	HoTen varchar(50) CHARACTER SET utf8 ,
	GioiTinh varchar(10) CHARACTER SET utf8 ,
	NgaySinh date,
	Email varchar(50) not null unique,
	SDT varchar(15) not null unique,
	PhanHe varchar(10),
	TKThe varchar(15) ,
	NgayDangKy datetime,
	NgayHetHan datetime,
	TinhTrang varchar(20)
	 );
ALTER TABLE nguoidung CHANGE matkhau password  varchar(50);
alter table nguoidung drop column TKThe;


create table ChuyenMuc #category
( IDChuyenMuc varchar(10) not null primary key,
	TenChuyenMuc varchar(50) CHARACTER SET utf8 not null ,
	TenChuyenMuc_KhongDau varchar(50),
	ChuyenMucCha varchar(10)
	);

create table Nhan #tag
( IDTag varchar(10) not null primary key,
  TenTag varchar(20) not null
  );

create table BaiViet
( IDBaiViet varchar(15) not null primary key,
  TieuDe varchar(255) CHARACTER SET utf8  not null,
  TieuDe_KhongDau varchar(255),
  ChuyenMuc varchar(10) CHARACTER SET utf8 ,
  NgayDang datetime,
  AnhDaiDien int,
  NoiDung text CHARACTER SET utf8 ,
  LuotXem int,
  PhongVien int,
  BienTapVien int,
  DaDuyet int,
  TinNoiBat int
  );

create table urlHinhAnh
( IDHinh INT  primary KEY auto_increment,
  urllinkHinh VARCHAR(255) not null UNIQUE
  );

create table BinhLuan
( IDBinhLuan int auto_increment,
  BaiViet varchar(15) not null,
  DocGia int not null,
  NoiDung text  CHARACTER SET utf8 ,
  TinhTrang INT, # 1 : an, 0 : hien thi
   primary key(IDBinhLuan,BaiViet,DocGia)
   );
  
create table Nhan_BaiViet
(  IDBaiViet varchar(15) not null,
	IDTag varchar(10) not null,
	primary key(IDBaiViet,IDTag)
	);

create table BaiViet_HinhAnh
( IDBaiViet varchar(15),
  IDHinh int,
  primary key(IDBaiViet,IDHinh)
  );

----------------------------	KHOA NGOAI	

alter table ChuyenMuc
add constraint Fk_CM_CM	
foreign key (ChuyenMucCha)
references ChuyenMuc(IDChuyenMuc);

alter table NguoiDung
add constraint Fk_user_PH	
foreign key (PhanHe)
references PhanHeNguoiDung(IDPhanHe);

alter table TaiKhoanThe
add constraint Fk_The_user
foreign key (ChuSoHuu)
references NguoiDung(ID);

alter table BaiViet
add constraint Fk_BV_PV
foreign key (PhongVien)
references NguoiDung(ID);

alter table BaiViet
add constraint Fk_BV_BTV
foreign key (BienTapVien)
references NguoiDung(ID);

alter table BaiViet
add constraint Fk_BV_CM
foreign key (ChuyenMuc)
references ChuyenMuc(IDChuyenMuc);

alter table Nhan_BaiViet
add constraint Fk_BV_Nhan
foreign key (IDBaiViet)
references BaiViet(IDBaiViet);

alter table Nhan_BaiViet
add constraint Fk_Nhan
foreign key (IDTag)
references Nhan(IDTag);

alter table BaiViet_HinhAnh
add constraint Fk_BV
foreign key (IDBaiViet)
references BaiViet(IDBaiViet);

alter table BaiViet_HinhAnh
add constraint Fk_image
foreign key (IDHinh)
references urlHinhAnh(IDHinh);

alter table BinhLuan
add constraint Fk_CMT_BV
foreign key (BaiViet)
references BaiViet(IDBaiViet);

alter table BinhLuan
add constraint Fk_CMT_DocGia
foreign key (DocGia)
references NguoiDung(ID);

--------- THEM DU LIEU

insert phanhenguoidung values ('PV001','Phong Vien');
insert phanhenguoidung values ('BTV001','Bien Tap Vien');

insert nguoidung values (null,'lequangnhat','nhat123',' Le Quang Nhat', 'Nam', '1997-08-29', 'lqnhat@gmail.com', '0926803468', 'PV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
update nguoidung set Username="hoanganhtuan", password="tuan123", HoTen="Hoang Anh Tuan", Email="hatuan@gmail.com" where ID = 2;
insert nguoidung values (null,'vulamanh','anh123','Vu Lam Anh', 'Nu', '1995-05-25', 'lamanhpv@gmail.com', '0977713558', 'PV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'nguyenanhthi','thi123','Nguyen Anh Thi', 'Nu', '1996-02-05', 'thithi@gmail.com', '0355688828', 'PV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'trandonghoa','hoa123','Tran Dong Hoa', 'Nam', '1992-04-13', 'donghoatran@gmail.com', '0898981597', 'BTV001', '2019-05-10', '2024-05-10', 'Hoat Dong');


insert chuyenmuc values ('TT001',N'Thời trang','Thoi trang',null);
insert chuyenmuc values ('TS001',N'Tâm sự và cuộc sống','Tam su va cuoc song',null);
insert chuyenmuc values('DL001',N'Du lịch','Du lich',null);
insert chuyenmuc values('TTA001',N'Thể thao','The thao',null);
insert chuyenmuc values('SK001',N'Sức khỏe','Suc khoe',null);

insert urlhinhanh values (null,'https://www.elle.vn/wp-content/uploads/2019/01/19/elle-viet-nam-trang-phuc-tet-3.jpg');
insert urlhinhanh values (null,'https://st.quantrimang.com/photos/image/2017/08/31/song-co-y-nghia-7.jpg');

insert baiviet values ('BV001',N'9 cách tận hưởng cuộc sống theo cách thực sự ý nghĩa','9 cach tan huong cuoc song theo cach thuc su y nghia','TS001','2019-05-10','2','Cuộc sống của mỗi người chúng ta giống như một chuyến đi dài vô tận không có bản đồ. Trong hành trình cuộc đời, bạn phải dừng chân tại nhiều nơi khác nhau, đổi hướng đi tới những con đường chưa hề biết đến. Thường xuyên thay đổi định hướng và có đôi khi bạn dường như bị lạc, mặc dù bạn ghét phải thừa nhận điều này.
Tuy nhiên, thật đáng buồn rằng có một số người kiên quyết mang theo bản đồ cho riêng mình để đảm bảo rằng bản thân luôn chắc chắn mọi điều. Tất cả các con đường đều có sẵn trên bản đồ và họ sẽ không bao giờ bị lạc.
Nếu cuộc sống đơn giản chỉ là tồn tại thì nó giống như một chiếc máy bay điều khiển tự động, với đôi mắt mở to nhưng không nhìn thấy gì cả, cũng không thực sự cảm thấy hoặc trải nghiệm được gì. Bạn cứ bước đi hết bước này đến bước khác theo một hướng duy nhất. Không có cảm xúc, không có thách thức và chắc chắn không có được niềm vui nếu chỉ đơn giản lặp đi lặp lại một công việc mà bạn làm hàng ngày, trong khi mong đợi một điều gì khác.
Trừ khi bạn cảm thấy sâu thẳm bên trong mình rằng cuộc sống không có nghĩa là như vậy thì có nhiều điều hơn thế mà bạn cần phải thay đổi. Là một người yêu thích sự thay đổi, tác giả của bài viết đã rút ra một số việc cần phải làm để cuộc sống trở nên thực sự ý nghĩa và từ đó bạn có thể bắt đầu yêu từng khoảng khắc trong cuộc sống của mình lại một lần nữa. Mời các bạn cùng tham khảo 9 cách tận hưởng cuộc sống theo cách thực sự ý nghĩa!', '2', '1','2','1','1');
update baiviet set AnhDaiDien=3 where ChuyenMuc='TS001';

insert baiviet values ('BV002',N'Chào Hè tươi mát với trang phục họa tiết hoa quả nhiệt đới','Chao he tuoi mat voi trang phuc hoa qua nhiet doi','TT001','2019-05-10','1','Những họa tiết hoa quả phổ biến nhất trong thời trang Hè như họa tiết quả chanh, quả cherry hay quả dứa một lần nữa nằm trong ưu tiên hàng đầu của bạn.
Họa tiết hoa quả không thể thiếu khi nhắc đến thời trang mùa Hè. Hình ảnh vui nhộn và bảng màu bắt mắt xua đi cái nóng oi ả, đưa bạn đến với vùng biển đầy nắng gió hay khu vườn trái cây nhiệt đới sai quả.
HỌA TIẾT TRÁI CHANH
Đây là một trong những họa tiết hoa quả được nhiều fashionista yêu thích nhất. Với sắc vàng tươi tắn làm chủ đạo, trang phục mang họa tiết của loại trái mọng nước này rất phù hợp để diện vào buổi dạo phố ngày Hè hay chuyến du lịch biển.
HỌA TIẾT CHERRY
Những trái cherry đỏ lịm thu hút ánh nhìn người đối diện. Bạn có thể diện trang phục cherry cùng những phụ kiện cùng tông để tạo tổng thể hài hòa. Từ áo sơmi, áo blouse đến những chiếc đầm quấn dịu dàng, thời trang mùa Hè của bạn trở nên ấn tượng hơn nhờ loại quả “ngon mắt” này.
HỌA TIẾT QUẢ DỨA
Họa tiết quả dứa giúp vẻ ngoài của bạn thêm nổi bật và trẻ trung hơn. Vì loại quả này có hình vẽ hơi phức tạp, bạn nên ưu tiên kết hợp cùng những món đồ đơn giản hoặc chọn họa tiết nhỏ để trang phục không bị rối mắt.', '4', '5','6','1','1');