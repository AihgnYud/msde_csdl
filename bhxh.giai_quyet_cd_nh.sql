-- Tạo Schema nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bhxh')
BEGIN
    EXEC('CREATE SCHEMA [bhxh]');
END
GO
-- =============================================================================
-- 3. BẢNG GIẢI QUYẾT CHẾ ĐỘ NGẮN HẠN (TNNLĐ / BNN / ỐM ĐAU / THAI SẢN...)
-- =============================================================================
CREATE TABLE [bhxh].[giai_quyet_cd_nh] (
     id  BIGINT IDENTITY(1,1) NOT NULL,
    giai_quyet_cd_id BIGINT not null,    
    -- Thông tin Tai nạn lao động / BNN
    [ngay_tnld_bnn]                  int null,--yyyyMM
    [ngay_ra_vien]                   int null,--yyyyMM    
    [ngay_tnld_bnn_lan_truoc]         int null,--yyyyMM
    
    -- Mức lương & Trợ cấp TNNLĐ/BNN
    [luong_ttc]                     int null,--Tối đa 2 tỷ    
    [muc_luong_can_cu]              int   NULL,    
    [muc_luong_truoc_bi_tn]         int   NULL,        
    [tyle_sgknld_lan_truoc]         TINYINT              NULL,--Tối đa lưu được 255, giá trị tối đa 100
    
    -- Các khoản Trợ cấp
    [st_tro_cap_tyle]               int   NULL,    
    [st_tro_cap_tyle_lan_truoc]           int   NULL,
    [st_tro_cap_tg]                 int   NULL,    
    [st_tro_cap_tg_lan_truoc]        int  NULL,
    [st_tro_cap_sau_dc]              int   NULL,
    [so_tien_tc_he_so]               DECIMAL(5, 3)    NULL,    
    
    -- Phụ cấp Phục vụ & Phục hồi chức năng
    [pc_phuc_vu_thang]               int   NULL,    
    [pc_phuc_vu_thang_sau_dc]        int   NULL,
    [pc_phuc_hoi_cn]                 int   NULL,    
    
    -- Lần bị / Lần đầu
    [gio_bi_lan_dau]                 TINYINT              NULL,--Tối đa lưu được 255, giá trị tối đa 100
    [phut_bi_lan_dau]                TINYINT              NULL,--Tối đa lưu được 255, giá trị tối đa 100
    [ngay_bi_lan_dau]                int null,--yyyyMM
    [cap_bac_lan_dau]                NVARCHAR(50)     NULL,
    [cap_bac_lan_dau_id]             TINYINT      NULL,
    [chuc_vu_lan_dau]                NVARCHAR(150)    NULL,
    [chuc_vu_lan_dau_id]             TINYINT      NULL,
    [nghe_nghiep_lan_dau]            NVARCHAR(200)    NULL,
    [nganh_lan_dau_id]               int      NULL,
    [ma_nghe_lan_dau]                int      NULL,
    [don_vi_lan_dau]                 int    NULL,
    [loai_dt_lan_dau_id]                  TINYINT      NULL,
    [gio_bi]                         TINYINT              NULL,
    [phut_bi]                        TINYINT              NULL,
    [lan_bi]                         TINYINT              NULL,
    
    -- Truy trả & Điều chỉnh khác
    [ngay_chuyen]                    int    NULL,   
    [ngay_chuyen_ve_dp]              int    NULL,
    [dc_den_thang]                   int    NULL,
    [chuyen_ve_tinh_noi_nhan_id]      int     NULL,
    [loai_qd]                        NVARCHAR(20)     NULL,
    [loai_cd_lan_truoc_id]            TINYINT     NULL,
    [thang_huong_lan_truoc]            int    NULL,
    [so_qd_huong_lan_truoc]                NVARCHAR(50)     NULL,
    [ma_ly_do]                       VARCHAR(10)      NULL,
    [ghi_chu]                        NVARCHAR(250)    NULL,
    [ho_so_thieu]                    NVARCHAR(250)    NULL,
    [st_truy_tra]                   int   NULL,
    [thang_truy_tra]                 int             NULL,
    [pc_pv_truy_tra]                 int   NULL,
    [print_infor_dv]                 NVARCHAR(500)    NULL,

    CONSTRAINT [PK_giai_quyet_cd_nh] PRIMARY KEY CLUSTERED ([giai_quyet_cd_id] ASC),
    CONSTRAINT [FK_cd_nh_giai_quyet_cd] FOREIGN KEY ([giai_quyet_cd_id]) REFERENCES [bhxh].[giai_quyet_cd] ([id]) ON DELETE CASCADE
);
GO