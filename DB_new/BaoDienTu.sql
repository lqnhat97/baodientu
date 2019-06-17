/* drop database baodientu; */
create database baodientu;
use baodientu;

create table PhanHeNguoiDung
(	IDPhanHe int primary KEY auto_increment,
	TenPhanHe varchar(50) CHARACTER SET utf8  not null
	);

create table TaiKhoanThe
(	SKT varchar(15) not null primary key,
	ChuSoHuu int,
	SoDu FLOAT
	);
    
create table NguoiDung
(	ID INT  not null primary KEY auto_increment,
	UserName varchar(50) not null unique,
	MatKhau varchar(50) not null,
	HoTen varchar(50) CHARACTER SET utf8 ,
	GioiTinh varchar(10) CHARACTER SET utf8 ,
    AnhDaiDien varchar(255) not null,
	NgaySinh date,
	Email varchar(50) not null unique,
	SDT varchar(15) not null unique,
	PhanHe int,
	NgayDangKy datetime,
	NgayHetHan datetime,
	TinhTrang varchar(20)
	 );

create table ChuyenMuc #category
( IDChuyenMuc varchar(15) not null  primary KEY ,
	TenChuyenMuc varchar(50) CHARACTER SET utf8 not null ,
	ChuyenMucCha varchar(10)
	);

create table BaiViet
(	IDBaiViet INT  primary KEY auto_increment,
	TieuDe varchar(255) CHARACTER SET utf8  not null,
	ChuyenMuc varchar(10),
	NgayDang datetime default current_timestamp,
	AnhDaiDien varchar(255) not null,
	NoiDung text CHARACTER SET utf8,
	XemTruoc text CHARACTER SET utf8,
	LuotXem int default 0,
	PhongVien int,
	BienTapVien int,
	BinhLuan int default 0,
	DaDuyet int default 0,
    XuatBan int default 0,
	TinNoiBat int default 0
    );

create table Nhan #tag
(	IDBaiViet int,
	TenTag varchar(20),
    primary key(IDBaiViet,TenTag)
	);

    
create table BinhLuan
(	IDBinhLuan int auto_increment,
	IDBaiViet int not null,
	DocGia int not null,
	NoiDung text  CHARACTER SET utf8 ,
    NgayDang datetime default current_timestamp,
	TinhTrang INT default 0, # 0: an, 1 : hien thi
	primary key(IDBinhLuan,IDBaiViet,DocGia)
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

alter table BinhLuan
add constraint Fk_CMT_BV
foreign key (IDBaiViet)
references BaiViet(IDBaiViet);

alter table BinhLuan
add constraint Fk_CMT_DocGia
foreign key (DocGia)
references NguoiDung(ID);

alter table Nhan
add constraint Fk_Tag_BV
foreign key (IDBaiViet)
references BaiViet(IDBaiViet);
