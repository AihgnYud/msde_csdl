CREATE TABLE hs.yeu_cau_chuyen_don_vi (
    [id]                    BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    -- Đối tượng được yêu cầu chuyển
    [doi_tuong_id]          BIGINT NOT NULL,              -- FK -> hs.doi_tuong(id)
    
    -- Đơn vị giao & Đơn vị nhận
    [don_vi_di_id]          INT NOT NULL,                 -- Đơn vị A (Đang quản lý hiện tại)
    [don_vi_den_id]         INT NOT NULL,                 -- Đơn vị B hoặc C (Đơn vị xin tiếp nhận)
    
    -- Thông tin nghiệp vụ đi kèm (Giúp đơn vị A có cơ sở đối chiếu để duyệt)
    [so_quyet_dinh]         NVARCHAR(50) NULL,            -- Số QĐ điều động (nếu có)
    [ngay_quyet_dinh]       INT NULL,                     -- yyyyMMdd
    [thang_chuyen_den]      INT NOT NULL,                 -- Tháng dự kiến bắt đầu tại đơn vị mới (yyyyMM)
    [ly_do_yeu_cau]         NVARCHAR(500) NULL,
    
    -- Trạng thái xử lý của yêu cầu
    -- 0: Chờ đơn vị đi xác nhận
    -- 1: Đã đồng ý chuyển (Hoàn tất)
    -- 2: Bị từ chối trực tiếp
    -- 3: Tự động hủy (Do đơn vị A đã duyệt chuyển cho một đơn vị khác)
    [trang_thai]            TINYINT NOT NULL DEFAULT 0,
    [ly_do_tu_choi]         NVARCHAR(500) NULL,
    
    -- Audit & Dấu vết người thao tác
    [nguoi_yeu_cau_id]      BIGINT NOT NULL,              -- Cán bộ đơn vị B/C tạo yêu cầu
    [ngay_yeu_cau]          DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    [nguoi_duyet_id]        BIGINT NULL,                  -- Cán bộ đơn vị A phê duyệt
    [ngay_duyet]            DATETIMEOFFSET NULL
);

-- Index tối ưu cho màn hình Đơn vị A kiểm tra các yêu cầu chuyển đi đang chờ
CREATE INDEX IX_YCCDV_DonViDi ON hs.yeu_cau_chuyen_don_vi([don_vi_di_id], [trang_thai]);

-- Index tối ưu cho màn hình Đơn vị B/C xem danh sách đang chờ tiếp nhận
CREATE INDEX IX_YCCDV_DonViDen ON hs.yeu_cau_chuyen_don_vi([don_vi_den_id], [trang_thai]);