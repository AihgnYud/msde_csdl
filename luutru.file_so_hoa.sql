CREATE TABLE hs.file_so_hoa (
    id                BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_hoso           BIGINT NOT NULL,           -- ID của bảng nghiệp vụ (Ví dụ: id của bảng giai_quyet_che_do)
    loai_hs           VARCHAR(20) NOT NULL,    -- Phân loại: 'GQCD' (Giải quyết chế độ), 'CAPSO' (Cấp sổ)...
    
    -- Thông tin file
    ten_file          NVARCHAR(255) NOT NULL,    -- Tên gốc của tệp PDF
    duong_dan_file    VARCHAR(500) NOT NULL,   -- Đường dẫn lưu trên Storage (NAS, MinIO, S3 hoặc thư mục Server)
    dung_luong        INT NULL,                  -- Kích thước file (bytes)
    
    -- [QUAN TRỌNG CHO FILE KÝ SỐ]
    ma_hash_sha256    VARCHAR(64) NULL,          -- Mã băm SHA-256 của file PDF gốc để chống giả mạo/chỉnh sửa trái phép
    da_ky_so          BIT DEFAULT 1,             -- Đánh dấu file này đã được ký số hay chưa (1: Đã ký, 0: Chưa)
    thong_tin_ky      NVARCHAR(MAX) NULL,        -- (Tuỳ chọn) Lưu JSON thông tin người ký, tổ chức chứng thực, thời gian ký
    
    -- Metadata hệ thống
    nguoi_tai_len     BIGINT NULL,               -- ID cán bộ upload/ký số
    ngay_tao          DATETIME2 DEFAULT GETDATE()
);