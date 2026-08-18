-- 1. Tạo Schema hs (Hồ sơ) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'hs')
BEGIN
    EXEC('CREATE SCHEMA hs');
END
GO
-- 2. Tạo Bảng dm.don_vi
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[hs].[doi_tuong]') AND type in (N'U'))
BEGIN
    CREATE TABLE hs.doi_tuong (
        [id]                        BIGINT IDENTITY(1,1) NOT NULL,
        [guid]                      UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Public Key cho API
        [ho_ten]                    NVARCHAR(150) NULL,
        [ngay_sinh]                 int NULL,                          -- YYYYMMDD, nếu chỉ có năm sinh 19780000, nếu chỉ có tháng và năm 19781100        
        [gioi_tinh]                 BIT NULL,                                 -- 1: Nam, 0: Nữ
        [so_cccd]                   VARCHAR(12) NULL,                         -- ID Card 12 số
        [ma_so_bhxh]                VARCHAR(12) NULL,          
        [que_quan_tinh_id]                   SMALLINT NULL,                            -- AddressProvinceId
        [que_quan_huyen_id]                  SMALLINT NULL,                            -- AddressDistrictId
        [que_quan_xa_id]                     SMALLINT NULL,          
        --Dân tộc
        -- Quốc tịch
        --[SO_CM] [nvarchar](15) NULL,
	--[NOI_CAP_CMT] [nvarchar](50) NULL,
	--[NGAY_CAP_CMT] [datetime] NULL,
          -- 11. BỘ AUDIT FIELDS CHUẨN (Quản lý vòng đời dữ liệu)
        --------------------------------------------------------------------------------
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                BIGINT NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                BIGINT NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                BIGINT NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0,                   -- 0: Dùng, 1: Xóa mềm
        --forenky các trường trong danh mục xã, huyện, tỉnh
        )
End