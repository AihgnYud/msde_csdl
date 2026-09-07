-- Tạo Schema nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bhxh')
BEGIN
    EXEC('CREATE SCHEMA [bhxh]');
END
GO

-- =============================================================================
-- 1. BẢNG THÔNG TIN CHUNG GIẢI QUYẾT CHẾ ĐỘ (DÙNG CHUNG CHO CẢ NH VÀ DH dài hạn)
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
     [nam]                     TINYINT         NULL,
     [dot]                     TINYINT         NULL,    
    -- Thông tin quân nhân / người hưởng tại thời điểm giải quyết     
     [loai_dt_id]                     TINYINT NULL ,-- (tỐI ĐA 32,767 NÊN CHUYỂN SANG TINYINT) join bảng dm đối tượng để biết SQ hay QNCN
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
    -- Quản lý hồ sơ & Hệ thống
    [trang_thai]                TINYINT              NULL,      
    [ngay_duyet]             int      NULL,  -- YYYYMMDD, 
    [ngay_cho_so]             DATETIME         NULL,
    [nguoi_cho_so]            VARCHAR(50)      NULL,
   
    [so_che_do]               VARCHAR(20)      NULL,
    [so_ho_so]                VARCHAR(20)      NULL,
    [dien_quan_ly]            TINYINT              NULL,
    [phi_gdyk]                DECIMAL(10, 2)   NULL,
    [tyle_sgknld]                     TINYINT              NULL,--Tối đa lưu được 255, giá trị tối đa 100
    
    [loai_gq]                 INT              NULL,
    [sqd_dc]                  VARCHAR(20)      NULL,
    [ngay_ky_dc]              int      NULL,  -- YYYYMMDD, 
    [chuc_vu_dc]              NVARCHAR(100)    NULL,
    
    -- Tích hợp BHXH Việt Nam
    [exp_bhxhvn]              INT              NULL,
    [ngay_chuyen_vn]          int      NULL,  -- YYYYMMDD, 
    
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
