CREATE TABLE luutru.file_ket_qua_dien_tu (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    loai_file_id INT FOREIGN KEY REFERENCES dm.loai_file(id), -- Phải thuộc nhóm 3 (VD: Sổ BHXH điện tử, QĐ hưởng...)
    doi_tuong_id BIGINT NOT NULL,
    so_hieu_quyet_dinh_hoac_so VARCHAR(100) NOT NULL, -- Số sổ hoặc số quyết định
    tu_ngay DATE NULL,                      -- Hiệu lực từ ngày (nếu có)
    duong_dan_file NVARCHAR(500) NOT NULL,
    ma_hash_checksum VARCHAR(128) NOT NULL,
    -- Thông tin chữ ký số chuyên dùng
    thong_tin_nguoi_ky NVARCHAR(255) NULL,
    serial_thu_token VARCHAR(100) NULL,
    thoi_gian_ky DATETIME2 NULL,
    trang_thai_hieu_luc TINYINT DEFAULT 1   -- 1: Có hiệu lực, 2: Bị thu hồi/điều chỉnh
);