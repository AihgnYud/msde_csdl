-- 1. Tạo Schema hs (Hồ sơ) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'hs')
BEGIN
    EXEC('CREATE SCHEMA hs');
END
GO
-- 2. Tạo Bảng hs.dc_nhan_than
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[hs].[dc_nhan_than]') AND type in (N'U'))
BEGIN
    CREATE TABLE hs.dc_nhan_than (
        [id]                        INT IDENTITY(1,1) NOT NULL,
        doi_tuong_id bigint not null, 
        [loai_dc_id]                 tinyint NULL,          --join dm.loai_dc để biết là điều chỉnh gì: CCCD, số BHXH, họ tên, ngày sinh, giới tính
        [ho_ten_cu]                    NVARCHAR(150) NULL,
        [ngay_sinh_cu]                 int NULL,                          -- YYYYMMDD, nếu chỉ có năm sinh 19780000, nếu chỉ có tháng và năm 19781100        
        [gioi_tinh_cu]                 BIT NULL,                                 -- 1: Nam, 0: Nữ
        [so_cccd_cu]                   VARCHAR(12) NULL,                         -- ID Card 12 số
        [ma_so_bhxh_cu]                VARCHAR(12) NULL,        
        [ho_ten_moi]                    NVARCHAR(150) NULL,
        [ngay_sinh_moi]                 int NULL,                          -- YYYYMMDD, nếu chỉ có năm sinh 19780000, nếu chỉ có tháng và năm 19781100        
        [gioi_tinh_moi]                 BIT NULL,                                 -- 1: Nam, 0: Nữ
        [so_cccd_moi]                   VARCHAR(12) NULL,                         -- ID Card 12 số
        [ma_so_bhxh_moi]                VARCHAR(12) NULL,       
        [ngay_hieu_luc]                 int NULL,                          -- YYYYMMDD, ngày có hiệu lực của điều chỉnh        
        [ho_ten_cu_khong_dau]          VARCHAR(150) NULL,--IN HOA VÀ BỎ KÝ TỰ TRĂNG: ví dụ Nguyễn   Xuân Phúc thì sẽ lưu là NGUYENXUANPHUC
        [ho_ten_moi_khong_dau]          VARCHAR(150) NULL,--IN HOA VÀ BỎ KÝ TỰ TRĂNG: ví dụ Nguyễn   Xuân Phúc thì sẽ lưu là NGUYENXUANPHUC
        --------------------------------------------------------------------------------
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                BIGINT NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                BIGINT NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                BIGINT NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0,                   -- 0: Dùng, 1: Xóa mềm
        --forenky các trường trong danh mục xã, huyện, tỉnh
         FOREIGN KEY (doi_tuong_id) REFERENCES hs.doi_tuong(id) ON DELETE CASCADE 
        )
End