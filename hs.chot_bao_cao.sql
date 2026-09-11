-- 1. Tạo Schema hs (Hồ sơ) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'hs')
BEGIN
    EXEC('CREATE SCHEMA hs');
END
GO
-- 2. Tạo Bảng hs.dieu_chinh_bhxh
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[hs].[chot_bao_cao]') AND type in (N'U'))
BEGIN
    CREATE TABLE hs.chot_bao_cao (
        [id]                        int IDENTITY(1,1) NOT NULL,
        don_vi_id int,--Chốt đơn vị nào
        chot_thang int,--Chốt tháng nào yyyyMM
        [trang_thai]        TINYINT NOT NULL DEFAULT 1,      -- 1: Đã chốt/Khóa, 0: Mở khóa

        -- Quản lý Mở khóa & Nhật ký (Audit)
        [ly_do_mo_khoa]     NVARCHAR(150) NULL,              -- Lý do khi cấp dưới xin mở khóa kỳ gần nhất
        [ngay_chot]         DATETIMEOFFSET NULL,             -- Thời điểm thực hiện chốt
        [nguoi_chot_id]        INT NULL,                        -- ID người chốt
        [ngay_mo_khoa]      DATETIMEOFFSET NULL,             -- Thời điểm mở khóa gần nhất
        [nguoi_mo_khoa_id]     INT NULL,                        -- ID người thực hiện mở khóa
        --------------------------------------------------------------------------------
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                BIGINT NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                BIGINT NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                BIGINT NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0,                   -- 0: Dùng, 1: Xóa mềm
        --forenky các trường trong danh mục xã, huyện, tỉnh        
         CONSTRAINT FK_don_vi_id FOREIGN KEY (don_vi_id) REFERENCES dm.don_vi([id]),
         -- Ràng buộc: Mỗi đơn vị chỉ có 1 trạng thái chốt cho 1 kỳ
        CONSTRAINT UQ_chot_bao_cao UNIQUE (don_vi_id, chot_thang)
        )
End