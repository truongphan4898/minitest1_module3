drop database if exists QuanLyTourDuLich;
create database if not exists QuanLyTourDuLich;

use QuanLyTourDuLich;

create table Destination (
IDDestination int auto_increment primary key not null,
DestinationName nvarchar(50) not null,
Description text,
Price float not null,
MaTp int not null);
insert into Destination( DestinationName, Price, MaTp) value ('Vinh Ha Long', 5000, 101),('Dao Phu Quy', 3000, 102),
('Nha Trang', 4000, 103), ('Mai Chau', 2000, 104), ('Dong Phong Nha', 3000, 105);

create table Client(
IDkh int auto_increment primary key not null,
Namekh nvarchar(50) not null,
SoCanCuoc nvarchar(20) unique not null,
NamSinh date not null, 
MaTp int not null);
insert into Client( Namekh, SoCanCuoc, NamSinh, MaTp) value ('Phat', '0905123', '1998-09-08', 101),
('Co','0905124', '1998-02-03', 101), ('Nam', '0905125', '1997-04-05', 102), ('Toan', '0905126', '1998-03-06',103),
('An', '0905127', '1998-12-16',104), ('Nghia', '0906123','2000-04-07',104), ('Tien', '0906124', '2000-06-09',105),
('Sy', '0907123', '2001-01-02', 102), ('Hieu','0904123', '1995-01-02', 105),('Lap', '0901123','1993-01-02',104); 

create table ThanhPho(
MaTp int primary key not null,
TenTp nvarchar(50) not null);
insert into ThanhPho(MaTp, TenTP) value (101, 'Quang Ninh'), (102, 'Phan Thiet'), (103,'Khanh Hoa'), (104, 'Hoa Binh'),
(105,'Quang Binh');

create table Tour(
ID int auto_increment primary key not null,
MaTour varchar(25) not null,
MaLoaiTour int not null,
Price float not null,
IDDestination int not null,
DateStart date not null,
DateEnd date not null);
insert into Tour( MaTour, MaLoaiTour, Price,IDDestination, DateStart, DateEnd) value ('HL1', 509, 5000,1, '2020-03-04', '2020-03-20'),
('HL2', 510, 6000,1, '2020-04-05', '2020-04-20'), ('HL3',510,6000,1, '2020-04-10','2020-04-25'),
('PQ1', 509, 3000,2, '2020-03-04', '2020-03-20'),
('PQ2', 510, 4000,2, '2020-04-05', '2020-04-20'), ('PQ3',510,6000,2, '2020-04-10','2020-04-25'),
('NT1', 509, 4000,3, '2020-03-04', '2020-03-20'),
('NT2', 510, 5000,3, '2020-04-05', '2020-04-20'), ('NT3',510,5000,3, '2020-04-10','2020-04-25'),
('MC1', 509, 2000,4, '2020-03-04', '2020-03-20'),
('MC2', 510, 3000,4, '2020-04-05', '2020-04-20'), ('MC3',510,3000,4, '2020-04-10','2020-04-25'),
('PN1', 509, 3000,5, '2020-03-04', '2020-03-20'),
('PN2', 510, 4000,5, '2020-04-05', '2020-04-20'), ('PN3',510,4000,5, '2020-04-10','2020-04-25');
ALTER TABLE Tour
ADD INDEX idx_MaTour (MaTour);
drop table Tour;
select * from Tour;

create table LoaiTour(
ID int auto_increment primary key not null,
MaLoaiTour int not null,
TenLoaiTour nvarchar(50));
insert into LoaiTour(MaLoaiTour, TenLoaiTour) value (509,'Du lich Sinh Thai'),(510, 'Du lich Nghi Duong');
drop table LoaiTour;
ALTER TABLE LoaiTour
ADD INDEX idx_MaLoaiTour (MaLoaiTour);

create table OrderTour(
Id int auto_increment primary key not null,
MaTour varchar(25) not null,
IDkh int not null,
TrangThai varchar(100));
insert into OrderTour(MaTour, IDkh) value ('HL1', 1), ('PN3', 1), ('HL3', 3), ('NT1', 3), ('MC2',4), ('MC2', 5),
('MC2', 6), ('MC2', 7),('MC2', 8), ('MC2', 9);

alter table OrderTour add constraint fk_MaTour foreign key (MaTour) references Tour (MaTour);
alter table OrderTour add constraint fk_IDkh foreign key (IDkh) references Client (IDkh);

alter table Client add constraint fk_MaTP foreign key (MaTp) references ThanhPho (MaTp);

alter table Tour add constraint fk_MaLoaiTour foreign key (MaLoaiTour) references LoaiTour (MaLoaiTour);
alter table Tour add constraint fk_IDDestination foreign key (IDDestination) references Destination(IDDestination);

alter table Destination add constraint fk_MaTp_Destination foreign key (MaTp) references ThanhPho (MaTp);

select TP.TenTp as TenThanhPho, count(T.ID) as SoLuongTour
from ThanhPho TP
left join Destination D on TP.MaTp = D.MaTp
left join Tour T on D.IDDestination = T.IDDestination
group by TP.TenTp;

select count(ID) as SoLuongTourTrongThang3
from Tour
where month(DateStart) = 3;

select count(ID) as SoTourKetThucTrongThang4
from Tour
where month(DateEnd) = 4;

