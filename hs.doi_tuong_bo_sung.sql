-- 1. Tạo Schema hs (Hồ sơ) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'hs')
BEGIN
    EXEC('CREATE SCHEMA hs');
END
GO
-- 2. Tạo Bảng hs.doi_tuong_bo_sung
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[hs].[doi_tuong_bo_sung]') AND type in (N'U'))
BEGIN
    CREATE TABLE hs.doi_tuong_bo_sung (
        [id]                        BIGINT IDENTITY(1,1) NOT NULL,
        doi_tuong_id bigint not null,               
        [nhap_ngu]                      int NULL,          
        [xuat_ngu]                      int NULL,          
        [tai_ngu]                      int NULL,          
        [tuyen_dung]                      int NULL,            
        benh_vien_id                    int null,           --Bệnh viện đề nghị cấp thẻ        
        [tu_thang_the]                      int NULL,     --Đề nghị cấp thẻ từ tháng
        [den_thang_the]                      int NULL,     -- Đề nghị cấp thẻ đến tháng
        [id_the_ht]      BIGINT NULL,            -- Trỏ tới ID thẻ mới nhất trong bảng bhyt_the
        [ma_the_the_ht]                      varchar(17) NULL,     -- Thẻ hiện tại đến tháng nào
         benh_vien_id_ht                    int null, --Thẻ hiện tại tại bv nào                  
         [tu_thang_the_ht]                      int NULL,     -- Thẻ hiện tại từ tháng nào
        [den_thang_the_ht]                      int NULL,     -- Thẻ hiện tại đến tháng nào
        [nam_5_lien_tuc]                      int NULL,     -- Thời điểm 5 năm liên tục thẻ đã cấp
        [trang_thai_the_ht]            TINYINT DEFAULT 1,  -- Đang có hiệu lực, trạng thái thẻ hiện tại
        [cu_tru_tinh_id]                   SMALLINT NULL,                            -- AddressProvinceId
        [cu_tru_huyen_id]                  SMALLINT NULL,                            -- AddressDistrictId
        [cu_tru_xa_id]                     SMALLINT NULL,   
        [co_quan_tinh_id]                   SMALLINT NULL,                            -- AddressProvinceId
        [co_quan_huyen_id]                  SMALLINT NULL,                            -- AddressDistrictId
        [co_quan_xa_id]                     SMALLINT NULL,           
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