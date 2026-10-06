-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[ly_do_tnld_bnn]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.ly_do_tnld_bnn (        
        id SMALLINT IDENTITY(1,1) PRIMARY KEY,
        ma char(2) not null unique,
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

INSERT INTO dm.ly_do_tnld_bnn (ma, ten) VALUES (N'09', N'Nhiễm độc TNT');
INSERT INTO dm.ly_do_tnld_bnn (ma, ten) VALUES (N'07', N'Trong lao động, sản xuất');
INSERT INTO dm.ly_do_tnld_bnn (ma, ten) VALUES (N'05', N'Tại nơi làm việc');
INSERT INTO dm.ly_do_tnld_bnn (ma, ten) VALUES (N'04', N'Nhiễm Crom');
INSERT INTO dm.ly_do_tnld_bnn (ma, ten) VALUES (N'01', N'Trên đường đi công tác');
INSERT INTO dm.ly_do_tnld_bnn (ma, ten) VALUES (N'10', N'Trên đường đi, về');
INSERT INTO dm.ly_do_tnld_bnn (ma, ten) VALUES (N'03', N'Từ nơi ở đến nơi làm việc và ngược lại');
INSERT INTO dm.ly_do_tnld_bnn (ma, ten) VALUES (N'06', N'Trong huấn luyện, luyện tập thể thao');
INSERT INTO dm.ly_do_tnld_bnn (ma, ten) VALUES (N'02', N'Điếc nghề nghiệp');
INSERT INTO dm.ly_do_tnld_bnn (ma, ten) VALUES (N'08', N'Bụi phổi Silíc');

--SET IDENTITY_INSERT dm.quoc_tich OFF;
GO

