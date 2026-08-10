-- Tạo Schema 'sso' nếu chưa tồn tại trong SQL Server
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'sso')
BEGIN
    EXEC('CREATE SCHEMA sso');
END
GO

-- 2. Tạo Bảng sso.users
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sso].[users]') AND type in (N'U'))
BEGIN
    CREATE TABLE sso.users (
       -- 1. Định danh & Khóa chính (Dual-ID)
        id int IDENTITY(1,1) NOT NULL,
        guid UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Public Key cho API
        
        -- Thông tin tài khoản & Xác thực
        username VARCHAR(50) NOT NULL,
        password_hash VARCHAR(255) NOT NULL,
        salt VARCHAR(100) NULL,
        
        -- Trạng thái tài khoản (Chuẩn SQL Server dùng BIT: 1 = True, 0 = False)
        is_active BIT NOT NULL DEFAULT 1,          -- Trạng thái hoạt động (1: Hoạt động, 0: Khóa)
        is_locked BIT NOT NULL DEFAULT 0,          -- Khóa tài khoản khi nhập sai pass (1: Khóa, 0: Bình thường)
        failed_login_count INT NOT NULL DEFAULT 0, -- Số lần đăng nhập thất bại
        last_login_at DATETIMEOFFSET NULL,         -- Thời điểm đăng nhập cuối cùng
        
        -- Quản lý vòng đời dữ liệu (Audit Fields)
        created_at DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        created_by int NULL,
        updated_at DATETIMEOFFSET NULL,
        updated_by int NULL,
        deleted_at DATETIMEOFFSET NULL,         -- Thời điểm xóa mềm
        deleted_by INT NULL,                    -- Người thực hiện xóa mềm
        is_deleted BIT NOT NULL DEFAULT 0          -- Soft Delete (1: Đã xóa, 0: Đang hoạt động)
    );
END
GO

-- 1. Unique Index cho GUID (Phục vụ truy vấn từ API / Token / Microservices)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'uq_idx_users_guid' AND object_id = OBJECT_ID(N'[sso].[users]'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX uq_idx_users_guid 
    ON sso.users(guid);
END
GO

-- 2. Unique Filtered Index cho Username (Tối ưu Đăng nhập & Hỗ trợ Xóa mềm)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'uq_idx_users_username_active' AND object_id = OBJECT_ID(N'[sso].[users]'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX uq_idx_users_username_active 
    ON sso.users(username) 
    WHERE is_deleted = 0;
END
GO