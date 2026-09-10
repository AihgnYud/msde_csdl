-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[cap_bac]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.cap_bac (        
        id SMALLINT IDENTITY(1,1) PRIMARY KEY,
        ma char(2) not null UNIQUE,
        ten nvarchar(50),
        loai_dt_id smallint,                
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
--SET IDENTITY_INSERT dm.cap_bac ON;
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'B1', N'Binh nhất', 4);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'B2', N'Binh nhì', 4);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'H1', N'Hạ sỹ', 4);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'H2', N'Trung sỹ', 4);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'H3', N'Thượng sỹ', 4);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'36', N'Thiếu úy QNCN', 2);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'37', N'Trung úy QNCN', 2);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'38', N'Thượng úy QNCN', 2);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'39', N'Đại úy QNCN', 2);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'40', N'Thiếu tá QNCN', 2);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'41', N'Trung tá QNCN', 2);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'42', N'Thượng tá QNCN', 2);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'55', N'Thượng sỹ QNCN', 2);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'11', N'Thiếu úy', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'12', N'Trung úy', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'13', N'Thượng úy', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'14', N'Đại úy', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'21', N'Thiếu tá', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'22', N'Trung tá', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'23', N'Thượng tá', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'24', N'Đại tá', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'31', N'Thiếu tướng', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'32', N'Trung tướng', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'33', N'Thượng tướng', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'34', N'Đại tướng', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'43', N'Thượng úy NLL1', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'44', N'Đại úy NLL1', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'45', N'Thiếu tá NLL1', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'46', N'Trung tá NLL1', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'47', N'Thượng tá NLL1', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'48', N'Đại tá NLL1', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'49', N'Thượng úy NLL2', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'50', N'Đại úy NLL2', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'51', N'Thiếu tá NLL2', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'52', N'Trung tá NLL2', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'53', N'Thượng tá NLL2', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'54', N'Đại tá NLL2', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'56', N'Thiếu tướng NL', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'57', N'Trung tướng NL', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'58', N'Thượng tướng NL', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'59', N'Đại tướng NL', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'60', N'Chuẩn đô đốc', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'61', N'Phó Đô đốc', 1);
INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'62', N'Đô đốc', 1);
--INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'B1', N'Binh nhất', 31);
--INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'B2', N'Binh nhì', 31);
--INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'H1', N'Hạ sỹ', 31);
--INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'H2', N'Trung sỹ', 31);
--INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'H3', N'Thượng sỹ', 31);
--INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'B1', N'Binh nhất', 6);
--INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'B2', N'Binh nhì', 6);
---INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'H1', N'Hạ sỹ', 6);
--INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'H2', N'Trung sỹ', 6);
--INSERT INTO dm.cap_bac (ma, ten,loai_dt_id) VALUES (N'H3', N'Thượng sỹ', 6);
--SET IDENTITY_INSERT dm.cap_bac OFF;
GO

