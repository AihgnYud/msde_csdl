-- 1. Tạo Schema hs (Hồ sơ) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'hs')
BEGIN
    EXEC('CREATE SCHEMA hs');
END
GO
-- 2. Tạo Bảng hs.import_chi_tiet

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[hs].[import_chi_tiet]') AND type in (N'U'))
BEGIN
   CREATE TABLE hs.import_chi_tiet (
            [id]                    BIGINT IDENTITY(1,1) PRIMARY KEY,
            [ma]         VARCHAR(50) NOT NULL UNIQUE,     -- Mã đợt import sinh tự động cấu trúc: IMP_NĂM_LOẠIHS_MÃ ĐV_Số đợt, ví dụ: IMP_2026_TNLDBNN_0760_01 (số đợt theo loại hồ sơ, năm, mã đơn vị)
            [import_dot_id]         INT NOT NULL,                    -- FK trỏ hs.import_dot
            [stt_dong]              INT NOT NULL,                    -- Số dòng tương ứng trong file Excel

            -- Các trường định danh dùng chung
            [ho_ten]                NVARCHAR(150) NOT NULL,
            [so_cccd]               CHAR(12) NULL,
            [ma_so_bhxh]            VARCHAR(12) NOT NULL,
            [ngay_sinh]             tinyint NULL,                -- 
            [thang_sinh]             tinyint NULL,                -- 
            [nam_sinh]             smallint NULL,                -- 

            -- Dữ liệu động theo từng loại hồ sơ (lưu định dạng JSON)
            [du_lieu_chi_tiet_json] NVARCHAR(MAX) NULL,             -- VD: {"ngay_tai_nan": "2026-05-10", "tien_luong": 15000000}

            -- Quản lý trạng thái & lỗi
            [trang_thai_dong]       TINYINT DEFAULT 0,               -- 0: Bị lỗi, 1: Hợp lệ
            [danh_sach_loi_json]    NVARCHAR(MAX) NULL,              -- VD: {"ngay_sinh": "Ngày sinh không đúng định dạng dd/mm/yyyy"}
            CONSTRAINT FK_ImportChiTiet_Dot FOREIGN KEY ([import_dot_id]) REFERENCES dm.import_dot([id])
        );
END
GO
--SET IDENTITY_INSERT dm.import_chi_tiet ON;

--SET IDENTITY_INSERT dm.import_chi_tiet OFF;
GO

--TINYINT: 1 byte (0 đến 255) $\leftarrow$ Nhỏ nhất
--SMALLINT: 2 bytes (-32,768 đến 32,768)INT: 4 bytes
--(-2,147,483,648 đến 2,147,483,647)BIGINT: 8 bytes (Số rất lớn)