-- Tạo Schema nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bhxh')
BEGIN
    EXEC('CREATE SCHEMA [bhxh]');
END
GO
-- =============================================================================
-- 2. BẢNG GIẢI QUYẾT CHẾ ĐỘ DÀI HẠN (DÀI HẠN / HƯU TRÍ / TỬ TUẤT...)
-- =============================================================================
CREATE TABLE [bhxh].[giai_quyet_cd_dh] (
    id  BIGINT IDENTITY(1,1) NOT NULL,
    giai_quyet_cd_id BIGINT not null,
    -- Số tháng đặc thù
    [so_thang_lvdb]                  TINYINT              NULL,
    [so_thang_lvnn]                  TINYINT              NULL,
    [so_thang_pckv07]                TINYINT              NULL,
    [so_thang_ham_lo]                TINYINT              NULL,
    [so_thang_huong]                 DECIMAL(6, 3)    NULL,
    [so_thang_tc]                    DECIMAL(5, 2)    NULL,
    [so_thang_tinh_tn]               TINYINT              NULL,
    [so_thang_bh_truoc_2014]         TINYINT              NULL,
    [so_thang_bck]                   TINYINT              NULL,
    [so_thang_cdv]                   TINYINT              NOT NULL DEFAULT 0,
    [so_thang_cnqp]                  TINYINT              NOT NULL DEFAULT 0,
    [so_thang_truoc_tuoi_nd177_178]  TINYINT              NULL,
    [so_thang_lvdbdt]                TINYINT              NOT NULL DEFAULT 0,
    [so_thang_tc_05]                 DECIMAL(5, 2)    NULL,
    
    -- Luơng, Trợ cấp & Hệ số
    [luong_bq] INT NULL,-- Tối đa 2 tỷ
    [pckv_bh]   INT NULL,-- Tối đa 2 tỷ    
    [pckv_nn]  INT NULL,-- Tối đa 2 tỷ    
    [tyle_phantram]                  DECIMAL(5, 4)    NULL,
    [luong_huu]  INT NULL,-- Tối đa 2 tỷ    
    [he_so_dc]    DECIMAL(5, 3)    NULL,    
    [so_tien_mt]    INT NULL,-- Tối đa 2 tỷ
    
    -- Hệ số lương & Phụ cấp
    [hsl]               DECIMAL(4, 2) NULL, -- Hệ số lương (VD: 4.65, 10.00)
    [luong]             INT NULL,          -- Tiền lương khoán/HĐLĐ (VNĐ)
    [hs_cv]             DECIMAL(4, 2) NULL, -- Hệ số chức vụ (VD: 0.25, 1.10)
    [phu_cap_cv]        INT NULL,          -- Phụ cấp chức vụ bằng tiền đồng (VNĐ)
    [tham_nien_ng]      TINYINT NULL,       -- % Thâm niên nghề (0 -> 100)
    [tham_nien_vk]      TINYINT NULL,        -- % Thâm niên vượt khung (0 -> 100)
    [hs_bao_luu]        DECIMAL(5, 3) NULL, -- Hệ số bảo lưu (VD: 0.15)
    [phu_cap_khac]      INT NULL,          -- Phụ cấp khác bằng tiền đồng (VNĐ)
    
    -- Tử tuất & Thương tật
    [ngay_chet]              int null,--yyyyMM
    [ly_do_chet]                     NVARCHAR(150)    NULL,
    [so_tien_chet_do_tnld_bnn]       INT NULL,-- Tối đa 2 tỷ
    [hiv]                            BIT              NULL,        
    
    -- Thông tin ký đơn vị
    [sqd_dv]                         NVARCHAR(30)     NULL,
    [ngay_ky_dv]                      int null,--yyyyMM
    [chuc_vu_ky_dv]                  NVARCHAR(50)     NULL,    
    [tc_tau_xe]                       INT NULL,   
    [dong_con_thieu_so_thang]         TINYINT              NULL,--Tối đa lưu được 255, giá trị tối đa 100
    [dong_con_thieu_tai_thang]        int null,--yyyyMM
    [loai_cdcs_dc]                    TINYINT NULL,--join bảng dm chế độ để biết là bảng nào
    [thang_huong_dc]                int null,--yyyyMM
    [tc1lan_x2]                      BIT              NULL,

    
    [so_tien_tc]              INT NULL,-- Tối đa 2 tỷ        
    -- Chuyển vùng / Địa chỉ
    [chuyen_ve_tinh_id]          INT NULL,
    [chuyen_ve_huyen_id]         INT NULL,
    [chuyen_ve_xa_id]            INT NULL,
    [chuyen_ve_ngo_xom]       NVARCHAR(50)    NULL,

    CONSTRAINT [PK_giai_quyet_cd_dh] PRIMARY KEY CLUSTERED ([giai_quyet_cd_id] ASC),
    CONSTRAINT [FK_cd_dh_giai_quyet_cd] FOREIGN KEY ([giai_quyet_cd_id]) REFERENCES [bhxh].[giai_quyet_cd] ([id]) ON DELETE CASCADE
);
GO
