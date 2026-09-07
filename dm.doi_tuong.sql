-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[doi_tuong]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.doi_tuong (
        -- Khóa chính Tự tăng (BigInt)
        id SMALLINT IDENTITY(1,1) PRIMARY KEY,
        ma varchar(10),
        ten nvarchar(100),
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

INSERT INTO dm.doi_tuong (ma, ten, trang_thai, is_deleted)
SELECT source.ma, source.ten, 1, 0
FROM (
    VALUES 
        ('SQ', N'Sĩ quan'),
        ('QNCN', N'Quân nhân chuyên nghiệp'),
        ('BS', N'Hạ sĩ quan/Binh sĩ'),
        ('HVCY', N'Học viên cơ yếu'),
        ('CNQP', N'Công nhân quốc phòng'),
        ('VCQP', N'Viên chức quốc phòng'),
        ('CCQP', N'Công chức quốc phòng'),
        ('NLD', N'Lao động học tập, công tác nước ngoài'),
        ('LDHD', N'Lao động hợp đồng'),
        ('PN', N'Phu nhân, phu quân'),
        ('TN', N'Thân nhân'),
        ('LS', N'Người nước ngoài đang học tập tại VN'),
        ('HVQS', N'Học viên đào tạo cán bộ QS cấp xã, phường'),
        ('SQDB', N'Sĩ quan dự bị'),
        ('HCCY', N'Làm công tác trong tổ chức CY'),
        ('KTCY', N'Hưởng lương CM kỹ thuật cơ yếu'),
        ('CNVCQP', N'Công nhân viên chức quốc phòng'),
        ('TV', N'Thân nhân công nhân viên chức quốc phòng'),
        ('SV', N'Sinh viên'),
        ('HS', N'Học sinh'),
        ('XK', N'Cán bộ quân sự xã (phường)'),
        ('DB', N'Học viên đào tạo sĩ quan dự bị'),
        ('HV', N'Học viên sĩ quan'),
        ('HCY', N'Hưởng lương cấp hàm cơ yếu'),
        ('KHAC', N'Khác'),
        ('IS', N'BHXH tự nguyện')
) AS source(ma, ten)
WHERE NOT EXISTS (
    SELECT 1 FROM dm.doi_tuong target WHERE target.ma = source.ma
);
GO

