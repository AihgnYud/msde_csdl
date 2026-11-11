-- 1. Tạo Schema hs (Hồ sơ) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'hs')
BEGIN
    EXEC('CREATE SCHEMA hs');
END
GO
-- 2. Tạo Bảng hs.quan_he_than_nhan

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[hs].[quan_he_than_nhan]') AND type in (N'U'))
BEGIN
   CREATE TABLE hs.quan_he_than_nhan (
            [id]                    BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    -- Người lao động chính (Người đang công tác / người chủ trì hồ sơ)
    [doi_tuong_id]     BIGINT NOT NULL,          -- FK trỏ tới hs.doi_tuong(id)
    
    -- Người thân nhân (Bố, mẹ, vợ, con...)
    [than_nhan_id]          BIGINT NOT NULL,          -- FK trỏ tới hs.doi_tuong(id)
    
    -- Loại quan hệ (Dùng danh mục hoặc mã chuẩn)
    [quan_he_id]            TINYINT NOT NULL,         -- 1: Bố đẻ, 2: Mẹ đẻ, 3: Vợ/Chồng, 4: Con đẻ...
           
    -- Trạng thái
    [trang_thai]            TINYINT DEFAULT 1,        -- 1: Đang là thân nhân phụ thuộc, 0: Chấm dứt/Đã tự lập hoặc chuyển sang là thân nhân của quân nhân khác
    [ghi_chu]               NVARCHAR(150) NULL,
    
      -- 11. BỘ AUDIT FIELDS CHUẨN (Quản lý vòng đời dữ liệu)
        --------------------------------------------------------------------------------
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                BIGINT NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                BIGINT NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                BIGINT NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0,                   -- 0: Dùng, 1: Xóa mềm
    
    -- Ràng buộc khóa ngoại
    CONSTRAINT FK_QHTN_NguoiLaoDong FOREIGN KEY ([doi_tuong_id]) REFERENCES hs.doi_tuong([id]),
    CONSTRAINT FK_QHTN_ThanNhan FOREIGN KEY ([than_nhan_id]) REFERENCES hs.doi_tuong([id]),
    
    -- Tránh việc 1 người vừa là người lao động vừa là chính mình
    CONSTRAINT CK_Self_Reference CHECK (doi_tuong_id <> [than_nhan_id])
);

-- Index tối ưu tra cứu nhanh thân nhân của một người lao động hoặc ngược lại
CREATE INDEX IX_QHTN_NLD ON hs.quan_he_than_nhan([doi_tuong_id]);
CREATE INDEX IX_QHTN_TN ON hs.quan_he_than_nhan([than_nhan_id]);
END
GO
--SET IDENTITY_INSERT dm.quan_he_than_nhan ON;

--SET IDENTITY_INSERT dm.quan_he_than_nhan OFF;
GO

--TINYINT: 1 byte (0 đến 255) $\leftarrow$ Nhỏ nhất
--SMALLINT: 2 bytes (-32,768 đến 32,768)INT: 4 bytes
--(-2,147,483,648 đến 2,147,483,647)BIGINT: 8 bytes (Số rất lớn)