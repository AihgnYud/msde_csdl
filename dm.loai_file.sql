CREATE TABLE dm.loai_file (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ma_loai VARCHAR(50) NOT NULL UNIQUE,          -- Mã định danh (VD: DS_DE_NGHI, CCCD, QD_HUU_TRU...)
    ten_loai NVARCHAR(200) NOT NULL,        -- Tên hiển thị (VD: Danh sách đề nghị cấp sổ BHXH)  
    mo_ta NVARCHAR(500) NULL,               -- Mô tả chi tiết ngữ cảnh sử dụng
    trang_thai BIT DEFAULT 1                -- 1: Đang sử dụng, 0: Ngừng sử dụng
);