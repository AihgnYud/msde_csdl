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
        --Các thông tin cấp bậc chứ vụ đơn vị hiện tại
        [loai_dt_id]                     TINYINT NULL,--join bảng dm đối tượng để biết SQ hay QNCN
        thang_ht int not null,--yyyyMM Tháng hiện tại là tháng nào (cột này ẩn, để hệ thống kiểm soát: 
                            -- Khi nhập mới thì luôn mặc định là tháng hiện tại (lấy ngày giờ của hệ thống), ví dụ nhập mới đối tượng
                            --vào tháng 11/2026 thì cột này là tháng 11/2026. 
                            -- Nếu là dữ liệu do chuyển đổi từ hệ thống cũ, hoặc quản trị viên thiết lập dữ liệu thì cột này là : 01/1900
                            -- Nếu người dùng vào chỉnh sửa dữ liệu mà thang_ht=190001 thì set thang_ht bằng ngày giờ hệ thống
                            -- Khi thực hiện các điều chỉnh tại bảng điều chỉnh nếu thêm sửa các điều chỉnh trước tháng hiện tại thang_dieu_chinh < thang_ht 
                            --thì không cập nhật sang cấp bậc, chức vụ, đơn vị (cache); ngược lại, sau tháng hiện tại thang_dieu_chinh >= thang_ht thì cập nhật
                             --và cập nhật cả thang_ht= tháng điều chỉnh
                             -- Trên title của bảng điều chỉnh: Hiện thông tin hiện tại: Hiện tại (từ 11/2026): Đại úy, Trợ lý, Mã đv: 0703 -> Sau đó có nút lệnh 
                             --Đồng bộ từ Đ/c (khi người dùng di chuột vào nút này hiện lên tooltip: Cập nhật từ dòng điều chỉnh cuối cùng vào hồ sơ hiện tại của cá nhân)
        [cap_bac_id]                     TINYINT NULL,
        [chuc_vu_id]                     int NULL,        
        [don_vi_id]                     int NULL,
        ---
        [nhap_ngu]                      int NULL,     
        dien_ql TINYINT NOT NULL DEFAULT 0, --diện quản lý là cán bộ hay quân lực: 0 là QL, 1 là Cán bộ
        khoi_dn_dt TINYINT NOT NULL DEFAULT 0, --thuộc khối doanh nghiệp hay hạch toán 0 là dự toán, 1 
        [xuat_ngu]                      int NULL,          
        [tai_ngu]                      int NULL,          
        [tuyen_dung]                      int NULL,            
        benh_vien_id                    int null,           --Bệnh viện đề nghị cấp thẻ        
        [tu_thang_the]                      int NULL,     --Đề nghị cấp thẻ từ tháng
        [den_thang_the]                      int NULL,     -- Đề nghị cấp thẻ đến tháng
		[nam_5_lien_tuc_the]                      int NULL,     -- Thời điểm 5 năm liên tục thẻ đề nghị
        [id_the_ht]      BIGINT NULL,            -- Trỏ tới ID thẻ mới nhất trong bảng bhyt_the
        [ma_the_the_ht]                      varchar(17) NULL,     -- Thẻ hiện tại đến tháng nào
         benh_vien_id_ht                    int null, --Thẻ hiện tại tại bv nào                  
         [tu_thang_the_ht]                      int NULL,     -- Thẻ hiện tại từ tháng nào
        [den_thang_the_ht]                      int NULL,     -- Thẻ hiện tại đến tháng nào
        [nam_5_lien_tuc_ht]                      int NULL,     -- Thời điểm 5 năm liên tục thẻ đã cấp
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