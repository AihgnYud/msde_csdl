-- Tạo Schema nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bhxh')
BEGIN
    EXEC('CREATE SCHEMA [bhxh]');
END
GO

-- =============================================================================
-- 1. BẢNG THÔNG TIN CHUNG GIẢI QUYẾT CHẾ ĐỘ (DÙNG CHUNG CHO CẢ NH VÀ DH)
-- =============================================================================
CREATE TABLE [bhxh].[giai_quyet_cd] (
     [id]                        BIGINT IDENTITY(1,1) NOT NULL,
     [guid]                      UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Public Key cho API
     doi_tuong_id bigint not null,  --chế độ của đối tượng nào    
     [ho_ten]                    NVARCHAR(150) NULL,
     [ngay_sinh]                 int NULL,                          -- YYYYMMDD, nếu chỉ có năm sinh 19780000, nếu chỉ có tháng và năm 19781100        
     [gioi_tinh]                 BIT NULL,                                 -- 1: Nam, 0: Nữ
     [so_cccd]                   VARCHAR(12) NULL,                         -- ID Card 12 số  
     [ma_so_bhxh]               VARCHAR(12) NULL,               
     [so_qd]                    NVARCHAR(20) NULL,   
     [ngay_ky]                  int      NULL,  -- YYYYMMDD, 
     [nam]                     SMALLINT         NULL,
     [dot]                     SMALLINT         NULL,    
    -- Thông tin quân nhân / người hưởng tại thời điểm giải quyết
     [loai_dt_id]                     TINYINT NULL,--join bảng dm đối tượng để biết SQ hay QNCN
     [ma_doi_tuong]            VARCHAR(10)      NULL,
     [cap_bac_id]                     TINYINT NULL,
     [cap_bac]                 NVARCHAR(50)     NULL,
     [chuc_vu_id]                     int NULL,        
     [chuc_vu]                 NVARCHAR(150)    NULL,
     [nghe_nghiep_id]                 int NULL,
     [nghe_nghiep]             NVARCHAR(200)    NULL,
     [don_vi_id]                     int NULL,
     [tuoi]                    SMALLINT         NULL,            
    -- Thời gian & Loại chế độ
    [thang_huong]             int not null,--yyyyMM
    [loai_cd_id]               TINYINT NULL,--join bảng dm chế độ để biết là bảng nào
    [bh_tu]                   int  null,--yyyyMM
    [bh_den]                  int  null,--yyyyMM
    [so_thang_bh]             TINYINT              NULL,--Tối đa lưu được 255, giá trị tối đa 100
    [so_thang_tq]             TINYINT              NULL,
    [so_thang_vcqp]             TINYINT              NULL,
    
    -- Kết quả Xét duyệt & Đề xuất (XD)
    [thang_huong_xd]          DATE             NULL,
    [loai_cdcs_xd]            VARCHAR(10)      NULL,
    [bh_tu_thang_nam_xd]      DATE             NULL,
    [bh_den_thang_nam_xd]     DATE             NULL,
    [so_thang_bh_xd]          INT              NULL,
    [so_thang_tq_xd]          INT              NULL,
    [so_thang_vc_xd]          INT              NULL,
    [so_tien_tc]              DECIMAL(15, 3)   NULL,
    [so_tien_tc_xd]           DECIMAL(15, 3)   NULL,
    
    -- Chuyển vùng / Địa chỉ
    [chuyen_ve_tinh]          VARCHAR(10)      NULL,
    [chuyen_ve_huyen]         VARCHAR(10)      NULL,
    [chuyen_ve_xa]            VARCHAR(10)      NULL,
    [chuyen_ve_ngo_xom]       NVARCHAR(150)    NULL,
    
    -- Quản lý hồ sơ & Hệ thống
    [xet_duyet]               VARCHAR(10)      NULL,
    [ngay_duyet]              DATE             NULL,
    [ngay_cho_so]             DATETIME         NULL,
    [nguoi_cho_so]            VARCHAR(50)      NULL,
    [so_che_do]               VARCHAR(20)      NULL,
    [so_ho_so]                VARCHAR(20)      NULL,
    [dien_quan_ly]            VARCHAR(10)      NULL,
    [phi_gdyk]                DECIMAL(10, 2)   NULL,
    [loai_gq]                 INT              NULL,
    [sqd_dc]                  VARCHAR(20)      NULL,
    [ngay_ky_dc]              DATE             NULL,
    [chuc_vu_dc]              NVARCHAR(100)    NULL,
    
    -- Tích hợp BHXH Việt Nam
    [exp_bhxhvn]              INT              NULL,
    [ngay_chuyen_vn]          DATETIME         NULL,
    
    -- Audit Logs
     --------------------------------------------------------------------------------
    [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    [created_by]                BIGINT NULL,                              -- ID người tạo
    [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
    [updated_by]                BIGINT NULL,                              -- ID người sửa
    [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
    [deleted_by]                BIGINT NULL,                              -- ID người xóa mềm
    [is_deleted]                BIT NOT NULL DEFAULT 0,                   -- 0: Dùng, 1: Xóa mềm    
    CONSTRAINT [PK_giai_quyet_cd] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

-- =============================================================================
-- 2. BẢNG GIẢI QUYẾT CHẾ ĐỘ DÀI HẠN (DÀI HẠN / HƯU TRÍ / TỬ TUẤT...)
-- =============================================================================
CREATE TABLE [bhxh].[giai_quyet_cd_dh] (
    [giai_quyet_cd_id]               UNIQUEIDENTIFIER NOT NULL,
    
    -- Số tháng đặc thù
    [so_thang_lvdb]                  INT              NULL,
    [so_thang_lvnn]                  INT              NULL,
    [so_thang_pckv07]                INT              NULL,
    [so_thang_ham_lo]                INT              NULL,
    [so_thang_huong]                 DECIMAL(6, 3)    NULL,
    [so_thang_tc]                    DECIMAL(5, 2)    NULL,
    [so_thang_tinh_tn]               INT              NULL,
    [so_thang_bh_truoc_2014]         INT              NULL,
    [so_thang_bck]                   INT              NULL,
    [so_thang_cdv]                   INT              NOT NULL DEFAULT 0,
    [so_thang_cnqp]                  INT              NOT NULL DEFAULT 0,
    [so_thang_truoc_tuoi_nd177_178]  INT              NULL,
    [so_thang_lvdbdt]                INT              NOT NULL DEFAULT 0,
    [so_thang_tc_05]                 DECIMAL(5, 2)    NULL,
    
    -- Thông tin Xét duyệt (XD) đặc thù
    [so_thang_lvdb_xd]               INT              NULL,
    [so_thang_lvnn_xd]               INT              NULL,
    [so_thang_pckv07_xd]             INT              NULL,
    [so_thang_ham_lo_xd]             INT              NULL,
    [so_thang_huong_xd]              DECIMAL(8, 2)    NULL,
    [so_thang_tc_xd]                 DECIMAL(5, 2)    NULL,
    [so_thang_tinh_tn_xd]            INT              NULL,
    [so_thang_bh_truoc_2014_xd]      INT              NULL,
    [so_thang_bck_xd]                INT              NULL,
    
    -- Luơng, Trợ cấp & Hệ số
    [luong_bq]                       DECIMAL(15, 3)   NULL,
    [luong_bq_xd]                    DECIMAL(15, 3)   NULL,
    [pckv_bh]                        DECIMAL(15, 3)   NULL,
    [pckv_bh_xd]                     DECIMAL(15, 3)   NULL,
    [pckv_nn]                        DECIMAL(15, 3)   NULL,
    [pckv_nn_xd]                     DECIMAL(15, 3)   NULL,
    [tyle_phantram]                  DECIMAL(5, 4)    NULL,
    [luong_huu]                      DECIMAL(15, 3)   NULL,
    [luong_huu_xd]                   DECIMAL(15, 3)   NULL,
    [he_so_dc]                       DECIMAL(5, 3)    NULL,
    [he_so_dc_xd]                    DECIMAL(5, 3)    NULL,
    [so_tien_mt]                     DECIMAL(15, 3)   NULL,
    [so_tien_mt_xd]                  DECIMAL(15, 3)   NULL,
    
    -- Hệ số lương & Phụ cấp
    [hsl]                            DECIMAL(18, 2)   NULL,
    [pccv]                           DECIMAL(18, 2)   NULL,
    [tnvk]                           DECIMAL(8, 2)    NULL,
    [tnng]                           DECIMAL(8, 2)    NULL,
    [hsbl]                           DECIMAL(10, 2)   NULL,
    [pckv]                           DECIMAL(8, 2)    NULL,
    
    -- Tử tuất & Thương tật
    [ngay_chet]                      DATE             NULL,
    [ly_do_chet]                     NVARCHAR(150)    NULL,
    [so_tien_chet_do_tnld_bnn]       DECIMAL(15, 3)   NULL,
    [so_tien_chet_do_tnld_bnn_xd]    DECIMAL(15, 3)   NULL,
    [hiv]                            BIT              NULL,
    [hiv_xd]                         BIT              NULL,
    [tyle_sgknld]                    DECIMAL(5, 2)    NULL,
    [tyle_sgknld_xd]                 DECIMAL(5, 2)    NULL,
    
    -- Thông tin ký đơn vị
    [sqd_dv]                         NVARCHAR(30)     NULL,
    [ngay_ky_dv]                     DATE             NULL,
    [chuc_vu_ky_dv]                  NVARCHAR(50)     NULL,
    [loai_hs]                        VARCHAR(10)      NULL,
    [tc_tau_xe]                      DECIMAL(15, 3)   NULL,
    [dong_con_thieu_so_thang]        INT              NULL,
    [dong_con_thieu_tai_thang]       DATE             NULL,
    [loai_cdcs_dc]                   VARCHAR(10)      NULL,
    [thang_huong_dc]                 DATE             NULL,
    [tc1lan_x2]                      BIT              NULL,

    CONSTRAINT [PK_giai_quyet_cd_dh] PRIMARY KEY CLUSTERED ([giai_quyet_cd_id] ASC),
    CONSTRAINT [FK_cd_dh_giai_quyet_cd] FOREIGN KEY ([giai_quyet_cd_id]) REFERENCES [bhxh].[giai_quyet_cd] ([id]) ON DELETE CASCADE
);
GO

-- =============================================================================
-- 3. BẢNG GIẢI QUYẾT CHẾ ĐỘ NGẮN HẠN (TNNLĐ / BNN / ỐM ĐAU / THAI SẢN...)
-- =============================================================================
CREATE TABLE [bhxh].[giai_quyet_cd_nh] (
    [giai_quyet_cd_id]               UNIQUEIDENTIFIER NOT NULL,
    
    -- Thông tin Tai nạn lao động / BNN
    [ngay_tnld_bnn]                  DATE             NULL,
    [ngay_ra_vien]                   DATE             NULL,
    [ngay_tnld_bnn_xd]               DATE             NULL,
    [ngay_tnld_bnn_pre]              DATE             NULL,
    
    -- Mức lương & Trợ cấp TNNLĐ/BNN
    [luong_ttc]                      DECIMAL(15, 3)   NULL,
    [luong_ttc_xd]                   DECIMAL(15, 3)   NULL,
    [muc_luong_can_cu]               DECIMAL(15, 3)   NULL,
    [muc_luong_can_cu_xd]            DECIMAL(15, 3)   NULL,
    [muc_luong_truoc_bi_tn]          DECIMAL(15, 3)   NULL,
    [tyle_sgknld]                    DECIMAL(5, 2)    NULL,
    [tyle_sgknld_xd]                 DECIMAL(5, 2)    NULL,
    [tyle_sgknld_pre]                DECIMAL(5, 2)    NULL,
    
    -- Các khoản Trợ cấp
    [st_tro_cap_tyle]                DECIMAL(15, 3)   NULL,
    [st_tro_cap_tyle_xd]             DECIMAL(15, 3)   NULL,
    [st_tro_cap_tyle_pre]            DECIMAL(15, 3)   NULL,
    [st_tro_cap_tg]                  DECIMAL(15, 3)   NULL,
    [st_tro_cap_tg_xd]               DECIMAL(15, 3)   NULL,
    [st_tro_cap_tg_pre]              DECIMAL(15, 3)   NULL,
    [st_tro_cap_sau_dc]              DECIMAL(15, 3)   NULL,
    [so_tien_tc_he_so]               DECIMAL(5, 3)    NULL,
    [so_tien_tc_hien_huong]          DECIMAL(15, 3)   NULL,
    
    -- Phụ cấp Phục vụ & Phục hồi chức năng
    [pc_phuc_vu_thang]               DECIMAL(15, 3)   NULL,
    [pc_phuc_vu_thang_xd]            DECIMAL(15, 3)   NULL,
    [pc_phuc_vu_thang_sau_dc]        DECIMAL(15, 3)   NULL,
    [pc_phuc_hoi_cn]                 DECIMAL(15, 3)   NULL,
    [pc_phuc_hoi_cn_xd]              DECIMAL(15, 3)   NULL,
    
    -- Lần bị / Lần đầu
    [gio_bi_lan_dau]                 INT              NULL,
    [phut_bi_lan_dau]                INT              NULL,
    [ngay_bi_lan_dau]                DATE             NULL,
    [cap_bac_lan_dau]                NVARCHAR(50)     NULL,
    [ma_cap_bac_lan_dau]             VARCHAR(10)      NULL,
    [chuc_vu_lan_dau]                NVARCHAR(150)    NULL,
    [ma_chuc_vu_lan_dau]             VARCHAR(10)      NULL,
    [nghe_nghiep_lan_dau]            NVARCHAR(200)    NULL,
    [ma_nganh_lan_dau]               VARCHAR(10)      NULL,
    [ma_nghe_lan_dau]                VARCHAR(10)      NULL,
    [don_vi_lan_dau]                 NVARCHAR(150)    NULL,
    [ma_dt_lan_dau]                  VARCHAR(10)      NULL,
    [gio_bi]                         INT              NULL,
    [phut_bi]                        INT              NULL,
    [lan_bi]                         INT              NULL,
    
    -- Truy trả & Điều chỉnh khác
    [ngay_chuyen]                    DATE             NULL,
    [ngay_chuyen_ve_dp]              DATETIME         NULL,
    [dc_den_thang]                   DATE             NULL,
    [chuyen_ve_tinh_noi_nhan]        VARCHAR(10)      NULL,
    [loai_qd]                        NVARCHAR(20)     NULL,
    [loai_cdcs_pre]                  VARCHAR(10)      NULL,
    [thang_huong_pre]                DATE             NULL,
    [so_qd_huong_pre]                NVARCHAR(50)     NULL,
    [ma_ly_do]                       VARCHAR(10)      NULL,
    [ghi_chu]                        NVARCHAR(250)    NULL,
    [ho_so_thieu]                    NVARCHAR(250)    NULL,
    [st_truy_tra]                    DECIMAL(15, 3)   NULL,
    [thang_truy_tra]                 DATE             NULL,
    [pc_pv_truy_tra]                 DECIMAL(15, 3)   NULL,
    [print_infor_dv]                 NVARCHAR(MAX)    NULL,

    CONSTRAINT [PK_giai_quyet_cd_nh] PRIMARY KEY CLUSTERED ([giai_quyet_cd_id] ASC),
    CONSTRAINT [FK_cd_nh_giai_quyet_cd] FOREIGN KEY ([giai_quyet_cd_id]) REFERENCES [bhxh].[giai_quyet_cd] ([id]) ON DELETE CASCADE
);
GO