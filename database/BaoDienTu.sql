
create database baodientu;
use baodientu;

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
  ChuyenMuc varchar(10),
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
  urllinkHinh varchar(255) not null UNIQUE
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
insert phanhenguoidung values ('AD001','Admin');
insert phanhenguoidung values ('DG001','Doc Gia');
insert phanhenguoidung values ('DG002','Doc Gia Vang Lai');

insert nguoidung values (null,'lequangnhat','nhat123',' Le Quang Nhat', 'Nam', '1997-08-29', 'lqnhat@gmail.com', '0926803468', 'PV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'hoanganhtuan','tuan123','Hoang Anh Tuan', 'Nam', '1995-10-17', 'hatuan@gmail.com', '0981828596', 'BTV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'vulamanh','anh123','Vu Lam Anh', 'Nu', '1995-05-25', 'lamanhpv@gmail.com', '0977713558', 'PV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'nguyenanhthi','thi123','Nguyen Anh Thi', 'Nu', '1996-02-05', 'thithi@gmail.com', '0355688828', 'PV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'trandonghoa','hoa123','Tran Dong Hoa', 'Nam', '1992-04-13', 'donghoatran@gmail.com', '0898981597', 'BTV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'hoanglean','an123','Hoang Le An', 'Nam', '1991-07-09', 'anlehoang@gmail.com', '0979845461', 'PV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'dangthienminh','minh123','Dang Thien Minh', 'Nam', '1997-06-14', 'dtminh@gmail.com', '0762412871', 'PV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'phanthimyduyen','duyen123','Phan Thi My Duyen', 'Nu', '1995-02-22', 'duyenphan@gmail.com', '0963512841', 'BTV001', '2019-05-10', '2024-05-10', 'Hoat Dong');
insert nguoidung values (null,'nguyenquockhanh','khanh123','Nguyen Quoc Khanh', 'Nam', '1993-09-16', 'nqkhanh@gmail.com', '0923023046', 'PV001', '2019-05-10', '2024-05-10', 'Hoat Dong');


insert chuyenmuc values ('TT001',N'Thời trang','Thoi trang',null);
insert chuyenmuc values ('TS001',N'Tâm sự và cuộc sống','Tam su va cuoc song',null);
insert chuyenmuc values('DL001',N'Du lịch','Du lich',null);
insert chuyenmuc values('TTA001',N'Thể thao','The thao',null);
insert chuyenmuc values('SK001',N'Sức khỏe','Suc khoe',null);

insert urlhinhanh values (null,'https://www.elle.vn/wp-content/uploads/2019/01/19/elle-viet-nam-trang-phuc-tet-3.jpg');
insert urlhinhanh values (null,'https://st.quantrimang.com/photos/image/2017/08/31/song-co-y-nghia-7.jpg');
insert urlhinhanh values (null,'https://toquoc.mediacdn.vn/2019/5/28/55680190819212708456033345622057033138176n-1553665256897912346264-15572998912451218198859-1559062386415263211674.jpg');
insert urlhinhanh values (null,'https://i-dulich.vnecdn.net/2019/04/19/di-choi-gan-ha-noi-30-4-vnexpress-2019-2_r_680x0.jpg');


insert baiviet values ('BV001',N'9 cách tận hưởng cuộc sống theo cách thực sự ý nghĩa','9 cach tan huong cuoc song theo cach thuc su y nghia','TS001','2019-05-10','2','Cuộc sống của mỗi người chúng ta giống như một chuyến đi dài vô tận không có bản đồ. Trong hành trình cuộc đời, bạn phải dừng chân tại nhiều nơi khác nhau, đổi hướng đi tới những con đường chưa hề biết đến. Thường xuyên thay đổi định hướng và có đôi khi bạn dường như bị lạc, mặc dù bạn ghét phải thừa nhận điều này.
Tuy nhiên, thật đáng buồn rằng có một số người kiên quyết mang theo bản đồ cho riêng mình để đảm bảo rằng bản thân luôn chắc chắn mọi điều. Tất cả các con đường đều có sẵn trên bản đồ và họ sẽ không bao giờ bị lạc.
Nếu cuộc sống đơn giản chỉ là tồn tại thì nó giống như một chiếc máy bay điều khiển tự động, với đôi mắt mở to nhưng không nhìn thấy gì cả, cũng không thực sự cảm thấy hoặc trải nghiệm được gì. Bạn cứ bước đi hết bước này đến bước khác theo một hướng duy nhất. Không có cảm xúc, không có thách thức và chắc chắn không có được niềm vui nếu chỉ đơn giản lặp đi lặp lại một công việc mà bạn làm hàng ngày, trong khi mong đợi một điều gì khác.
Trừ khi bạn cảm thấy sâu thẳm bên trong mình rằng cuộc sống không có nghĩa là như vậy thì có nhiều điều hơn thế mà bạn cần phải thay đổi. Là một người yêu thích sự thay đổi, tác giả của bài viết đã rút ra một số việc cần phải làm để cuộc sống trở nên thực sự ý nghĩa và từ đó bạn có thể bắt đầu yêu từng khoảng khắc trong cuộc sống của mình lại một lần nữa. Mời các bạn cùng tham khảo 9 cách tận hưởng cuộc sống theo cách thực sự ý nghĩa!', '0', '1','2','0','0');

insert baiviet values ('BV002',N'Chào Hè tươi mát với trang phục họa tiết hoa quả nhiệt đới','Chao he tuoi mat voi trang phuc hoa qua nhiet doi','TT001','2019-05-10','1','Những họa tiết hoa quả phổ biến nhất trong thời trang Hè như họa tiết quả chanh, quả cherry hay quả dứa một lần nữa nằm trong ưu tiên hàng đầu của bạn.
Họa tiết hoa quả không thể thiếu khi nhắc đến thời trang mùa Hè. Hình ảnh vui nhộn và bảng màu bắt mắt xua đi cái nóng oi ả, đưa bạn đến với vùng biển đầy nắng gió hay khu vườn trái cây nhiệt đới sai quả.
HỌA TIẾT TRÁI CHANH
Đây là một trong những họa tiết hoa quả được nhiều fashionista yêu thích nhất. Với sắc vàng tươi tắn làm chủ đạo, trang phục mang họa tiết của loại trái mọng nước này rất phù hợp để diện vào buổi dạo phố ngày Hè hay chuyến du lịch biển.
HỌA TIẾT CHERRY
Những trái cherry đỏ lịm thu hút ánh nhìn người đối diện. Bạn có thể diện trang phục cherry cùng những phụ kiện cùng tông để tạo tổng thể hài hòa. Từ áo sơmi, áo blouse đến những chiếc đầm quấn dịu dàng, thời trang mùa Hè của bạn trở nên ấn tượng hơn nhờ loại quả “ngon mắt” này.
HỌA TIẾT QUẢ DỨA
Họa tiết quả dứa giúp vẻ ngoài của bạn thêm nổi bật và trẻ trung hơn. Vì loại quả này có hình vẽ hơi phức tạp, bạn nên ưu tiên kết hợp cùng những món đồ đơn giản hoặc chọn họa tiết nhỏ để trang phục không bị rối mắt.', '0', '3','5','0','0');

insert baiviet values ('BV003',N'HLV Park Hang-seo cần sự ổn định để đối đầu với Thái Lan','HLV Park Hang-seo can su on dinh de doi dau voi Thai Lan','TTA001','2019-05-10','3','Dù gây bất ngờ với danh sách triệu tập ĐTQG, nhưng theo chuyên gia Đoàn Minh Xương, HLV Park Hang-seo đang cần sự ổn định để đối đầu với Thái Lan.
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
Tiền đạo: Văn Toàn (HAGL), Công Phượng (Incheon United), Quang Hải (Hà Nội FC), Anh Đức (B.Bình Dương), Đức Chinh (SHB Đà Nẵng).', '0', '6','8','0','0');

insert baiviet values ('BV004',N'8 điểm đến gần Hà Nội và dễ đi trong dịp 30/4','8 diem den gan Ha Noi va de di trong dip 30/4','DL001','2019-05-10','4','Chỉ mất từ một tới hai tiếng chạy xe, du khách có thể chọn cho mình những chuyến picnic ngắn ngày, hòa mình cùng thiên nhiên trong dịp nghỉ lễ.
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
Du khách cần chuẩn bị kỹ càng các vật dụng như lều trại, đồ nấu nướng do không có bất cứ dịch vụ nào trong bán kính khoảng 10 km quanh Đồng Cao.', '0', '9','8','0','0');



