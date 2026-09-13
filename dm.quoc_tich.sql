-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[quoc_tich]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.quoc_tich (        
        id SMALLINT IDENTITY(1,1) PRIMARY KEY,
        ma varchar(6) not null unique,
        ten nvarchar(50),                
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
--SET IDENTITY_INSERT dm.quoc_tich ON;

INSERT INTO dm.quoc_tich (ma, ten, trang_thai)
VALUES 
    ('VN', N'Việt Nam', 1),
    ('US', N'Mỹ', 1); -- Dùng mã 'US' cho quốc tịch Mỹ (chuẩn ISO 3166-1 alpha-2)

--SET IDENTITY_INSERT dm.quoc_tich OFF;
GO

