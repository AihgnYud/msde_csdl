-- 1. Tạo Schema hs (Hồ sơ) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'hs')
BEGIN
    EXEC('CREATE SCHEMA hs');
END
GO
-- 2. Tạo Bảng hs.dieu_chinh_bhxh
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[hs].[dieu_chinh_bhxh]') AND type in (N'U'))
BEGIN
    CREATE TABLE hs.dieu_chinh_bhxh (
        [id]                        BIGINT IDENTITY(1,1) NOT NULL,
        [guid]                      UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Public Key cho API
        doi_tuong_id bigint not null,  --Biến động của đối tượng nào      
        tu_thang int not null,--yyyyMM
        den_thang int not null,--yyyyMM
        [loai_dt_id]                     SMALLINT NULL,--join bảng dm đối tượng để biết SQ hay QNCN
        [cap_bac_id]                     SMALLINT NULL,
        [chuc_vu_id]                     int NULL,        
        [nghe_nghiep_id]                     int NULL,
        [pa_tang_id]                     SMALLINT NULL,--Phương án điều chỉnh tăng
        [pa_giam_id]                     SMALLINT NULL,--Phương án điều chỉnh giảm
        [don_vi_id]                     int NULL,
        [don_vi_chuyen_id]              int NULL,--Chuyển đi hay chuyển đến đơn vị nào
        [hsl]               DECIMAL(4, 2) NULL, -- Hệ số lương (VD: 4.65, 10.00)
        [luong]             INT NULL,          -- Tiền lương khoán/HĐLĐ (VNĐ)
        [hs_cv]             DECIMAL(4, 2) NULL, -- Hệ số chức vụ (VD: 0.25, 1.10)
        [phu_cap_cv]        INT NULL,          -- Phụ cấp chức vụ bằng tiền đồng (VNĐ)
        [tham_nien_ng]      TINYINT NULL,       -- % Thâm niên nghề (0 -> 100)
        [tham_nien_vk]      TINYINT NULL,        -- % Thâm niên vượt khung (0 -> 100)
        [hs_bao_luu]        DECIMAL(5, 3) NULL, -- Hệ số bảo lưu (VD: 0.15)
        [phu_cap_khac]      INT NULL,          -- Phụ cấp khác bằng tiền đồng (VNĐ)
		[phu_cap_kv]           DECIMAL(4, 2) NULL, -- Phụ cấp khu vực
		[phu_cap_bck]           DECIMAL(4, 2) NULL, -- Phụ cấp khu vực
        [tong_luong]        INT NOT NULL,      -- Tổng số tiền tính đóng BHXH 
        [tc_tnld_bnn]        INT  NULL,      -- Trợ cấp tnld_bnn 
        [giai_quyet_cd_id] bigint null,  --Là hồ sơ giải quyết chế độ nào
        [ghi_chu]        NVARCHAR(200) NULL.  -- Ghi chú tự do
        --------------------------------------------------------------------------------
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                BIGINT NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                BIGINT NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                BIGINT NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0,                   -- 0: Dùng, 1: Xóa mềm
        --forenky các trường trong danh mục xã, huyện, tỉnh
         FOREIGN KEY (doi_tuong_id) REFERENCES hs.doi_tuong(id) ,
         CONSTRAINT FK_don_vi_id FOREIGN KEY ([don_vi_id]) REFERENCES dm.don_vi([id]),
        )
End