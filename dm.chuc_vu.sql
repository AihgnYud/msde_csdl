-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[chuc_vu]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.chuc_vu (        
        id bigint IDENTITY(1,1) PRIMARY KEY,
        ma varchar(6) not null UNIQUE,
        ten nvarchar(100),
        loai_cv TINYINT,                
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
--SET IDENTITY_INSERT dm.chuc_vu ON;

--SET IDENTITY_INSERT dm.chuc_vu OFF;
GO

