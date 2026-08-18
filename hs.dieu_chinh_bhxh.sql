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
        [chuc_vu_id]                     SMALLINT NULL,
        [nghe_nghiep_id]                     SMALLINT NULL,
        [pa_dc_id]                     SMALLINT NULL,
        [don_vi_id]                     int NULL,

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