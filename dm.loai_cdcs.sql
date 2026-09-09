-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[loai_cdcs]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.loai_cdcs (        
        id SMALLINT IDENTITY(1,1) PRIMARY KEY,
        ma varchar(4) not null UNIQUE,
        ten nvarchar(100),
        ma_cha char(2),        
        loai int,
        stt tinyint,
        stt_bc tinyint,
        [trang_thai]    TINYINT NOT NULL DEFAULT 1,         -- 1: Hoạt động, 0: Khóa      
        -- Quản lý dữ liệu hệ thống (Audit Fields)
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                int NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                int NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                int NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0                   -- 0: Dùng, 1: Xóa mềm                
    );
END
GO
SET IDENTITY_INSERT dm.loai_cdcs ON;

INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (1, N'10', N'Hưu trí', NULL, N'1', N'1', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (2, N'03', N'Phục viên', N'', N'1', N'3', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (3, N'04', N'Xuất ngũ', N'', N'1', N'4', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (7, N'40', N'Tai nạn lao động hàng tháng', NULL, N'4', N'1', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (17, N'02', N'Thôi việc', NULL, N'1', N'2', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (18, N'08', N'Tuất 1 lần', NULL, N'1', N'5', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (23, N'07', N'Tuất hằng tháng', NULL, N'1', N'6', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (24, N'93', N'Hủy hồ sơ', NULL, N'1', N'14', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (27, N'DS', N'Dưỡng sức', NULL, N'3', NULL, NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (28, N'OM', N'Ốm đau', NULL, N'3', NULL, NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (29, N'TS', N'Thai sản', NULL, N'3', NULL, NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (31, N'99', N'Cấp tiền mua phương tiện, dụng cụ', NULL, N'1', N'13', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (32, N'39', N'Tai nạn lao động một lần', NULL, N'1', N'8', NULL);

INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (87, N'42', N'Tai nạn lao động một lần do tái phát', NULL, N'1', N'8', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (88, N'43', N'Tai nạn lao động hằng tháng do tái phát', NULL, N'4', N'3', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (89, N'44', N'Tai nạn lao động một lần do giám định tổng hợp', NULL, N'1', N'8', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (90, N'45', N'Tai nạn lao động hằng tháng giám định tổng hợp', NULL, N'4', N'4', NULL);

INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (33, N'49', N'Bệnh nghề nghiệp một lần', NULL, N'1', N'11', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (42, N'50', N'Bệnh nghề nghiệp hằng tháng', NULL, N'4', N'2', NULL);

INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (91, N'52', N'Bệnh nghề nghiệp một lần do tái phát', NULL, N'1', N'8', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (92, N'53', N'Bệnh nghề nghiệp hằng tháng do tái phát', NULL, N'4', N'5', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (93, N'54', N'Bệnh nghề nghiệp một lần do giám định tổng hợp', NULL, N'1', N'8', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (94, N'55', N'Bệnh nghề nghiệp hằng tháng giám định tổng hợp', NULL, N'4', N'6', NULL);

INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (52, N'O', N'Ốm đau', N'OM', N'3', NULL, 1);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (53, N'O1', N'Bản thân ốm', N'OM', N'3', N'1', 2);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (54, N'O2', N'Con ốm', N'OM', N'3', N'3', 3);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (55, N'O3', N'Ốm dài ngày', N'OM', N'3', N'2', 4);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (56, N'T', N'Thai sản', N'TS', N'3', NULL, 5);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (57, N'T1', N'Khám thai', N'TS', N'3', N'4', 6);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (58, N'T2', N'Sẩy thai, nạo thai, thai chết lưu', N'TS', N'3', N'5', 7);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (59, N'T3', N'Biện pháp KHH', N'TS', N'3', N'14', 8);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (60, N'T4', N'Sinh con', N'TS', N'3', N'6', 9);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (61, N'T6', N'Con chết sau khi sinh', N'TS', N'3', N'7', 10);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (62, N'T7', N'Mẹ chết, gặp rủi ro sau khi sinh', N'TS', N'3', N'9', 11);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (63, N'T8', N'Nuôi con nuôi', N'TS', N'3', N'8', 12);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (64, N'T10', N'Mang thai hộ', N'TS', N'3', N'10', 13);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (65, N'T11', N'Nhờ mang thai hộ', N'TS', N'3', N'11', 14);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (66, N'T12', N'Nam nghỉ việc khi vợ sinh', N'TS', N'3', N'12', 15);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (67, N'T13', N'Nam hưởng trợ cấp 1 lần khi vợ sinh', N'TS', N'3', N'13', 16);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (68, N'D', N'Dưỡng sức', N'DS', N'3', NULL, 17);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (69, N'D203', N'Dưỡng sức sau sinh khác', N'DS', N'3', NULL, 22);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (70, N'D202', N'Dưỡng sức sau sinh phẫu thuật', N'DS', N'3', NULL, 23);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (71, N'D201', N'Dưỡng sức sau sinh từ 2 con trở lên', N'DS', N'3', NULL, 24);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (72, N'D204', N'Dưỡng sức sau sẩy, nạo, hút thai', N'DS', N'3', NULL, 25);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (73, N'D103', N'Dưỡng sức sau ốm khác', N'DS', N'3', NULL, 26);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (74, N'D101', N'Dưỡng sức ốm dài ngày', N'DS', N'3', NULL, 27);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (75, N'D102', N'Dưỡng sức sau phẫu thuật', N'DS', N'3', NULL, 28);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (76, N'D301', N'Suy giảm khả năng lao động tỉ lệ >= 51%', N'DS', N'3', NULL, 29);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (77, N'D302', N'Suy giảm khả năng lao động tỉ lệ từ 31% đến 50%', N'DS', N'3', NULL, 30);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (78, N'D303', N'Suy giảm khả năng lao động tỉ lệ từ 15% đến 30%', N'DS', N'3', NULL, 31);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (79, N'D1', N'Dưỡng sức sau ốm', N'DS', N'3', N'17', 19);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (80, N'D2', N'Dưỡng sức sau thai sản', N'DS', N'3', N'18', 20);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (81, N'D3', N'Dưỡng sức sau TNLĐ', N'DS', N'3', N'19', 21);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (82, N'41', N'Giới thiệu giám định TNLĐ', NULL, N'1', N'7', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (83, N'51', N'Giới thiệu giám định BNN', NULL, N'1', N'10', NULL);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (85, N'T14', N'Sinh con có chỉ định dưỡng thai', N'TS', N'3', N'15', 17);
INSERT INTO dm.loai_cdcs (id,ma, ten,ma_cha,loai,stt,stt_bc) VALUES (86, N'T15', N'Sinh con có điều trị vô sinh', N'TS', N'3', N'16', 18);

SET IDENTITY_INSERT dm.loai_cdcs OFF;
GO

