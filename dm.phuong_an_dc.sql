-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

-- 2. Tạo Bảng dm.phuong_an_dc
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[phuong_an_dc]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.phuong_an_dc (
        -- Khóa chính Tự tăng (BigInt)
        id SMALLINT IDENTITY(1,1) PRIMARY KEY,
        ma char(2),
        ten nvarchar(100),
        [trang_thai]    TINYINT NOT NULL DEFAULT 1,         -- 1: Hoạt động, 0: Khóa      
        -- Quản lý dữ liệu hệ thống (Audit Fields)
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                int NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                int NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                int NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0,                   -- 0: Dùng, 1: Xóa mềm                
    );
END
GO

INSERT INTO dm.phuong_an_dc (ma, ten, trang_thai, is_deleted)
SELECT source.ma, source.ten, 1, 0
FROM (
    VALUES 
        ('TM', N'Tăng mới'),
        ('DC', N'Điều chỉnh lương, CV, nghề nghiệp'),
        ('OF', N'Nghỉ do ốm đau/Nghỉ không lương'),
        ('TS', N'Thai sản'),
        ('ON', N'Đi làm lại'),
        ('GD', N'Giảm do chuyển đơn vị'),
        ('TD', N'Tăng do chuyển đơn vị'),
        ('GH', N'Giảm hẳn')
) AS source(ma, ten)
WHERE NOT EXISTS (
    SELECT 1 FROM dm.phuong_an_dc target WHERE target.ma = source.ma
);
GO

select * from dm.phuong_an_dc