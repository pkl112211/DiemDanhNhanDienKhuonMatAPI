USE [master]
GO
/****** Object:  Database [DB_DIEMDANH]    Script Date: 4/19/2020 2:48:30 PM ******/
CREATE DATABASE [DB_DIEMDANH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_DIEMDANH', FILENAME = N'C:\Users\anKiimation\DB_DIEMDANH.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DB_DIEMDANH_log', FILENAME = N'C:\Users\anKiimation\DB_DIEMDANH_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DB_DIEMDANH] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_DIEMDANH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_DIEMDANH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DB_DIEMDANH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_DIEMDANH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_DIEMDANH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DB_DIEMDANH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_DIEMDANH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DB_DIEMDANH] SET  MULTI_USER 
GO
ALTER DATABASE [DB_DIEMDANH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_DIEMDANH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_DIEMDANH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_DIEMDANH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB_DIEMDANH] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DB_DIEMDANH] SET QUERY_STORE = OFF
GO
USE [DB_DIEMDANH]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [DB_DIEMDANH]
GO
/****** Object:  Table [dbo].[ChiTietDiemDanh]    Script Date: 4/19/2020 2:48:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDiemDanh](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDChiTietNgayHoc] [int] NULL,
	[IDSinhVienTrongLopHoc] [int] NULL,
	[isDiemDanh] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietNgayHoc]    Script Date: 4/19/2020 2:48:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietNgayHoc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDLopHoc] [int] NULL,
	[thoiGianBatDauBuoiHoc] [smalldatetime] NOT NULL,
	[phongHoc] [varchar](5) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiangVien]    Script Date: 4/19/2020 2:48:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiangVien](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MSGV]  AS ('GV'+right('00000000'+CONVERT([varchar](8),[ID]),(8))) PERSISTED,
	[matKhau] [varchar](50) NOT NULL,
	[hoTen] [nvarchar](100) NOT NULL,
	[ngaySinh] [date] NOT NULL,
	[gioiTinh] [bit] NULL,
	[diaChi] [nvarchar](100) NULL,
	[soDienThoai] [varchar](15) NULL,
	[email] [varchar](50) NULL,
	[ghiChu] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopHoc]    Script Date: 4/19/2020 2:48:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopHoc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDMonHoc] [int] NULL,
	[IDGiangVien] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MonHoc]    Script Date: 4/19/2020 2:48:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonHoc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[tenMonHoc] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SinhVien]    Script Date: 4/19/2020 2:48:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SinhVien](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MSSV]  AS ('SV'+right('00000000'+CONVERT([varchar](8),[ID]),(8))) PERSISTED,
	[matKhau] [varchar](50) NOT NULL,
	[hoTen] [nvarchar](100) NOT NULL,
	[ngaySinh] [date] NOT NULL,
	[gioiTinh] [bit] NULL,
	[diaChi] [nvarchar](100) NULL,
	[soDienThoai] [varchar](15) NULL,
	[email] [varchar](50) NULL,
	[ghiChu] [nvarchar](max) NULL,
	[hasRegisteredFace] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SinhVienTrongLopHoc]    Script Date: 4/19/2020 2:48:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SinhVienTrongLopHoc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDLopHoc] [int] NULL,
	[IDSinhVien] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongBao]    Script Date: 4/19/2020 2:48:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongBao](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDLopHoc] [int] NOT NULL,
	[ngayTao] [smalldatetime] NOT NULL,
	[tieuDe] [nvarchar](max) NOT NULL,
	[noiDung] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ChiTietDiemDanh] ON 

INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (1, 22, 1, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (2, 22, 2, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (3, 22, 3, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (4, 22, 4, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (5, 22, 5, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (6, 22, 6, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (7, 22, 7, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (8, 22, 8, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (9, 22, 9, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (10, 22, 10, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (11, 23, 11, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (12, 23, 12, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (13, 23, 13, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (14, 23, 14, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (15, 23, 15, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (16, 23, 16, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (17, 23, 17, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (18, 23, 18, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (19, 23, 19, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (20, 23, 20, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (21, 38, 1, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (22, 38, 2, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (23, 38, 3, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (24, 38, 4, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (25, 38, 5, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (26, 38, 6, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (27, 38, 7, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (28, 38, 8, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (29, 38, 9, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (30, 38, 10, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (31, 28, 11, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (32, 28, 12, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (33, 28, 13, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (34, 28, 14, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (35, 28, 15, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (36, 28, 16, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (37, 28, 17, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (38, 28, 18, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (39, 28, 19, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (40, 28, 20, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (41, 26, 51, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (42, 26, 52, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (43, 26, 53, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (44, 26, 54, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (45, 26, 55, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (46, 26, 56, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (47, 26, 57, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (48, 26, 58, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (49, 26, 59, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (50, 26, 60, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (66, 23, 101, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (67, 39, 54, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (68, 39, 55, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (69, 39, 56, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (70, 39, 57, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (71, 39, 58, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (72, 39, 59, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (73, 39, 60, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (74, 39, 53, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (75, 40, 105, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (76, 40, 62, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (77, 40, 63, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (78, 40, 64, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (79, 40, 65, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (80, 40, 66, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (81, 40, 67, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (82, 40, 68, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (83, 40, 61, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (84, 40, 69, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (85, 39, 52, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (86, 39, 104, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (87, 41, 47, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (88, 41, 48, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (89, 41, 49, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (90, 41, 50, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (91, 26, 104, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (92, 31, 104, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (93, 31, 51, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (94, 39, 51, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (95, 31, 52, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (96, 31, 54, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (97, 31, 55, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (98, 31, 56, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (99, 31, 57, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (100, 31, 58, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (101, 31, 59, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (102, 31, 60, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (103, 31, 53, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (104, 40, 70, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (105, 27, 71, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (106, 27, 72, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (107, 33, 83, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (108, 33, 84, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (109, 33, 85, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (110, 33, 86, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (111, 33, 87, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (112, 33, 88, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (113, 33, 89, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (114, 33, 82, 1)
GO
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (115, 33, 90, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (116, 32, 92, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (117, 32, 93, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (118, 32, 94, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (119, 32, 95, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (120, 32, 96, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (121, 32, 97, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (122, 32, 98, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (123, 32, 91, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (124, 33, 81, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (125, 33, 103, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (126, 34, 80, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (127, 27, 73, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (128, 27, 74, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (129, 27, 75, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (130, 27, 76, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (131, 27, 77, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (132, 27, 78, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (133, 27, 79, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (134, 27, 80, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (135, 34, 71, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (136, 34, 72, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (137, 34, 73, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (138, 34, 74, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (139, 34, 75, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (140, 34, 76, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (141, 34, 77, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (142, 34, 78, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (143, 34, 79, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (144, 41, 46, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (145, 32, 99, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (146, 41, 45, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (147, 41, 43, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (148, 24, 26, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (149, 24, 27, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (150, 24, 28, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (151, 24, 29, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (152, 24, 30, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (153, 30, 21, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (154, 30, 22, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (155, 24, 25, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (156, 30, 23, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (157, 30, 25, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (158, 30, 26, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (159, 30, 27, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (160, 30, 28, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (161, 30, 29, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (162, 30, 30, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (163, 37, 21, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (164, 30, 24, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (165, 37, 22, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (166, 24, 24, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (167, 24, 22, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (168, 23, 102, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (169, 28, 101, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (170, 28, 102, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (171, 35, 101, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (172, 35, 11, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (173, 35, 12, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (174, 35, 13, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (175, 24, 23, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (176, 35, 14, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (177, 35, 16, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (178, 35, 17, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (179, 35, 18, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (180, 35, 19, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (181, 35, 20, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (182, 35, 102, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (183, 24, 21, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (184, 35, 15, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (185, 37, 23, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (186, 37, 24, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (187, 37, 25, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (188, 36, 37, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (189, 36, 38, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (190, 36, 39, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (191, 36, 40, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (192, 25, 41, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (193, 25, 42, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (194, 25, 43, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (195, 36, 36, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (196, 25, 44, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (197, 25, 46, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (198, 25, 47, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (199, 25, 48, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (200, 25, 49, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (201, 25, 50, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (202, 41, 41, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (203, 41, 42, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (204, 25, 45, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (205, 36, 35, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (206, 36, 34, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (207, 36, 33, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (208, 37, 26, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (209, 37, 27, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (210, 37, 28, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (211, 37, 29, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (212, 37, 30, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (213, 29, 31, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (214, 29, 32, 1)
GO
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (215, 29, 33, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (216, 29, 34, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (217, 29, 35, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (218, 29, 36, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (219, 29, 37, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (220, 29, 38, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (221, 29, 39, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (222, 29, 40, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (223, 36, 31, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (224, 36, 32, 1)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (225, 41, 44, 0)
INSERT [dbo].[ChiTietDiemDanh] ([ID], [IDChiTietNgayHoc], [IDSinhVienTrongLopHoc], [isDiemDanh]) VALUES (226, 32, 100, 1)
SET IDENTITY_INSERT [dbo].[ChiTietDiemDanh] OFF
SET IDENTITY_INSERT [dbo].[ChiTietNgayHoc] ON 

INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (22, 1, CAST(N'2020-03-09T07:00:00' AS SmallDateTime), N'A001')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (23, 2, CAST(N'2020-03-10T01:00:00' AS SmallDateTime), N'A003')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (24, 3, CAST(N'2020-03-09T07:00:00' AS SmallDateTime), N'A004')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (25, 5, CAST(N'2020-03-09T07:00:00' AS SmallDateTime), N'A007')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (26, 6, CAST(N'2020-03-11T01:00:00' AS SmallDateTime), N'A008')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (27, 8, CAST(N'2020-03-12T07:00:00' AS SmallDateTime), N'B002')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (28, 2, CAST(N'2020-03-10T07:00:00' AS SmallDateTime), N'B003')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (29, 4, CAST(N'2020-03-09T07:00:00' AS SmallDateTime), N'A006')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (30, 3, CAST(N'2020-03-09T01:00:00' AS SmallDateTime), N'B004')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (31, 6, CAST(N'2020-03-10T01:00:00' AS SmallDateTime), N'A005')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (32, 10, CAST(N'2020-03-13T01:00:00' AS SmallDateTime), N'B008')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (33, 9, CAST(N'2020-03-14T07:00:00' AS SmallDateTime), N'C009')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (34, 8, CAST(N'2020-03-12T07:00:00' AS SmallDateTime), N'B010')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (35, 2, CAST(N'2020-03-13T01:00:00' AS SmallDateTime), N'B005')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (36, 4, CAST(N'2020-03-11T07:00:00' AS SmallDateTime), N'C009')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (37, 3, CAST(N'2020-03-14T07:00:00' AS SmallDateTime), N'A010')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (38, 1, CAST(N'2020-03-09T01:00:00' AS SmallDateTime), N'C004')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (39, 6, CAST(N'2020-03-10T07:00:00' AS SmallDateTime), N'C001')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (40, 7, CAST(N'2020-03-13T07:00:00' AS SmallDateTime), N'C003')
INSERT [dbo].[ChiTietNgayHoc] ([ID], [IDLopHoc], [thoiGianBatDauBuoiHoc], [phongHoc]) VALUES (41, 5, CAST(N'2020-03-12T01:00:00' AS SmallDateTime), N'C009')
SET IDENTITY_INSERT [dbo].[ChiTietNgayHoc] OFF
SET IDENTITY_INSERT [dbo].[GiangVien] ON 

INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (1, N'123456', N'LÊ VĂN DŨNG', CAST(N'1980-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0976843167', N'levandung@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (2, N'123456', N'LÊ VĂN MINH', CAST(N'1981-02-28' AS Date), 1, N'Hà Nội', N'0978423584', N'levanminh@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (3, N'123456', N'NGUYỄN THỊ ÁNH', CAST(N'1981-03-29' AS Date), 0, N'An Giang', N'0978425667', N'nguyenthianh@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (4, N'123456', N'NGUYỄN THỊ DƯƠNG', CAST(N'1982-04-28' AS Date), 0, N'Tp. Hồ Chí Minh', N'0949154647', N'nguyenthiduong@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (5, N'123456', N'LÊ VĂN TUẤN', CAST(N'1982-05-27' AS Date), 1, N'Hà Nội', N'0947918354', N'levantuan@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (6, N'123456', N'LÊ VĂN TÚ', CAST(N'1983-06-26' AS Date), 1, N'Phú Yên', N'0947981564', N'levantu@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (7, N'123456', N'NGUYỄN THỊ CHI', CAST(N'1983-07-25' AS Date), 0, N'Tp. Hồ Chí Minh', N'0973519487', N'nguyenthichi@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (8, N'123456', N'NGUYỄN THỊ DUYÊN', CAST(N'1984-08-24' AS Date), 0, N'Hà Nội', N'0946188345', N'nguyenthiduyen@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (9, N'123456', N'LÊ VĂN THÁI', CAST(N'1984-09-23' AS Date), 1, N'An Giang', N'0979481384', N'levanthai@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (10, N'123456', N'LÊ VĂN KHOA', CAST(N'1985-10-22' AS Date), 1, N'Hà Nội', N'094324854', N'levankhoa@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (11, N'123456', N'NGUYỄN THỊ DUNG', CAST(N'1983-06-26' AS Date), 0, N'Tp. Hồ Chí Minh', N'099872645', N'nguyenthidung@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (12, N'123456', N'NGUYỄN THỊ HÀ', CAST(N'1983-07-25' AS Date), 0, N'Hà Nội', N'097498714', N'nguyenthiha@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (13, N'123456', N'LÊ VĂN KHÁNH', CAST(N'1984-08-24' AS Date), 1, N'Phú Yên', N'091174894', N'levankhanh@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (14, N'123456', N'LÊ VĂN KHANG', CAST(N'1984-09-23' AS Date), 1, N'Tp. Hồ Chí Minh', N'097864237', N'levankhang@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (15, N'123456', N'NGUYỄN THỊ HƯƠNG', CAST(N'1985-10-22' AS Date), 0, N'Hà Nội', N'096784237', N'nguyenthihuong@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (16, N'123456', N'NGUYỄN THỊ HÂN', CAST(N'1982-05-27' AS Date), 0, N'An Giang', N'099764518', N'nguyenthihan@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (17, N'123456', N'LÊ VĂN HƯNG', CAST(N'1982-04-28' AS Date), 1, N'Tp. Hồ Chí Minh', N'093214894', N'levanhung@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (18, N'123456', N'LÊ VĂN PHONG', CAST(N'1981-03-29' AS Date), 1, N'Hà Nội', N'096872616', N'levanphong@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (19, N'123456', N'NGUYỄN THỊ HOA', CAST(N'1981-02-28' AS Date), 0, N'Phú Yên', N'099756481', N'nguyenthihoa@gmail.com', NULL)
INSERT [dbo].[GiangVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu]) VALUES (20, N'123456', N'NGUYỄN THỊ LỆ', CAST(N'1980-01-30' AS Date), 0, N'Tp. Hồ Chí Minh', N'098848647', N'nguyenthile@gmail.com', NULL)
SET IDENTITY_INSERT [dbo].[GiangVien] OFF
SET IDENTITY_INSERT [dbo].[LopHoc] ON 

INSERT [dbo].[LopHoc] ([ID], [IDMonHoc], [IDGiangVien]) VALUES (1, 1, 1)
INSERT [dbo].[LopHoc] ([ID], [IDMonHoc], [IDGiangVien]) VALUES (2, 1, 2)
INSERT [dbo].[LopHoc] ([ID], [IDMonHoc], [IDGiangVien]) VALUES (3, 2, 3)
INSERT [dbo].[LopHoc] ([ID], [IDMonHoc], [IDGiangVien]) VALUES (4, 2, 5)
INSERT [dbo].[LopHoc] ([ID], [IDMonHoc], [IDGiangVien]) VALUES (5, 3, 7)
INSERT [dbo].[LopHoc] ([ID], [IDMonHoc], [IDGiangVien]) VALUES (6, 4, 8)
INSERT [dbo].[LopHoc] ([ID], [IDMonHoc], [IDGiangVien]) VALUES (7, 5, 10)
INSERT [dbo].[LopHoc] ([ID], [IDMonHoc], [IDGiangVien]) VALUES (8, 5, 11)
INSERT [dbo].[LopHoc] ([ID], [IDMonHoc], [IDGiangVien]) VALUES (9, 8, 13)
INSERT [dbo].[LopHoc] ([ID], [IDMonHoc], [IDGiangVien]) VALUES (10, 9, 15)
SET IDENTITY_INSERT [dbo].[LopHoc] OFF
SET IDENTITY_INSERT [dbo].[MonHoc] ON 

INSERT [dbo].[MonHoc] ([ID], [tenMonHoc]) VALUES (1, N'Công nghệ phần mềm')
INSERT [dbo].[MonHoc] ([ID], [tenMonHoc]) VALUES (2, N'Quản trị dự án phần mềm')
INSERT [dbo].[MonHoc] ([ID], [tenMonHoc]) VALUES (3, N'An ninh mạng')
INSERT [dbo].[MonHoc] ([ID], [tenMonHoc]) VALUES (4, N'Thương mại điện tử')
INSERT [dbo].[MonHoc] ([ID], [tenMonHoc]) VALUES (5, N'Lập trình mạng')
INSERT [dbo].[MonHoc] ([ID], [tenMonHoc]) VALUES (6, N'Lập trình hướng đối tượng')
INSERT [dbo].[MonHoc] ([ID], [tenMonHoc]) VALUES (7, N'Lập trình web')
INSERT [dbo].[MonHoc] ([ID], [tenMonHoc]) VALUES (8, N'An toàn thông tin')
INSERT [dbo].[MonHoc] ([ID], [tenMonHoc]) VALUES (9, N'Hệ quản trị cơ sở dữ liệu')
INSERT [dbo].[MonHoc] ([ID], [tenMonHoc]) VALUES (10, N'Lập trình thiết bị di động')
SET IDENTITY_INSERT [dbo].[MonHoc] OFF
SET IDENTITY_INSERT [dbo].[SinhVien] ON 

INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (1, N'123456', N'LÊ VĂN DŨNG', CAST(N'1996-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'levandung@gmail.com', NULL, 1)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (2, N'123456', N'LÊ VĂN MINH', CAST(N'1996-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0974597417', N'levanminh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (3, N'123456', N'LÊ VĂN TUẤN', CAST(N'1996-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0976783478', N'levantuan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (4, N'123456', N'LÊ VĂN TÚ', CAST(N'1996-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0974597418', N'levantu@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (5, N'123456', N'LÊ VĂN THÁI', CAST(N'1996-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0977547868', N'levanthai@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (6, N'123456', N'LÊ VĂN KHOA', CAST(N'1996-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0976786415', N'levankhoa@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (7, N'123456', N'LÊ VĂN KHÁNH', CAST(N'1996-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978643786', N'levankhanh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (8, N'123456', N'LÊ VĂN KHANG', CAST(N'1996-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0979527497', N'levankhang@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (9, N'123456', N'LÊ VĂN LONG', CAST(N'1996-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0975925978', N'levanlong@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (10, N'123456', N'LÊ VĂN HƯNG', CAST(N'1996-01-30' AS Date), 1, N'Tp. Hồ Chí Minh', N'0975927927', N'levanhung@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (11, N'123456', N'NGUYỄN THỊ ANH', CAST(N'1996-02-28' AS Date), 0, N'Hà Nội', N'0979279425', N'nguyenthianh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (12, N'123456', N'NGUYỄN THỊ CHÁNH', CAST(N'1996-02-28' AS Date), 0, N'Hà Nội', N'0979254623', N'nguyenthichanh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (13, N'123456', N'NGUYỄN THỊ CHI', CAST(N'1996-02-28' AS Date), 0, N'Hà Nội', N'0975294097', N'nguyenthichi@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (14, N'123456', N'NGUYỄN THỊ DUYÊN', CAST(N'1996-02-28' AS Date), 0, N'Hà Nội', N'0990712978', N'nguyenthiduyen@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (15, N'123456', N'NGUYỄN THỊ DUNG', CAST(N'1996-02-28' AS Date), 0, N'Hà Nội', N'0972167409', N'nguyenthidung@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (16, N'123456', N'NGUYỄN THỊ DƯƠNG', CAST(N'1996-02-28' AS Date), 0, N'Hà Nội', N'0960612778', N'nguyenthiduong@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (17, N'123456', N'NGUYỄN THỊ ĐAN', CAST(N'1996-02-28' AS Date), 0, N'Hà Nội', N'0972419607', N'nguyenthidan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (18, N'123456', N'NGUYỄN THỊ HOA', CAST(N'1996-02-28' AS Date), 0, N'Hà Nội', N'0975927094', N'nguyenthihoa@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (19, N'123456', N'NGUYỄN THỊ LAN', CAST(N'1996-02-28' AS Date), 0, N'Hà Nội', N'0912367458', N'nguyenthilan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (20, N'123456', N'NGUYỄN THỊ HÀ', CAST(N'1996-02-28' AS Date), 0, N'Hà Nội', N'0972970429', N'nguyenthiha@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (21, N'123456', N'NGUYỄN VĂN PHONG', CAST(N'1997-03-27' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'nguyenvanphong@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (22, N'123456', N'NGUYỄN VĂN KIÊN', CAST(N'1997-03-27' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'nguyenvankien@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (23, N'123456', N'NGUYỄN VĂN THANH', CAST(N'1997-03-27' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'nguyenvanthanh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (24, N'123456', N'NGUYỄN VĂN THẮNG', CAST(N'1997-03-27' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'nguyenvanthang@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (25, N'123456', N'NGUYỄN VĂN KHOA', CAST(N'1997-03-27' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'nguyenvankhoa@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (26, N'123456', N'NGUYỄN VĂN BÌNH', CAST(N'1997-03-27' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'nguyenvanbinh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (27, N'123456', N'NGUYỄN VĂN TÀI', CAST(N'1997-03-27' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'nguyenvantai@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (28, N'123456', N'NGUYỄN VĂN TOÀN', CAST(N'1997-03-27' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'nguyenvantoan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (29, N'123456', N'NGUYỄN VĂN TUẤN', CAST(N'1997-03-27' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'nguyenvantuan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (30, N'123456', N'NGUYỄN VĂN TRUNG', CAST(N'1997-03-27' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'nguyenvantrung@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (31, N'123456', N'LÊ THỊ HƯƠNG', CAST(N'1996-04-26' AS Date), 0, N'Phú Yên', N'0978644975', N'lethihuong@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (32, N'123456', N'LÊ THỊ HÂN', CAST(N'1996-04-26' AS Date), 0, N'Phú Yên', N'0978644975', N'lethihan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (33, N'123456', N'LÊ THỊ HÀ', CAST(N'1996-04-26' AS Date), 0, N'Phú Yên', N'0978644975', N'lethiha@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (34, N'123456', N'LÊ THỊ HOA', CAST(N'1996-04-26' AS Date), 0, N'Phú Yên', N'0978644975', N'lethihoa@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (35, N'123456', N'LÊ THỊ LÂM', CAST(N'1996-04-26' AS Date), 0, N'Phú Yên', N'0978644975', N'lethilam@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (36, N'123456', N'LÊ THỊ LỆ', CAST(N'1996-04-26' AS Date), 0, N'Phú Yên', N'0978644975', N'lethile@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (37, N'123456', N'LÊ THỊ NGÂN', CAST(N'1996-04-26' AS Date), 0, N'Phú Yên', N'0978644975', N'lethingan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (38, N'123456', N'LÊ THỊ NHUNG', CAST(N'1996-04-26' AS Date), 0, N'Phú Yên', N'0978644975', N'lethinhung@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (39, N'123456', N'LÊ THỊ TIÊN', CAST(N'1996-04-26' AS Date), 0, N'Phú Yên', N'0978644975', N'lethitien@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (40, N'123456', N'LÊ THỊ THƯ', CAST(N'1996-04-26' AS Date), 0, N'Phú Yên', N'0978644975', N'lethithu@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (41, N'123456', N'TRẦN VĂN PHÚC', CAST(N'1998-05-25' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'tranvanphuc@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (42, N'123456', N'TRẦN VĂN QUÂN', CAST(N'1998-05-25' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'tranvanquan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (43, N'123456', N'TRẦN VĂN DUY', CAST(N'1998-05-25' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'tranvanduy@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (44, N'123456', N'TRẦN VĂN BẢO', CAST(N'1998-05-25' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'tranvanbao@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (45, N'123456', N'TRẦN VĂN HUY', CAST(N'1998-05-25' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'tranvanhuy@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (46, N'123456', N'TRẦN VĂN HƯNG', CAST(N'1998-05-25' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'tranvanhung@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (47, N'123456', N'TRẦN VĂN KHÁNH', CAST(N'1998-05-25' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'tranvankhanh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (48, N'123456', N'TRẦN VĂN ĐĂNG', CAST(N'1998-05-25' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'tranvandang@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (49, N'123456', N'TRẦN VĂN NHIÊN', CAST(N'1998-05-25' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'tranvannhien@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (50, N'123456', N'TRẦN VĂN PHI', CAST(N'1998-05-25' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'tranvanphi@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (51, N'123456', N'TRẦN THỊ TÚ', CAST(N'1998-06-24' AS Date), 0, N'An Giang', N'0978644975', N'tranthitu@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (52, N'123456', N'TRẦN THỊ NHI', CAST(N'1998-06-24' AS Date), 0, N'An Giang', N'0978644975', N'tranthinhi@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (53, N'123456', N'TRẦN THỊ VŨ', CAST(N'1998-06-24' AS Date), 0, N'An Giang', N'0978644975', N'tranthivu@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (54, N'123456', N'TRẦN THỊ LAN', CAST(N'1998-06-24' AS Date), 0, N'An Giang', N'0978644975', N'tranthilan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (55, N'123456', N'TRẦN THỊ CHI', CAST(N'1998-06-24' AS Date), 0, N'An Giang', N'0978644975', N'tranthichi@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (56, N'123456', N'TRẦN THỊ YẾN', CAST(N'1998-06-24' AS Date), 0, N'An Giang', N'0978644975', N'tranthiyen@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (57, N'123456', N'TRẦN THỊ PHƯƠNG', CAST(N'1998-06-24' AS Date), 0, N'An Giang', N'0978644975', N'tranthiphuong@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (58, N'123456', N'TRẦN THỊ THUÝ', CAST(N'1998-06-24' AS Date), 0, N'An Giang', N'0978644975', N'tranthithuy@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (59, N'123456', N'TRẦN THỊ KHÁNH', CAST(N'1998-06-24' AS Date), 0, N'An Giang', N'0978644975', N'tranthikhanh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (60, N'123456', N'TRẦN THỊ QUỲNH', CAST(N'1998-06-24' AS Date), 0, N'An Giang', N'0978644975', N'tranthiquynh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (61, N'123456', N'VŨ VĂN CƯỜNG', CAST(N'1999-07-23' AS Date), 1, N'Hà Nội', N'0978644975', N'vuvancuong@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (62, N'123456', N'VŨ VĂN HOÀNG', CAST(N'1999-07-23' AS Date), 1, N'Hà Nội', N'0978644975', N'vuvanhoang@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (63, N'123456', N'VŨ VĂN ĐẠT', CAST(N'1999-07-23' AS Date), 1, N'Hà Nội', N'0978644975', N'vuvandat@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (64, N'123456', N'VŨ VĂN NGHĨA', CAST(N'1999-07-23' AS Date), 1, N'Hà Nội', N'0978644975', N'vuvannghia@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (65, N'123456', N'VŨ VĂN PHƯỚC', CAST(N'1999-07-23' AS Date), 1, N'Hà Nội', N'0978644975', N'vuvanphuoc@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (66, N'123456', N'VŨ VĂN TÂM', CAST(N'1999-07-23' AS Date), 1, N'Hà Nội', N'0978644975', N'vuvantam@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (67, N'123456', N'VŨ VĂN THIỆN', CAST(N'1999-07-23' AS Date), 1, N'Hà Nội', N'0978644975', N'vuvanthien@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (68, N'123456', N'VŨ VĂN VĂN', CAST(N'1999-07-23' AS Date), 1, N'Hà Nội', N'0978644975', N'vuvanvan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (69, N'123456', N'VŨ VĂN NGUYÊN', CAST(N'1999-07-23' AS Date), 1, N'Hà Nội', N'0978644975', N'vuvannguyen@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (70, N'123456', N'VŨ VĂN VĨ', CAST(N'1999-07-23' AS Date), 1, N'Hà Nội', N'0978644975', N'vuvanvi@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (71, N'123456', N'VŨ THỊ ÁI', CAST(N'1999-08-22' AS Date), 0, N'Đà Nẵng', N'0978644975', N'vuthiai@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (72, N'123456', N'VŨ THỊ NHƯ', CAST(N'1999-08-22' AS Date), 0, N'Đà Nẵng', N'0978644975', N'vuthinhu@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (73, N'123456', N'VŨ THỊ TÚ', CAST(N'1999-08-22' AS Date), 0, N'Đà Nẵng', N'0978644975', N'vuthitu@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (74, N'123456', N'VŨ THỊ MIÊN', CAST(N'1999-08-22' AS Date), 0, N'Đà Nẵng', N'0978644975', N'vuthimien@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (75, N'123456', N'VŨ THỊ BÍCH', CAST(N'1999-08-22' AS Date), 0, N'Đà Nẵng', N'0978644975', N'vuthibich@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (76, N'123456', N'VŨ THỊ TRÀM', CAST(N'1999-08-22' AS Date), 0, N'Đà Nẵng', N'0978644975', N'vuthitram@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (77, N'123456', N'VŨ THỊ CHI', CAST(N'1999-08-22' AS Date), 0, N'Đà Nẵng', N'0978644975', N'vuthichi@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (78, N'123456', N'VŨ THỊ DIỆP', CAST(N'1999-08-22' AS Date), 0, N'Đà Nẵng', N'0978644975', N'vuthidiep@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (79, N'123456', N'VŨ THỊ KIM', CAST(N'1999-08-22' AS Date), 0, N'Đà Nẵng', N'0978644975', N'vuthikim@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (80, N'123456', N'VŨ THỊ LAN', CAST(N'1999-08-22' AS Date), 0, N'Đà Nẵng', N'0978644975', N'vuthilan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (81, N'123456', N'PHAN VĂN HÙNG', CAST(N'2000-09-21' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'phanvanhung@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (82, N'123456', N'PHAN VĂN KHÔI', CAST(N'2000-09-21' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'phanvankhoi@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (83, N'123456', N'PHAN VĂN ANH', CAST(N'2000-09-21' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'phanvananh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (84, N'123456', N'PHAN VĂN ĐỨC', CAST(N'2000-09-21' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'phanvanduc@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (85, N'123456', N'PHAN VĂN KHANG', CAST(N'2000-09-21' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'phanvankhang@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (86, N'123456', N'PHAN VĂN KHÔI', CAST(N'2000-09-21' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'phanvankhoi@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (87, N'123456', N'PHAN VĂN NHẬT', CAST(N'2000-09-21' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'phanvannhat@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (88, N'123456', N'PHAN VĂN QUANG', CAST(N'2000-09-21' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'phanvanquang@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (89, N'123456', N'PHAN VĂN QUÂN', CAST(N'2000-09-21' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'phanvanquan@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (90, N'123456', N'PHAN VĂN TRIẾT', CAST(N'2000-09-21' AS Date), 1, N'Tp. Hồ Chí Minh', N'0978644975', N'phanvantriet@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (91, N'123456', N'PHAN THỊ NGỌC', CAST(N'2000-10-20' AS Date), 0, N'Hà Nội', N'0978644975', N'phanthingoc@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (92, N'123456', N'PHAN THỊ PHƯƠNG', CAST(N'2000-10-20' AS Date), 0, N'Hà Nội', N'0978644975', N'phanthiphuong@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (93, N'123456', N'PHAN THỊ LINH', CAST(N'2000-10-20' AS Date), 0, N'Hà Nội', N'0978644975', N'phanthilinh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (94, N'123456', N'PHAN THỊ ANH', CAST(N'2000-10-20' AS Date), 0, N'Hà Nội', N'0978644975', N'phanthianh@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (95, N'123456', N'PHAN THỊ GIANG', CAST(N'2000-10-20' AS Date), 0, N'Hà Nội', N'0978644975', N'phanthigiang@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (96, N'123456', N'PHAN THỊ MẪN', CAST(N'2000-10-20' AS Date), 0, N'Hà Nội', N'0978644975', N'phanthiman@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (97, N'123456', N'PHAN THỊ NHI', CAST(N'2000-10-20' AS Date), 0, N'Hà Nội', N'0978644975', N'phanthinhi@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (98, N'123456', N'PHAN THỊ HÀ', CAST(N'2000-10-20' AS Date), 0, N'Hà Nội', N'0978644975', N'phanthiha@gmail.com', NULL, NULL)
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (99, N'123456', N'PHAN THỊ TÂM', CAST(N'2000-10-20' AS Date), 0, N'Hà Nội', N'0978644975', N'phanthitam@gmail.com', NULL, NULL)
GO
INSERT [dbo].[SinhVien] ([ID], [matKhau], [hoTen], [ngaySinh], [gioiTinh], [diaChi], [soDienThoai], [email], [ghiChu], [hasRegisteredFace]) VALUES (100, N'123456', N'PHAN THỊ CHI', CAST(N'2000-10-20' AS Date), 0, N'Hà Nội', N'0978644975', N'phanthichi@gmail.com', NULL, NULL)
SET IDENTITY_INSERT [dbo].[SinhVien] OFF
SET IDENTITY_INSERT [dbo].[SinhVienTrongLopHoc] ON 

INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (1, 1, 1)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (2, 1, 2)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (3, 1, 3)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (4, 1, 4)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (5, 1, 5)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (6, 1, 6)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (7, 1, 7)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (8, 1, 8)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (9, 1, 9)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (10, 1, 10)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (101, 2, 1)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (11, 2, 11)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (12, 2, 12)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (13, 2, 13)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (14, 2, 14)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (15, 2, 15)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (16, 2, 16)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (17, 2, 17)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (18, 2, 18)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (19, 2, 19)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (20, 2, 20)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (102, 2, 40)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (21, 3, 21)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (22, 3, 22)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (23, 3, 23)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (24, 3, 24)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (25, 3, 25)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (26, 3, 26)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (27, 3, 27)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (28, 3, 28)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (29, 3, 29)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (30, 3, 30)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (31, 4, 31)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (32, 4, 32)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (33, 4, 33)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (34, 4, 34)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (35, 4, 35)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (36, 4, 36)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (37, 4, 37)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (38, 4, 38)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (39, 4, 39)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (40, 4, 40)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (41, 5, 41)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (42, 5, 42)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (43, 5, 43)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (44, 5, 44)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (45, 5, 45)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (46, 5, 46)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (47, 5, 47)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (48, 5, 48)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (49, 5, 49)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (50, 5, 50)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (104, 6, 1)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (51, 6, 51)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (52, 6, 52)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (53, 6, 53)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (54, 6, 54)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (55, 6, 55)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (56, 6, 56)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (57, 6, 57)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (58, 6, 58)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (59, 6, 59)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (60, 6, 60)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (105, 7, 1)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (61, 7, 61)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (62, 7, 62)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (63, 7, 63)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (64, 7, 64)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (65, 7, 65)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (66, 7, 66)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (67, 7, 67)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (68, 7, 68)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (69, 7, 69)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (70, 7, 70)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (71, 8, 71)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (72, 8, 72)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (73, 8, 73)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (74, 8, 74)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (75, 8, 75)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (76, 8, 76)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (77, 8, 77)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (78, 8, 78)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (79, 8, 79)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (80, 8, 80)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (103, 9, 1)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (81, 9, 81)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (82, 9, 82)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (83, 9, 83)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (84, 9, 84)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (85, 9, 85)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (86, 9, 86)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (87, 9, 87)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (88, 9, 88)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (89, 9, 89)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (90, 9, 90)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (91, 10, 91)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (92, 10, 92)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (93, 10, 93)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (94, 10, 94)
GO
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (95, 10, 95)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (96, 10, 96)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (97, 10, 97)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (98, 10, 98)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (99, 10, 99)
INSERT [dbo].[SinhVienTrongLopHoc] ([ID], [IDLopHoc], [IDSinhVien]) VALUES (100, 10, 100)
SET IDENTITY_INSERT [dbo].[SinhVienTrongLopHoc] OFF
SET IDENTITY_INSERT [dbo].[ThongBao] ON 

INSERT [dbo].[ThongBao] ([ID], [IDLopHoc], [ngayTao], [tieuDe], [noiDung]) VALUES (6, 1, CAST(N'2020-04-19T14:02:00' AS SmallDateTime), N'thong bao di hoc lai(Cập nhật 4/19/2020 2:02:55 PM)', N'anh em nghi hoc nhe')
INSERT [dbo].[ThongBao] ([ID], [IDLopHoc], [ngayTao], [tieuDe], [noiDung]) VALUES (7, 1, CAST(N'2020-04-19T14:24:00' AS SmallDateTime), N'thong bao di hoc lai', N'anh em nghi hoc nhe')
SET IDENTITY_INSERT [dbo].[ThongBao] OFF
/****** Object:  Index [UQ__ChiTietD__A74B4C12C7FEADF6]    Script Date: 4/19/2020 2:48:30 PM ******/
ALTER TABLE [dbo].[ChiTietDiemDanh] ADD UNIQUE NONCLUSTERED 
(
	[IDChiTietNgayHoc] ASC,
	[IDSinhVienTrongLopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__ChiTietD__A74B4C12F3DA21C7]    Script Date: 4/19/2020 2:48:30 PM ******/
ALTER TABLE [dbo].[ChiTietDiemDanh] ADD UNIQUE NONCLUSTERED 
(
	[IDChiTietNgayHoc] ASC,
	[IDSinhVienTrongLopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__SinhVien__F275A50165F00B8D]    Script Date: 4/19/2020 2:48:30 PM ******/
ALTER TABLE [dbo].[SinhVienTrongLopHoc] ADD UNIQUE NONCLUSTERED 
(
	[IDLopHoc] ASC,
	[IDSinhVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ThongBao] ADD  DEFAULT (getdate()) FOR [ngayTao]
GO
ALTER TABLE [dbo].[ChiTietDiemDanh]  WITH CHECK ADD FOREIGN KEY([IDChiTietNgayHoc])
REFERENCES [dbo].[ChiTietNgayHoc] ([ID])
GO
ALTER TABLE [dbo].[ChiTietDiemDanh]  WITH CHECK ADD FOREIGN KEY([IDSinhVienTrongLopHoc])
REFERENCES [dbo].[SinhVienTrongLopHoc] ([ID])
GO
ALTER TABLE [dbo].[ChiTietNgayHoc]  WITH CHECK ADD FOREIGN KEY([IDLopHoc])
REFERENCES [dbo].[LopHoc] ([ID])
GO
ALTER TABLE [dbo].[LopHoc]  WITH CHECK ADD FOREIGN KEY([IDGiangVien])
REFERENCES [dbo].[GiangVien] ([ID])
GO
ALTER TABLE [dbo].[LopHoc]  WITH CHECK ADD FOREIGN KEY([IDMonHoc])
REFERENCES [dbo].[MonHoc] ([ID])
GO
ALTER TABLE [dbo].[SinhVienTrongLopHoc]  WITH CHECK ADD FOREIGN KEY([IDLopHoc])
REFERENCES [dbo].[LopHoc] ([ID])
GO
ALTER TABLE [dbo].[SinhVienTrongLopHoc]  WITH CHECK ADD FOREIGN KEY([IDSinhVien])
REFERENCES [dbo].[SinhVien] ([ID])
GO
ALTER TABLE [dbo].[ThongBao]  WITH CHECK ADD FOREIGN KEY([IDLopHoc])
REFERENCES [dbo].[LopHoc] ([ID])
GO
USE [master]
GO
ALTER DATABASE [DB_DIEMDANH] SET  READ_WRITE 
GO
