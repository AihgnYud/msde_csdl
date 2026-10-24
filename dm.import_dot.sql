-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[import_dot]') AND type in (N'U'))
BEGIN
   CREATE TABLE dm.import_dot (
            [id]                    INT IDENTITY(1,1) PRIMARY KEY,
            [ma]         VARCHAR(50) NOT NULL UNIQUE,     -- Mã đợt import sinh tự động cấu trúc: IMP_NĂM_LOẠIHS_MÃ ĐV_Số đợt, ví dụ: IMP_2026_TNLDBNN_0760_01 (số đợt theo loại hồ sơ, năm, mã đơn vị)
            [loai_ho_so_id]         INT NOT NULL,                    -- FK trỏ dm.import_loai_ho_so
            [don_vi_id]                     int NULL,--đợt này thuộc về đơn vị nào, qua id này xác dược được Mã đơn vị để gắn vào mã đợt
                                                    -- Đơn vị nào xem được các đợt import của đơn vị đó, khi chọn xem các đợt của đơn vị trực thuộc thì xem được đợt của đơn vị con
            [ten_file] NVARCHAR(250) NULL,               -- Tên file đã import
            [so_ho_so]     int, -- Số lượng hồ sơ trong file đã import
            [so_ho_so_loi]     int, -- Số lượng hồ sơ trong file đã import còn bị lỗi
            [lan_upload]            INT DEFAULT 1,                   -- Đếm số lần upload đè file (Cho phép sửa, chọn lại file upload để đè)
            [trang_thai]    TINYINT NOT NULL DEFAULT 1,         -- 1: Khởi tạo, 0: Có lỗi; 2: Hoàn thạnh; -1 Hủy      
            -- Quản lý dữ liệu hệ thống (Audit Fields)
            [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
            [created_by]                int NULL,                              -- ID người tạo
            [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
            [updated_by]                int NULL,                              -- ID người sửa
            [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
            [deleted_by]                int NULL,                              -- ID người xóa mềm
            [is_deleted]                BIT NOT NULL DEFAULT 0 ,                  -- 0: Dùng, 1: Xóa mềm 
            CONSTRAINT FK_ImportDot_LoaiHoSo FOREIGN KEY ([loai_ho_so_id]) REFERENCES dm.import_loai_ho_so([id])
        );
END
GO
--SET IDENTITY_INSERT dm.import_dot ON;

--SET IDENTITY_INSERT dm.import_dot OFF;
GO

