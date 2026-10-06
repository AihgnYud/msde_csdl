-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'ht')
BEGIN
    EXEC('CREATE SCHEMA ht');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ht].[tham_so]') AND type in (N'U'))
BEGIN
    CREATE TABLE ht.tham_so (        
        id SMALLINT IDENTITY(1,1) PRIMARY KEY,
        [don_vi_id]                     int NULL,
        [user_id]                int NULL,                              -- ID người tạo
        [ma_tham_so] varchar(50),  
        [gia_tri]       NVARCHAR(255) NULL,                  -- Giá trị cấu hình
        [mo_ta]         NVARCHAR(255) NULL,
        [trang_thai]    TINYINT NOT NULL DEFAULT 1,         -- 1: Hoạt động, 0: Khóa      
        -- Quản lý dữ liệu hệ thống (Audit Fields)
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                int NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                int NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                int NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0,                  -- 0: Dùng, 1: Xóa mềm                
        CONSTRAINT UQ_User_MaThamSo UNIQUE ([user_id], [ma_tham_so])
    );
END
GO
--SET IDENTITY_INSERT dm.quoc_tich ON;


--SET IDENTITY_INSERT dm.quoc_tich OFF;
GO

