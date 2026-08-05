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
        -- Định danh & Khóa chính (Dùng UNIQUEIDENTIFIER để tránh dò quét ID tự tăng)
        id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
        
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
        created_by UNIQUEIDENTIFIER NULL,
        updated_at DATETIMEOFFSET NULL,
        updated_by UNIQUEIDENTIFIER NULL,
        is_deleted BIT NOT NULL DEFAULT 0          -- Soft Delete (1: Đã xóa, 0: Đang hoạt động)
    );
END
GO

-- 3. Ràng buộc duy nhất (Unique Constraint) cho Username
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sso].[UQ_users_username]') AND type = N'UQ')
BEGIN
    ALTER TABLE sso.users 
    ADD CONSTRAINT UQ_users_username UNIQUE (username);
END
GO

-- 4. Đánh chỉ mục lọc (Filtered Index) tối ưu truy vấn đăng nhập cho tài khoản chưa bị xóa
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_users_username' AND object_id = OBJECT_ID(N'[sso].[users]'))
BEGIN
    CREATE NONCLUSTERED INDEX idx_users_username 
    ON sso.users(username) 
    WHERE is_deleted = 0;
END
GO