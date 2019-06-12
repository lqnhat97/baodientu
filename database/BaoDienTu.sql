/* drop database baodientu; */
create database baodientu;
use baodientu;

create table PhanHeNguoiDung
(	IDPhanHe int primary KEY auto_increment,
	TenPhanHe varchar(50) not null
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
	TenChuyenMuc_KhongDau varchar(50),
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
	TinNoiBat int default 0
    );

create table Nhan #tag
(	IDTag INT auto_increment,
	IDBaiViet int not null,
	TenTag varchar(20) not null,
    primary key(IDTag, IDBaiViet)
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
--------- THEM DU LIEU

insert phanhenguoidung values (null,'Phong Vien');
insert phanhenguoidung values (null,'Bien Tap Vien');
insert phanhenguoidung values (null,'Admin');
insert phanhenguoidung values (null,'Doc Gia');
insert phanhenguoidung values (null,'Doc Gia Vang Lai');

insert nguoidung values (null,'lequangnhat','nhat123',' Le Quang Nhat', 'Nam','img/nguoidung.jpg', '1997-08-29', 'lqnhat@gmail.com', '0926803468', '1', '2019-05-06', '2024-05-06', 'Hoat Dong');
insert nguoidung values (null,'hoanganhtuan','tuan123','Hoang Anh Tuan', 'Nam','img/nguoidung.jpg', '1995-10-17', 'hatuan@gmail.com', '0981828596', '2', '2019-05-05', '2024-05-05', 'Hoat Dong');
insert nguoidung values (null,'vulamanh','anh123','Vu Lam Anh', 'Nu','img/nguoidung.jpg', '1995-05-25', 'lamanhpv@gmail.com', '0977713558', '1', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'nguyenanhthi','thi123','Nguyen Anh Thi', 'Nu','img/nguoidung.jpg', '1996-02-05', 'thithi@gmail.com', '0355688828', '1', '2019-05-15', '2024-05-15', 'Hoat Dong');
insert nguoidung values (null,'trandonghoa','hoa123','Tran Dong Hoa', 'Nam','img/nguoidung.jpg', '1992-04-13', 'donghoatran@gmail.com', '0898981597', '2', '2019-05-21', '2024-05-21', 'Hoat Dong');
insert nguoidung values (null,'hoanglean','an123','Hoang Le An', 'Nam','img/nguoidung.jpg', '1991-07-09', 'anlehoang@gmail.com', '0979845461', '1', '2019-06-02', '2024-06-02', 'Hoat Dong');
insert nguoidung values (null,'dangthienminh','minh123','Dang Thien Minh', 'Nam','img/nguoidung.jpg', '1997-06-14', 'dtminh@gmail.com', '0762412871', '1', '2019-05-03', '2024-05-03', 'Hoat Dong');
insert nguoidung values (null,'phanthimyduyen','duyen123','Phan Thi My Duyen', 'Nu','img/nguoidung.jpg', '1995-02-22', 'duyenphan@gmail.com', '0963512841', '2', '2019-06-09', '2024-06-09', 'Hoat Dong');
insert nguoidung values (null,'tranhaonam','nam321','Tran Hao Nam', 'Nam','img/nguoidung.jpg', '1997-08-12', 'thnam@gmail.com', '0754125746', '4', '2019-06-05', '2024-06-05', 'Hoat Dong');
insert nguoidung values (null,'nguyenthuynhien','nhien123','Nguyen Thuy Nhien', 'Nu','img/nguoidung.jpg', '1997-04-16', 'ntnhien@gmail.com', '092510741', '4', '2019-05-24', '2024-05-24', 'Hoat Dong');

insert chuyenmuc values ('GT1',N'Giải trí','Giai tri', null);
insert chuyenmuc values ('DS1',N'Đời sống','Doi song', null);
insert chuyenmuc values ('TT1',N'Thời trang','Thoi trang','GT1');
insert chuyenmuc values ('TH1',N'Truyền hình','Truyen hinh','GT1');
insert chuyenmuc values ('AN1',N'Âm nhạc','Am nhac','GT1');
insert chuyenmuc values ('TS1',N'Tâm sự','Tam su','DS1');
insert chuyenmuc values ('DL1',N'Du lịch','Du lich','DS1');
insert chuyenmuc values ('TTA1',N'Thể thao','The thao',null);
insert chuyenmuc values ('SK1',N'Sức khỏe','Suc khoe',null);
insert chuyenmuc values ('CN1',N'Công nghệ','Cong nghe',null);
insert chuyenmuc values ('GD1',N'Gia đình','Gia dinh','DS1');
insert chuyenmuc values ('KD1',N'Kinh doanh','Kinh doanh',null);
insert chuyenmuc values ('BDS1',N'Bất động sản','Bat dong san',null);
insert chuyenmuc values ('PL1',N'Pháp luật','Phap luat',null);

/*
insert urlhinhanh values (null,'https://www.elle.vn/wp-content/uploads/2019/01/19/elle-viet-nam-trang-phuc-tet-3.jpg');
insert urlhinhanh values (null,'https://st.quantrimang.com/photos/image/2017/08/31/song-co-y-nghia-7.jpg');
insert urlhinhanh values (null,'https://toquoc.mediacdn.vn/2019/5/28/55680190819212708456033345622057033138176n-1553665256897912346264-15572998912451218198859-1559062386415263211674.jpg');
insert urlhinhanh values (null,'https://i-dulich.vnecdn.net/2019/04/19/di-choi-gan-ha-noi-30-4-vnexpress-2019-2_r_680x0.jpg');
insert urlhinhanh values (null,'https://vnn-imgs-f.vgcloud.vn/2019/06/10/17/cham-con-toi-ngay-nhieu-me-viet-van-bo-quen-de-khang-da-360x240.jpg');
insert urlhinhanh values (null,'https://vnn-imgs-f.vgcloud.vn/2019/06/11/09/cong-ty-my-yeu-cau-doi-tac-chau-au-tay-chay-huawei-1-360x240.jpg');
insert urlhinhanh values (null,'https://vnn-imgs-f.vgcloud.vn/2019/06/09/14/sam-len-tieng-truoc-tin-don-bi-mat-hen-ho-voi-jun-pham-240x160.jpg');
insert urlhinhanh values (null,'https://vnn-imgs-f.vgcloud.vn/2019/06/10/10/thanh-ha-truc-trao-bat-khoc-khi-nghe-thi-sinh-hat-nhu-ke-chuyen.jpg');
insert urlhinhanh values (null,'https://vnn-imgs-f.vgcloud.vn/2019/06/10/16/hanh-phuc.jpg');
insert urlhinhanh values (null,'https://vnn-imgs-f.vgcloud.vn/2019/06/10/10/dieu-hoa.jpg');


insert baiviet values (null,N'9 cách tận hưởng cuộc sống theo cách thực sự ý nghĩa','TS1','2019-05-10','2','Cuộc sống của mỗi người chúng ta giống như một chuyến đi dài vô tận không có bản đồ. Trong hành trình cuộc đời, bạn phải dừng chân tại nhiều nơi khác nhau, đổi hướng đi tới những con đường chưa hề biết đến. Thường xuyên thay đổi định hướng và có đôi khi bạn dường như bị lạc, mặc dù bạn ghét phải thừa nhận điều này.
Tuy nhiên, thật đáng buồn rằng có một số người kiên quyết mang theo bản đồ cho riêng mình để đảm bảo rằng bản thân luôn chắc chắn mọi điều. Tất cả các con đường đều có sẵn trên bản đồ và họ sẽ không bao giờ bị lạc.
Nếu cuộc sống đơn giản chỉ là tồn tại thì nó giống như một chiếc máy bay điều khiển tự động, với đôi mắt mở to nhưng không nhìn thấy gì cả, cũng không thực sự cảm thấy hoặc trải nghiệm được gì. Bạn cứ bước đi hết bước này đến bước khác theo một hướng duy nhất. Không có cảm xúc, không có thách thức và chắc chắn không có được niềm vui nếu chỉ đơn giản lặp đi lặp lại một công việc mà bạn làm hàng ngày, trong khi mong đợi một điều gì khác.
Trừ khi bạn cảm thấy sâu thẳm bên trong mình rằng cuộc sống không có nghĩa là như vậy thì có nhiều điều hơn thế mà bạn cần phải thay đổi. Là một người yêu thích sự thay đổi, tác giả của bài viết đã rút ra một số việc cần phải làm để cuộc sống trở nên thực sự ý nghĩa và từ đó bạn có thể bắt đầu yêu từng khoảng khắc trong cuộc sống của mình lại một lần nữa. Mời các bạn cùng tham khảo 9 cách tận hưởng cuộc sống theo cách thực sự ý nghĩa!', 'Cuộc sống của mỗi người chúng ta giống như một chuyến đi dài vô tận không có bản đồ. Trong hành trình cuộc đời, bạn phải dừng chân tại nhiều nơi khác nhau, đổi hướng đi tới những con đường chưa hề biết đến.',
'3', '1','2','1','0');

insert baiviet values (null,N'Chào Hè tươi mát với trang phục họa tiết hoa quả nhiệt đới','TT1','2019-05-15','1','Những họa tiết hoa quả phổ biến nhất trong thời trang Hè như họa tiết quả chanh, quả cherry hay quả dứa một lần nữa nằm trong ưu tiên hàng đầu của bạn.
Họa tiết hoa quả không thể thiếu khi nhắc đến thời trang mùa Hè. Hình ảnh vui nhộn và bảng màu bắt mắt xua đi cái nóng oi ả, đưa bạn đến với vùng biển đầy nắng gió hay khu vườn trái cây nhiệt đới sai quả.
HỌA TIẾT TRÁI CHANH
Đây là một trong những họa tiết hoa quả được nhiều fashionista yêu thích nhất. Với sắc vàng tươi tắn làm chủ đạo, trang phục mang họa tiết của loại trái mọng nước này rất phù hợp để diện vào buổi dạo phố ngày Hè hay chuyến du lịch biển.
HỌA TIẾT CHERRY
Những trái cherry đỏ lịm thu hút ánh nhìn người đối diện. Bạn có thể diện trang phục cherry cùng những phụ kiện cùng tông để tạo tổng thể hài hòa. Từ áo sơmi, áo blouse đến những chiếc đầm quấn dịu dàng, thời trang mùa Hè của bạn trở nên ấn tượng hơn nhờ loại quả “ngon mắt” này.
HỌA TIẾT QUẢ DỨA
Họa tiết quả dứa giúp vẻ ngoài của bạn thêm nổi bật và trẻ trung hơn. Vì loại quả này có hình vẽ hơi phức tạp, bạn nên ưu tiên kết hợp cùng những món đồ đơn giản hoặc chọn họa tiết nhỏ để trang phục không bị rối mắt.','Những họa tiết hoa quả phổ biến nhất trong thời trang Hè như họa tiết quả chanh, quả cherry hay quả dứa một lần nữa nằm trong ưu tiên hàng đầu của bạn.', 
'5', '3','5','1','1');

insert baiviet values (null,N'HLV Park Hang-seo cần sự ổn định để đối đầu với Thái Lan','TTA1','2019-05-02','3','Dù gây bất ngờ với danh sách triệu tập ĐTQG, nhưng theo chuyên gia Đoàn Minh Xương, HLV Park Hang-seo đang cần sự ổn định để đối đầu với Thái Lan.
Chiều ngày 27/5, HLV trưởng ĐTQG Việt Nam Park Hang-seo đã công bố danh sách chính thức triệu tập 23 tuyển thủ Việt Nam chuẩn bị cho Kings Cup 2019. Danh sách này đã gây nhiều bất ngờ cho người hâm mộ khi dàn tuyển thủ được triệu tập hầu như đều là những gương mặt cũ đã từng "ăn cơm" tuyển trong suốt một thời gian dài.
Cần sự ổn định để đối đầu đối thủ mạnh.
Có nhiều quan điểm cho rằng, để chốt được danh sách này, cả Liên đoàn bóng đá Việt Nam lẫn BHL đội tuyển đều đã phải cân nhắc rất kĩ lưỡng, xem xét mọi yếu tố để lựa chọn nhân sự.
Tuy nhiên, cũng không ít ý kiến bất bình bởi nhiều cầu thủ đang không có được phong độ tốt như Hà Đức Chinh (SHB Đà Nẵng), Duy Mạnh (Hà Nội FC)... vẫn được triệu tập, trong khi đó, nhiều cầu thủ đang có được phong độ tốt khác như Hữu Tuấn, Văn Thuận hay Hoàng Thịnh lại không có mặt.
Theo quan điểm của chuyên gia Đoàn Minh Xương, lí do HLV Park Hang-seo đưa ra danh sách với đa phần những gương mặt cũ là bởi ông không có nhiều thời gian chuẩn bị cho Kings Cup. Nhìn qua bản danh sách 23 cầu thủ được đưa ra, có thể thấy, hầu hết các cầu thủ đều đã có quãng thời gian dài thi đấu với lối chơi và triết lý bóng đá của ông thầy người Hàn. Do vậy, dù mới bình phục chấn thương hay đang có phong độ không tốt như trường hợp của Văn Thanh, Tuấn Anh, Trọng Hoàng hay Hà Đức Chinh vẫn nằm trong danh sách triệu tập.
Thêm vào đó, với việc nước chủ nhà Thái Lan đang rất khát khao một chiến thắng trước đội tuyển Việt Nam sau những động thái tăng cường lực lượng nhân sự, thay đổi thể thức bốc thăm... thì việc triệu tập một đội hình ổn định của HLV Park Hang-seo là một phương án an toàn.
Rõ ràng HLV Park Hang-seo không có quá nhiều thời gian để chuân bị cho Kings Cup. Do vậy, ông ấy cần sự ổn định trước 1 đối thủ luôn tìm cách thắng Việt Nam. Tôi cũng rất tiếc khi những trường hợp đang có phong độ tốt như Hữu Tuấn (TP HCM) Văn Thuận hay Tô Văn Vũ (Bình Dương) không được lên tuyển. Nhưng chúng ta vẫn phải tôn trọng quyết định của HLV trưởng bởi ông ấy là người chịu trách nhiệm - chuyên gia Đoàn Minh Xương nói.
Danh sách đội tuyển Việt Nam:
Thủ môn: Trần Nguyên Mạnh (SLNA), Đặng Văn Lâm (Muangthong United), Nguyễn Văn Toản (Hải Phòng).
Hậu vệ: Đoàn Văn Hậu (Hà Nội FC), Bùi Tiến Dũng (Viettel), Quế Ngọc Hải (Viettel), Trần Đình Trọng (Hà Nội FC), Đỗ Duy Mạnh (Hà Nội FC), Huỳnh Tấn Sinh (Quảng Nam), Hồng Duy (HAGL), Văn Thanh (HAGL).
Tiền vệ: Đức Huy (Hà Nội FC), Xuân Trường (Buriram United), Hùng Dũng (Hà Nội FC), Tuấn Anh (HAGL), Trọng Hoàng (Viettel), Văn Kiên (Hà Nội FC), Minh Vương (HAGL).
Tiền đạo: Văn Toàn (HAGL), Công Phượng (Incheon United), Quang Hải (Hà Nội FC), Anh Đức (B.Bình Dương), Đức Chinh (SHB Đà Nẵng).','Dù gây bất ngờ với danh sách triệu tập ĐTQG, nhưng theo chuyên gia Đoàn Minh Xương, HLV Park Hang-seo đang cần sự ổn định để đối đầu với Thái Lan.', 
'14', '6','8','1','1');

insert baiviet values (null,N'8 điểm đến gần Hà Nội và dễ đi trong dịp 30/4','DL1','2019-06-03','4','Chỉ mất từ một tới hai tiếng chạy xe, du khách có thể chọn cho mình những chuyến picnic ngắn ngày, hòa mình cùng thiên nhiên trong dịp nghỉ lễ.
Núi Trầm
Núi Trầm nằm ở xã Phụng Châu, huyện Chương Mỹ, cách trung tâm Hà Nội chưa đầy 30 km. Bạn chỉ mất khoảng 45 phút đến một giờ đồng hồ đi xe máy theo đường quốc lộ 6 để đến nơi được ví như “cao nguyên đá” gần Hà Nội. Ngọn núi này không quá cao nhưng địa hình đẹp, với nhiều hang và con đường mòn uốn lượn trong các thung lũng bằng phẳng, xen kẽ là bãi cỏ xanh mượt, giúp bạn tha hồ "sống ảo" và dạo chơi. Núi Trầm thích hợp cho những buổi picnic trong ngày hay cắm trại qua đêm. Ở gần núi có một vài ngôi chùa mà bạn có thể đến tham quan như chùa Trầm, chùa Vô Vi, chùa Long Tiên...
Chi phí cho một chuyến picnic ở Núi Trầm khá rẻ, chia đầu người khoảng trên dưới 200.000 đồng. Nếu bạn ngại phải mang nhiều đồ cồng kềnh, dưới chân núi có cửa hàng cho thuê đủ thứ như lều trại, đèn, bếp, vỉ nướng, bát đũa… Lều to 4 người có giá 100.000 đồng một đêm, lều 2 người 70.000 đồng một đêm, đồ dùng từ 15.000 đồng. 
Sóc Sơn
Địa danh này nằm cách Hà Nội hơn 30 km theo hướng Bắc Thăng Long – Nội Bài. Sóc Sơn phù hợp với những chuyến du lịch từ một đến hai ngày với các điểm đến chủ yếu là khu cắm trại hồ Hàm Lợn, Việt phủ Thành Chương và những căn biệt thự cho thuê ngắn ngày. Hoạt động được du khách ưa thích nhất tại đây là cắm trại, tiệc nướng BBQ với tầm nhìn ra những khu rừng hoặc hồ nước ở Sóc Sơn. Một số khách còn thực hiện những cuộc khám phá đỉnh Hàm Lợn theo lối mòn để tăng tính thử thách, với thời gian leo khoảng 2-4h tùy cung đường được chọn.
Du khách đến hồ Hàm Lợn cũng không phải trả chi phí nào trừ khi muốn gửi xe ở nhà người dân (15.000 đồng một chiếc) hoặc tham quan Việt phủ, thuê nhà. Khách muốn thuê biệt thự tại đây nên đặt trước từ sớm bởi nhiều nhóm khách lựa chọn Sóc Sơn làm điểm đến cho kỳ nghỉ ngắn ngày.
Vườn quốc gia Ba Vì
Nằm cách Hà Nội khoảng 50 km, từ lâu vườn quốc gia Ba Vì đã trở thành điểm đến lý tưởng cho những chuyến du lịch ngắn ngày. Do nằm ở địa hình cao, nhiệt độ tại đây luôn thấp hơn thông thường 3-4 độ C, phù hợp tránh nóng. Những điểm tham quan phổ biến tại vườn quốc gia Ba Vì là khu rừng thông ở coste 400, nhà thờ đổ do người Pháp xây dựng ở coste 800 và đền Thượng, đền thờ Bác Hồ ở đỉnh núi cao 1.100 m so với mực nước biển. Ưu điểm tiếp theo của địa điểm này là khá gần các danh thắng khác để bạn khám phá như Thiên Sơn Suối Ngà, hồ Tiên Sa, Ao Vua… với hệ thống suối, thác và hồ bơi tự nhiên.
Giá vé vào cửa vườn quốc gia Ba Vì là 60.000 đồng một người và 30.000 đồng với học sinh, sinh viên.
Làng cổ Đường Lâm
Làng Đường Lâm cách trung tâm Hà Nội khoảng 45 km, thuộc địa phận thị xã Sơn Tây. Từ Hà Nội, du khách có thể đến đây bằng xe máy, ôtô, xe buýt rất dễ dàng. Đây là một trong những ngôi làng Việt cổ còn lại đến ngày nay, với hơn 950 ngôi nhà xưa, xây từ đất và đá ong, kết nối với nhau bằng những con ngõ nhỏ quanh co. Người dân tại đây vẫn trồng lúa và làm các nghề truyền thống theo phương pháp thủ công. Ngoài đi dạo khám phá làng, du khách còn có thể tham quan nghề làm tương, kẹo lạc, bánh gai… trong bối cảnh như hàng trăm năm trước. Những điểm tham quan chính tại đây gồm làng Mông Phụ, chùa Mía, lăng Ngô Quyền, đền thờ Phùng Hưng, nhà thờ thám hoa Giang Văn Minh.
Trên những trục đường chính dẫn vào làng Đường Lâm đều có điểm bán vé tham quan. Du khách sau khi mua vé với giá 20.000 đồng mỗi người có thể tự do khám phá tất cả địa danh hoặc trả thêm tiền để thuê xe đạp, ăn uống và ngủ qua đêm. 
Hồ Đồng Mô
Hồ nước rộng 200 ha dưới chân núi Ba Vì cách trung tâm Hà Nội khoảng 50 km về phía tây. Theo truyền thuyết, đây là nơi diễn ra cuộc chiến giành công chúa Mị Nương giữa Sơn Tinh và Thủy Tinh. Ngày nay, hồ Đồng Mô là điểm đến du lịch ngắn ngày, phù hợp với những hoạt động ngoài trời như picnic, team building bởi không gian rộng. Những điểm thu hút người dân và du khách chủ yếu ở hai bên tuyến đường ven hồ với các bãi đất phẳng và rừng cây. Đồng Mô còn nổi tiếng bởi sân golf độc đáo nằm trên hòn đảo giữa hồ. Du khách đến đánh golf sẽ phải di chuyển tới đảo bằng cano.
Khi tới Đồng Mô, du khách không phải trả bất cứ khoản phí gì trừ khi có nhu cầu thuê cano, nghỉ ở khu Sơn Tinh Camp hoặc biệt thự Phan Thị trong phim “Người phán xử”.
Tam Đảo
Nơi này được biết tới là một điểm du lịch cuối tuần lý tưởng nằm cách thủ đô 70 km. Tam Đảo có nhiều biệt thự, khách sạn tuổi đời hàng chục năm, và cả những khu nghỉ dưỡng sang trọng phù hợp với nhiều yêu cầu của du khách. Ở thị trấn, những điểm tham quan đông khách nhất là nhà thờ, tháp truyền hình, đền Bà chúa thượng ngàn, thác Bạc… Nếu muốn nhiều trải nghiệm hơn, bạn có thể tham gia vào các chuyến trekking lên đỉnh núi, xuyên rừng đến chùa Địa Ngục.
Nếu đi từ hai người trở lên, một chuyến đi hai ngày một đêm tới Tam Đảo hết trung bình 600.000 đồng, đã bao gồm tiền xăng xe, phòng nghỉ bình dân và ăn uống.
Vườn quốc gia Cúc Phương
Mùa bướm ở rừng Cúc Phương bắt đầu từ khoảng cuối tháng 4, đầu tháng 5. Đến vườn quốc gia mùa này, du khách sẽ được ngắm nhìn muôn vàn cánh bướm dập dìu hệt như khung cảnh thần tiên trong truyện cổ tích. Vườn quốc gia Cúc Phương cách Hà Nội khoảng 120 km theo hướng quốc lộ 1A, nằm trên địa bàn ba tỉnh Ninh Bình, Hòa Bình và Thanh Hóa. Ngoài thiên nhiên xanh mát, những đàn bướm hàng trăm con tụ lại xuất hiện nhiều dần theo lối vào của khu du lịch. Phổ biến nhất tại đây là bướm trắng, bên cạnh đó là những loài nhiều màu sắc hơn như bướm phượng, bướm khế… Theo kinh nghiệm của nhiều du khách, thời gian lý tưởng để ngắm đàn bướm là những ngày trời nắng.
Giá vé vào cửa vườn quốc gia Cúc Phương là 60.000 đồng một người, 30.000 đồng với học sinh, sinh viên... 
Đồng Cao
Nằm cách Hà Nội chừng 150 km, Đồng Cao là điểm đến hoang sơ thuộc xã Thạch Sơn, huyện Sơn Động, tỉnh Bắc Giang. Đây là điểm đến hiếm hoi thích hợp cho cả bốn mùa, thu hút du khách bởi không gian rộng lớn với những thảo nguyên, đồi cỏ thấp và bầu không khí trong lành. Du lịch Đồng Cao thường thích hợp với kiểu phượt xe máy, picnic ngắn ngày do khu vực này nằm khá biệt lập, chỉ có khoảng hơn chục nóc nhà của người dân nằm rải rác xung quanh. Vào mùa hè, những đồng cỏ tại đây chuyển màu xanh mướt và ngả vàng khi bước sang mùa đông. Do vị trí xa khu đông dân cư, các nhóm phượt Đồng Cao có cơ hội nhìn thấy bầu trời đầy sao vào ban đêm những ngày trời quang mây và đón ánh bình minh vào sáng hôm sau.
Du khách cần chuẩn bị kỹ càng các vật dụng như lều trại, đồ nấu nướng do không có bất cứ dịch vụ nào trong bán kính khoảng 10 km quanh Đồng Cao.','Chỉ mất từ một tới hai tiếng chạy xe, du khách có thể chọn cho mình những chuyến picnic ngắn ngày, hòa mình cùng thiên nhiên trong dịp nghỉ lễ.', 
'7', '9','8','1','1');

insert baiviet values (null,N'Chăm con tối ngày, nhiều mẹ Việt vẫn bỏ quên đề kháng da','SK1','2019-06-11','5','Chẳng màng ngày đêm, quên ăn quên uống để chăm lo cho sức khỏe con, tuy nhiên nhiều mẹ lại bỏ qua đề kháng da - chức năng quan trọng trong hệ miễn dịch với vai trò là lớp áo giáp đầu tiên bảo vệ con khỏi vi khuẩn.
Phải đầu bù tóc rối mới trọn tấm lòng làm mẹ?
Có những đứa trẻ ra đời, thì sẽ có những người mẹ được trao tặng thiên chức thiêng liêng mới. Mẹ thức khuya dậy sớm, quẩn quanh bên con từng giờ để chăm sóc cho con.
Ngay từ lúc con còn chưa ra đời, sức khỏe con đã luôn là mối bận tâm hàng đầu của mẹ. Để tăng cường sức khỏe cho con, hôm nay mẹ tìm cách bổ sung dinh dưỡng, hôm khác lại “tính kế” làm sao để bảo vệ con khỏi mầm bệnh tồn tại ở khắp mọi nơi, nhất là khi hệ miễn dịch của con chưa hoàn thiện. Cứ như vậy, nhiều mẹ bị mắc kẹt trong nỗi sợ hãi con bị vi khuẩn gây bệnh tấn công.
Thời gian của mẹ xoay vòng trong những vội vã âu lo, mẹ đôi khi quên mất mình cũng cần một quãng nghỉ thảnh thơi để chăm sóc, quan tâm hơn tới chính bản thân mình. Có khi, nếu mẹ dành chút thời gian chăm chút cho riêng mình, mẹ cũng ít nhiều e ngại những lời bàn tán: "Tối ngày chỉ biết ích kỷ làm đẹp bản thân, con cái thì không lo, con bệnh rồi ai chăm cho", càng khiến mẹ không dám buông con ra một giây phút nào.
Tuy nhiên có một thực tế, dù có hi sinh thời gian năm tháng và cả thanh xuân của mẹ mà không chăm sóc con đúng cách, không hiểu rõ những cơ chế bảo vệ tự nhiên trong cơ thể bé thì con cũng khó lòng mạnh khỏe vững vàng. Giờ đây, mẹ có thể yên tâm và thêm chút thời gian riêng tư cho chính mình nếu biết có một hệ cơ quan trong miễn dịch cơ thể mang tên đề kháng da, là lớp áo giáp vững chắc bảo vệ con khỏi vi khuẩn gây bệnh mỗi ngày.
“Đề kháng da” bảo vệ bé khỏe mạnh hơn
Đề kháng da là chức năng đề kháng tự nhiên của da thuộc hệ miễn dịch bẩm sinh của mỗi người. Đề kháng của da hoạt động như lớp hàng rào phòng ngự đầu tiên, giúp bảo vệ cơ thể và ngăn chặn tác động xấu từ các vi khuẩn gây bệnh.
Tuy nhiên, đề kháng da có khả năng bị ảnh hưởng bởi những tác nhân gây hại xung quanh như không khí ô nhiễm, bụi mịn, các bệnh về da... nếu không được chăm sóc đúng cách. Khi đề kháng của da suy yếu, vi khuẩn gây bệnh sẽ dễ dàng tấn công bé, gây ra nhiều nguy cơ nhiễm bệnh. Vì vậy, để bảo vệ đề kháng da, mẹ cần quan tâm lưu ý đến thói quen sử dụng sản phẩm sữa tắm sao cho phù hợp để không làm tổn hại đến đề kháng da của con.
Sữa tắm Lifebuoy mới với công thức ion bạc+, đặc biệt có chứa phân tử bạc nano - đã được nghiên cứu chứng minh hiệu quả diệt khuẩn an toàn, có thể tác động lên cả vi khuẩn Gram dương, Gram âm, nấm mốc, vi nấm, virus và các vi khuẩn đề kháng đa kháng thuốc.
Cùng với đó, thành phần Thymol và Terpineol trong sữa tắm Lifebuoy mới được chứng minh có thể tiêu diệt vi nấm gây hại và một số vi khuẩn (như E.coli, S.aureus, Samonella sp gây tiêu chảy, ngộ độc, nhiễm trùng…). Đặc biệt, sữa tắm Lifebuoy mới không làm ảnh hưởng đến chức năng đề kháng của da, mà còn kết hợp cùng đề kháng da phát huy tối đa sức mạnh bảo vệ cơ thể cho trẻ.','Chẳng màng ngày đêm, quên ăn quên uống để chăm lo cho sức khỏe con, tuy nhiên nhiều mẹ lại bỏ qua đề kháng da - chức năng quan trọng trong hệ miễn dịch với vai trò là lớp áo giáp đầu tiên bảo',
'6','1','5','1','1');

insert baiviet values (null,N'Công ty Mỹ yêu cầu đối tác châu Âu tẩy chay Huawei','CN1','2019-06-10','6','Nhiều đối tác châu Âu của công ty Mỹ được yêu cầu ngừng bán sản phẩm cho Huawei
Google cảnh báo hệ điều hành mới của Huawei sẽ gây hại cho an ninh quốc gia
Đài Loan cấm chất bán dẫn do công ty của Huawei sản xuất
iOS 13 ra mắt, Huawei phát triển mạng 5G tại Nga
Nỗ lực sống sót của Huawei không cần tới phần mềm và phần cứng từ Mỹ sắp biến thành thảm họa tại châu Âu, nơi các công ty được đối tác Mỹ yêu cầu tẩy chay công ty Trung Quốc.
Theo báo cáo của WindowsUnited, các công ty Mỹ đang gây sức ép lên đối tác ở Lục địa già yêu cầu ngừng làm ăn với Huawei, trong đó có việc ngừng bán sản phẩm cho công ty Trung Quốc.
3M là một trong những công ty đang theo hướng tiếp cận này. Công ty Mỹ 3M là thương hiệu lớn tại châu Âu, chính vì vậy đây có thể xem là cú đánh mạnh vào Huawei.
Cả 3M và Huawei chưa đưa ra bình luận chính thức về việc này, tuy nhiên đây được xem là động thái Huawei chưa bao giờ ngờ tới.
Công ty Trung Quốc từng nói đã chuẩn bị kỹ càng cho lệnh cấm sử dụng sản phẩm Mỹ của chính phủ Mỹ, và đây cũng là lý do tại sao công ty này tự phát triển hệ điều hành di động riêng.
Theo lệnh cấm được Tổng thống Donald Trump ký hồi tháng 5, Huawei không được phép sử dụng phần mềm và phần cứng của công ty Mỹ, trong số này có các hệ điều hành như Android và Windows.
Nói cách khác, lựa chọn duy nhất của Huawei tại thời điểm này là dựa vào sản phẩm phát triển trong nước. Trong ngắn hạn, công ty Trung Quốc sẽ gặp khủng hoảng lớn. Về dài hạn, tương lai Huawei cũng không sáng sủa gì hơn khi không chỉ bị cấm tại Mỹ mà còn bị chặn tại các thị trường khác trên thế giới.','Nhiều đối tác châu Âu của công ty Mỹ được yêu cầu ngừng bán sản phẩm cho Huawei.',
'30','7','5','1','1');

insert baiviet values (null,N'Sam lên tiếng trước tin đồn bí mật hẹn hò với Jun Phạm','TH1','2019-09-06','7','Tối 8/6, tập 9 của chương trình Chạy đi chờ chi - Running Man Việt Nam được phát sóng với sự tham gia của diễn viên Sam trong vai trò khách mời. Trong tập này, Sam đã bắt cặp cùng Jun để vượt qua những thử thách của chương trình với chủ đề "Cuộc đua đám cưới".
Cả hai nghệ sĩ đã có nhiều khoảnh khắc vui đùa, thân mật cùng nhau khi tham gia các trò chơi như dùng đũa gắp hộp sữa, mặc áo đôi nhảy dây, rút gươm hải tặc, bịt mắt và dùng má để đoán đồ vật, làm hoa cưới.
Đặc biệt, khi Sam và Jun Phạm thực hiện nhiệm vụ bịt mắt và dùng má để đoán đồ vật, cặp đôi đã có khoảnh khắc chạm má và hôn nhau. Biết Jun Phạm dùng miệng ăn thử để đoán ra đồ vật, Sam liền đưa tay ra và vô tư nói với nam diễn viên: "Anh nhả cho em ăn miếng coi".
Những hành động "tình bể bình" này đã khiến cho các nghệ sĩ khác cũng như khán giả xem truyền hình phải bấn loạn. Tuy nhiên, cả Sam và Jun Phạm đều không tỏ ra ngại ngùng trước những khoảnh khắc thân mật này.
Vì vậy, sau khi chương trình phát sóng, rất đông người hâm mộ đã vào trang cá nhân của hai nghệ sĩ để bày tỏ sự ủng hộ và mong muốn Sam và Jun Phạm thành đôi. Nhiều cư dân mạng cũng đặt nghi vấn việc hai diễn viên đang bí mật hẹn hò bởi cặp đôi rất thoải mái tình tứ trong chương trình.
Mới đây, Sam đã lên tiếng giải đáp những thắc mắc của khán giả về vấn đề này. Diễn viên Siêu sao siêu ngố chia sẻ khi đến với Chạy đi chờ chi, cô xác định đã chơi là phải chiến đấu hết mình, dù có không may mắn giành được giải thưởng nhưng vẫn hài lòng vì đã có những khoảnh khắc vui vẻ thực sự.
Khi được hỏi về việc có nhiều khoảnh khắc tình tứ với Jun Phạm, Sam hào hứng cho biết cách đây 4 năm, cả hai từng hóa thân thành một cặp yêu nhau khi đóng chung một bộ phim. Sau đó, cả hai vẫn giữ mối quan hệ bạn bè, anh em đồng nghiệp.
"Lúc Running Man phát sóng, có nhiều khán giả hỏi rằng 4 năm trước đóng "Cô Thắm về làng" không thấy hôn nhau mà bây giờ tham gia chương trình lại hôn như thế, tôi thấy rất buồn cười. Vì lúc chơi game, cả tôi với anh Jun đều lăn xả hết mình, không ai nghĩ gì xa hơn thế. Tôi rất quý anh Jun bởi sự hòa đồng, thân thiện", nữ diễn viên nói.
Về chuyện tình cảm ở thời điểm hiện tại, Sam cho biết cô không muốn chia sẻ quá nhiều vì hầu như quỹ thời gian đều dồn cả cho công việc và gia đình. Sam khẳng định cô là người rất yêu công việc và luôn cố gắng làm mọi thứ thật tốt để khán giả không thất vọng về mình.','Liên tục có nhiều khoảnh khắc thân mật khi tham gia chương trình Chạy đi chờ chi - Running Man bản Việt, Sam và Jun Phạm khiến nhiều người nghi vấn đang bí mật hẹn hò.',
'8','3','8','1','1');

insert baiviet values (null,N'Giọng hát Việt gây tranh cãi khi bị tố thiên vị thí sinh là hot girl','AN1','2019-06-11','8','Đêm thi đầu tiên của vòng Đo ván Giọng hát Việt 2019 gây tranh cãi với kết quả bị khán giả tố không công bằng khi Juky San được HLV Hồ Hoài Anh lựa chọn đi tiếp.
Tối 9/6, tập 9 The Voice - Giọng Hát Việt 2019 lên sóng với nhiều tiết mục đáng nhớ. Đêm thi đầu tiên của vòng Đo ván là sự tranh đấu của 5 thí sinh đội HLV Hồ Hoài Anh là: Đức Thịnh, Cát Tiên, Bảo Trân, Juky San và Công Luận. Từng thí sinh lần lượt biểu diễn và hát bằng piano đệm, hoàn toàn không có sự hỗ trợ từ ban nhạc. Bên cạnh đó, 3 thí sinh được đặc cách trình diễn và sau đó sẽ dừng cuộc chơi với những sản phẩm âm nhạc đã được ra mắt là: Tùng Hiếu, Khánh Linh và nhóm S2.
Bên cạnh Công Luận và Bảo Trân được vào vòng trong, Juky San là thí sinh cuối cùng của đội HLV Hồ Hoài Anh được lựa chọn đi tiếp. Kết quả này nhanh chóng khiến nhiều khán giả bất bình, tố ban tổ chức thiên vị thí sinh hot girl khi cô quá một màu, không có sự sáng tạo, đổi mới trong từng vòng. Cũng theo nhiều ý kiến, người xứng đáng hơn phải là Vũ Đức Thịnh.
Không sở hữu giọng hát nội lực nhưng sự dịu dàng, trong trẻo của giọng hát Juky San mang lại cảm giác nhẹ nhàng và dễ dàng tạo cảm tình cho người nghe. Cô thể hiện ca khúc mới mang tên Nàng thơ xứ Huế trong vòng thi Đo ván. Tuy nhiên sự một màu trong cách hát và chọn bài qua từng vòng khiến cô bị nhiều khán giả đánh giá không xứng đáng để đi tiếp. Nhiều bình luận cho rằng: "Juky San diễn một màu quá, đây là cuộc thi có phải đi chơi đâu mà nhường”.
Nhiều khán giả bày tỏ sự không hài lòng: "Cô vẫn trong sáng, giọng hát vẫn nhẹ nhàng. Tổng thể bài hát dịu dàng, trong trẻo. Tuy nhiên, món ăn dù ngon cũng gây nhàm chán nếu sử dụng quá nhiều". Hay có những nhận xét khắt khe hơn: "Juky hát yếu, chưa có cảm xúc, các dạng bài để hát được lại ít, rất khó có thể cạnh tranh những vòng sau”, "Đức Thịnh xứng đáng vào vòng trong hơn Juky San. Nhưng cuối cùng bạn nữ được chọn vì nổi tiếng từ trước. Thật bực mình. Tôi sẽ không xem chương trình".
Vũ Đức Thịnh thể hiện ca khúc Đường nào đến trái tim em với lối xử lý hiện đại và giàu cảm xúc. HLV Tuấn Ngọc chia sẻ: Nếu được lựa chọn, anh sẽ chọn thí sinh Vũ Đức Thịnh vì ngoại hình đẹp, hát hay và rõ lời, không có gì để chê. Khán giả bình luận: "Không hiểu sao, lại chọn Juky thay vì Đức Thịnh. Lúc đầu cười thấy duyên, càng về sau càng thấy lố", “Thiên vị quá, loại Đức Thịnh thì không chấp nhận được. Chán quyết định của Hồ Hoài Anh”.
Khán giả cho rằng giữa tiết mục của Đức Thịnh và Juky San có sự chênh lệch lớn và Đức Thịnh đang thể hiện ưu thế hơn. "Trình diễn hoàn hảo nhất trong 5 người. Hồ Hoài Anh có thiện cảm với Juky San hơn. Chứ bạn đó hát phô. Bất công", "Không cần nói nhiều. Anh hát hay lắm. Anh vẫn là người nổi bật nhất trong team Hồ Hoài Anh đến bây giờ đối với cá nhân mình. Chúc anh vẫn luôn thành công trong sự nghiệp ca hát".
Nổi bật nhất đêm thi là tiết mục giàu cảm xúc của Huỳnh Công Luận. Anh trình diễn ca khúc Anh ấy cô ấy và nhận được lời khen ngợi từ HLV Thanh Hà. Nữ HLV chia sẻ cô gần như bật khóc khi thưởng thức tiết mục của chàng trai. Một nhạc phẩm vốn mang nhiều tâm tư nay được thể hiện mộc mạc bởi chất giọng tự sự đầy truyền cảm trên nền piano lắng đọng như dẫn lối người nghe vào câu chuyện của nhân vật trong ca khúc. Lối hát uyển chuyển với những điểm nhấn bỏ nhỏ, vỡ oà được đặt để hợp lý giúp Công Luận nhanh chóng chiếm trọn cảm tình từ người nghe.
Nguyễn Tùng Hiếu thể hiện bản mashup hai ca khúc hit: Chuyện chàng cô đơn & Yêu em dại khờ. Chàng trai sụt giảm phong độ khi lạc mất nhịp phách và thiếu ổn định khi lên nốt cao. Việc tập trung quá nhiều vào diễn xuất trên sân khấu có thể là một trong số ít những lý do khiến phần thi của Tùng Hiếu chưa được trọn vẹn.
Nhóm S2 trình diễn ca khúc Kẻ trộm được chính thành viên trong nhóm sáng tác. Lời ca dí dỏm, ý nghĩa cùng giai điệu hợp xu hướng của nhiều ca khúc indie đang được ưa chuộng hứa hẹn ca khúc này sẽ là một ẩn số thú vị trong tương lai. Phần hát của S2 cũng bắt tai và nhẹ nhàng với sự bè phối ăn ý, tôn lên chất giọng của từng thành viên.
Khánh Linh và Tùng Anh mang tới hai ca khúc đình đám thời gian gần đây là: Anh nhà ở đâu thế & Mượn rượu tỏ tình. Sự nhí nhảnh, tươi vui của cả hai khiến khán giả thích thú và cổ vũ không ngớt.
Vũ Đức Thịnh thể hiện ca khúc Đường nào đến trái tim em. Vẻ điển trai của anh là lợi thế thu hút nổi bật. HLV Tuấn Ngọc chia sẻ: Nếu được lựa chọn, anh sẽ chọn thí sinh Vũ Đức Thịnh vì ngoại hình đẹp, hát hay và rõ lời, không có gì để chê.
Cát Tiên trình diễn bản ballad Yếu đuối ai xem và chinh phục người nghe bởi chất giọng dày, giàu cảm xúc. Tuy không ấn tượng đến mức khiến người nghe phải ngỡ ngàng thán phục, ca khúc là lựa chọn an toàn và vừa vặn với giọng hát của cô.
Lối hát RnB pha Jazz Blues của Bảo Trân khiến ca khúc Không cần vốn đã quen thuộc với nhiều khán giả nay trở nên lạ tai hơn. Phong cách trình diễn cùng trang phục cũng để lại dấu ấn riêng của Bảo Trân trong đêm thi.
Kết quả, HLV Hồ Hoài Anh lựa chọn Công Luận, Bảo Trân và Juky San là thí sinh đi tiếp, kết thúc màn Đo ván của đội mình. Tập 10 The Voice - Giọng hát Việt 2019 với màn Đo ván của 3 đội còn lại sẽ tiếp tục lên sóng vào ngày 16/6.','Đêm thi đầu tiên của vòng Đo ván Giọng hát Việt 2019 gây tranh cãi với kết quả bị khán giả tố không công bằng khi Juky San được HLV Hồ Hoài Anh lựa chọn đi tiếp.',
'11','9','2','1','0');

insert baiviet values (null,N'Phụ nữ không kết hôn và không có con là những người hạnh phúc nhất','GD1','2019-06-05','9','Phụ nữ không kết hôn và không có con là những người hạnh phúc nhất
Theo giáo sư về khoa học hành vi Paul Dolan, phụ nữ không kết hôn và không có con là những người hạnh phúc nhất so với các nhóm phụ nữ khác.
‘Khi nào thì cưới?’ là một trong những câu hỏi thường bị đặt ra cho người trẻ trong những buổi tụ họp gia đình. Nếu bạn là phụ nữ và muốn hạnh phúc, hãy suy nghĩ kỹ trước khi trả lời.
Theo giáo sư về khoa học hành vi Paul Dolan, phụ nữ không kết hôn và không có con là những người hạnh phúc nhất so với các nhóm phụ nữ khác. Đây là kết quả nghiên cứu mang tên ‘Happy Ever After’ của tác giả Paul Dolan được công bố hồi đầu năm 2019 và được trích dẫn bởi tờ The Guardian.
Kết quả này thách thức quan điểm truyền thống rằng người phụ nữ cần có chồng và sinh con thì mới có hạnh phúc trọn vẹn.
"Khi chồng họ có mặt, những người phụ nữ này trả lời rằng họ rất hạnh phúc. Nhưng khi không có mặt bạn đời, câu trả lời cho thấy họ thuộc nhóm ít hạnh phúc nhất" - tờ The Guardian trích dẫn.
Phát biểu tại lễ hội Hay Festival của tờ The Guardian, ông nói rằng, theo nghiên cứu này đàn ông có lợi nhiều hơn phụ nữ. Đàn ông kết hôn sống lâu hơn nhóm không kết hôn, trong khi với phụ nữ thì ngược lại – phụ nữ không kết hôn sống lâu hơn nhóm kết hôn.
Cụ thể, phụ nữ kết hôn ở độ tuổi trung niên có nguy cơ mắc các bệnh về thể chất và tinh thần cao hơn so với nhóm đối tượng tương tự độc thân.
Dolan cũng cho rằng quan điểm kỳ thị những phụ nữ độc thân, không có con nên bị xóa bỏ. Điều đó sẽ khiến họ bị áp lực và kết hôn vội vã với những người đàn ông không phù hợp với mình.','Theo nghiên cứu, phụ nữ không kết hôn và không có con là nhóm phụ nữ hạnh phúc nhất.',
'4','4','8','1','0');
*/




