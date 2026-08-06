-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

-- 2. Tạo Bảng dm.don_vi
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[don_vi]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.don_vi (
        -- Khóa chính Tự tăng (BigInt)
        id BIGINT IDENTITY(1,1) PRIMARY KEY,
        
        -- Mã & Tên Đơn vị
        ma_dv VARCHAR(20) NOT NULL,                -- node_code: Mã ngắn tại cấp hiện tại (Vd: '01', '02', '105')
        ten_dv NVARCHAR(255) NOT NULL,          -- Tên đầy đủ (Vd: 'Trung đoàn 102')
        ten_viet_tat NVARCHAR(50) NULL,             -- Tên viết tắt (Vd: 'e102')
        
        -- Phân cấp Cây Đơn vị (Materialized Path)
        id_parent BIGINT NULL,                  -- Id đơn vị cha trực tiếp (Self-referencing FK)
        level_dv INT NOT NULL DEFAULT 1,          -- Độ sâu của cây (1: Cục/QK, 2: Sư đoàn, 3: Trung đoàn...)
        ma_dv_full VARCHAR(500) NOT NULL,     -- org_path: Mã đầy đủ (Vd: '01.02.105')
        
        -- Thời gian phát sinh & Trạng thái
        ngay_thanh_lap DATE NULL,                   -- Ngày thành lập đơn vị
        ngay_giai_the DATE NULL,                    -- Ngày giải thể (NULL nếu đang hoạt động)
        trang_thai TINYINT NOT NULL DEFAULT 1,      -- 1: Hoạt động, 0: Tạm dừng/Giải thể
        
        -- Quản lý dữ liệu hệ thống (Audit Fields)
        created_at DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        created_by UNIQUEIDENTIFIER NULL,
        updated_at DATETIMEOFFSET NULL,
        updated_by UNIQUEIDENTIFIER NULL,
        is_deleted BIT NOT NULL DEFAULT 0,
                
        -- Ràng buộc Khóa ngoại & Duy nhất
        CONSTRAINT FK_donvi_parent FOREIGN KEY (id_parent) REFERENCES dm.don_vi(id),
        CONSTRAINT UQ_donvi_madvfull UNIQUE (ma_dv_full)
    );
END
GO

-- 3. Tạo các Index tối ưu cho truy vấn cây dữ liệu
-- Index hỗ trợ tìm kiếm tất cả đơn vị con theo đường dẫn (Materialized Path)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_donvi_duongdan' AND object_id = OBJECT_ID(N'[dm].[don_vi]'))
BEGIN
    CREATE NONCLUSTERED INDEX idx_donvi_duongdan 
    ON dm.don_vi (ma_dv_full)
    INCLUDE (ten_dv, level_dv, trang_thai)
    WHERE is_deleted = 0;
END
GO

-- Index hỗ trợ lọc đơn vị đang hoạt động theo đơn vị cha
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_donvi_cha_trangthai' AND object_id = OBJECT_ID(N'[dm].[don_vi]'))
BEGIN
    CREATE NONCLUSTERED INDEX idx_donvi_cha_trangthai 
    ON dm.don_vi (id_parent, trang_thai)
    INCLUDE (ten_dv, ma_dv_full)
    WHERE is_deleted = 0;
END
GO
-- 3.3. Ràng buộc chống trùng ma_dv trong cùng 1 Đơn vị cha trực tiếp
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'UQ_donvi_parent_madv' AND object_id = OBJECT_ID(N'[dm].[don_vi]'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UQ_donvi_parent_madv
    ON dm.don_vi (id_parent, ma_dv)
    WHERE is_deleted = 0;
END
GO

