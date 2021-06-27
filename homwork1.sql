
CREATE DATABASE IF NOT EXISTS QLBanSach;

USE QLBanSach;
CREATE TABLE khach_hang (
	MaKH char(10),
    TaiKhoan varchar(50),
    MatKhau varchar(50),
    Email varchar(50),
    DiaChi nvarchar(50),
    HoTen nvarchar(50),
    NgaySinh date,
    GioiTinh nvarchar(10),
    DienThoai varchar(20),
    PRIMARY KEY(MaKH)
);

CREATE TABLE don_hang ( 
	MaDonHang char(10),
    MaKH char(10),
    MaSach char(10),
    SoLuong int,
    DonGia varchar(50),
    TinhTrangGH varchar(50),
    NgayDat date,
    NgayGiao date,
    PRIMARY KEY(MaDonHang)
);

CREATE TABLE sach (
	MaSach char(10),
    MaTacGia char(10),
    MaNSX char(10),
    MaChuDe char(10),
    TenSach nvarchar(50),
    GiaBan varchar(50),
    MoTa nvarchar(50),
    AnhBia varchar(50),
    NgayCapNhat date,
    SoLuongTon int,
    PRIMARY KEY(MaSach)
);

CREATE TABLE tac_gia (
	MaTacGia char(10),
    TenTacGia nvarchar(50),
    DiaChi nvarchar(50),
    TieuSu nvarchar(50),
    DienThoai varchar(20),
    VaiTro nvarchar(50),
    Vitri nvarchar(50),
    PRIMARY KEY(MaTacGia)
);

CREATE TABLE chu_de (
	MaChuDe char(10),
    TenChuDe nvarchar(50),
    PRIMARY KEY (MaChuDe)
);

CREATE TABLE nha_xuat_ban (
	MaNSX char(10),
    TenNSB nvarchar(50),
    DiaChi nvarchar(50),
    DienThoai varchar(20),
    PRIMARY KEY (MaNSX)
);

alter table don_hang 
			add constraint FK_DON_HANG_KHACH_HANG
				foreign key (MaKH)
                references khach_hang(MaKH);
                
alter table don_hang
			add constraint FK_DON_HANG_SACH
				foreign key (MaSach)
				references sach(MaSach);
		
alter table sach 
			add constraint FK_GIA_SACH_TAC
				foreign key (MaTacGia)
                references tac_gia(MaTacGia);
                
alter table sach
			add constraint FK_SACH_NHA_XUAT_BAN
				foreign key (MaNSX)
                references nha_xuat_ban(MaNSX);
                
alter table sach
			add constraint FK_SACH_CHU_DE
				foreign key (MaChuDe)
                references chu_de(MaChuDe);
