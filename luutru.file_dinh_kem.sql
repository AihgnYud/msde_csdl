CREATE TABLE luutru.file_dinh_kem (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    loai_file_id INT FOREIGN KEY REFERENCES dm.loai_file(id), -- Phải thuộc nhóm 1 (VD: Danh sách đề nghị, Đơn...)
    nghiep_vu_id BIGINT NOT NULL,           -- ID của đợt giao dịch / hồ sơ đang xử lý
    ten_file_goc NVARCHAR(255) NOT NULL,
    duong_dan_file NVARCHAR(500) NOT NULL,
    ma_hash_checksum VARCHAR(128) NOT NULL,  -- Đảm bảo tính toàn vẹn file
    trang_thai_ky TINYINT DEFAULT 0,         -- 0: Chưa ký, 1: Đã ký số
    ngay_tao DATETIME2 DEFAULT SYSDATETIME()
);