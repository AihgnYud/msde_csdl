IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bhyt_the]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[bhyt_the] (
        --------------------------------------------------------------------------------
        -- 1. ĐỊNH DANH & KHÓA CHÍNH (Dual-ID)
        --------------------------------------------------------------------------------
        [id]                        BIGINT IDENTITY(1,1) NOT NULL,
        [guid]                      UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Public Key cho API
        [the_cu_id]                 BIGINT NULL,                              -- MiCardOldId (Thẻ cũ)
        [order_number]              INT NULL,                                 -- Số thứ tự

        --------------------------------------------------------------------------------
        -- 2. THÔNG TIN CÁ NHÂN (Personal Profile)
        --------------------------------------------------------------------------------
        [doi_tuong_id]              BIGINT NULL,                              -- PersonalProfileId
        [ho_ten]                    NVARCHAR(150) NULL,
        [ngay_sinh]                 int NULL,                          -- YYYYMMDD
        [chi_nam_sinh]              TINYINT NULL,                             -- Chỉ có năm sinh
        [gioi_tinh]                 BIT NULL,                                 -- 1: Nam, 0: Nữ
        [so_cccd]                   VARCHAR(12) NULL,                         -- ID Card 12 số
        [ma_so_bhxh]                VARCHAR(12) NULL,                         -- SiBookNum
        [ma_so_bhxh_cu]             VARCHAR(12) NULL,                         -- SiBookNumOld
        [ma_so_bhxh_qn]             VARCHAR(12) NULL,                         -- SiBookNumQn (Quân nhân)
        [ho_ten_qn]                 NVARCHAR(150) NULL,
        [dia_chi]                   NVARCHAR(255) NULL,
        [tinh_id]                   SMALLINT NULL,                            -- AddressProvinceId
        [huyen_id]                  SMALLINT NULL,                            -- AddressDistrictId
        [xa_id]                     SMALLINT NULL,                            -- AddressCommuneId

        --------------------------------------------------------------------------------
        -- 3. THÔNG TIN THẺ BHYT & MÃ DANH MỤC
        --------------------------------------------------------------------------------
        [ma_the_bhyt]               VARCHAR(17) NULL,                         -- MiCardNum
        [ma_the_prefix]             VARCHAR(2) NULL,                          -- MiCardNumPrefix
        [loai_the]                  NVARCHAR(15) NULL,                        -- CardType
        [madt_id]                   SMALLINT NOT NULL,                        -- CategoryObjectId
        [madt_qn_id]                SMALLINT NULL,                            -- CategoryObjectQnId
        [mabv_id]                   SMALLINT NULL,                            -- CategoryHospitalId
        [ten_bv]                     NVARCHAR(255) NULL,                       -- HospitalName
        [ma_khoi_kcb_id]            SMALLINT NULL,                            -- CategoryMedicalBlockId
        [ma_tinh_kcb_id]            SMALLINT NULL,                            -- CategoryMedicalProvinceId
        [ma_tro_cap_id]             SMALLINT NULL,                            -- CategorySupportId
        [ma_dt_kcb_id]              SMALLINT NULL,                            -- CategoryMedicalObjectId
        [ma_khu_vuc_song]           VARCHAR(5) NULL,                          -- LivingAreaCode (KV1, KV2...)
        [so_thang_lien_tuc]         INT NULL,                                 -- NumberOfConsecutiveMonths
        [ngay_nam_namlt]            DATE NULL,                                -- HighServiceDate

        --------------------------------------------------------------------------------
        -- 4. ĐƠN VỊ & QUẢN LÝ 5 CẤP
        --------------------------------------------------------------------------------
        [madv_id]                 BIGINT NOT NULL,                          -- CategoryOrganizationId       

        --------------------------------------------------------------------------------
        -- 5. THỜI HẠN & TRẠNG THÁI NGHỆP VỤ
        --------------------------------------------------------------------------------
        [gtri_tu]              DATE NULL,                                -- FromDate
        [gtri_den]             DATE NULL,                                -- ToDate
        [ngay_cap]                  DATE NULL,                                -- IssuedDate
        [lan_cap]                   TINYINT NULL ,                   -- Issuance
        [trang_thai]                TINYINT NULL,                             -- Status
        [loai_phat_sinh]            VARCHAR(2) NULL,                          -- Type
        [is_expired]                BIT NULL DEFAULT 0,                       -- Het han

        --------------------------------------------------------------------------------
        -- 6. IN ẤN & PHÁT HÀNH THẺ
        --------------------------------------------------------------------------------
        [da_in]                     BIT NULL DEFAULT 0,                       -- IsPrinted
        [ngay_in]                   DATE NULL,                                -- PrintedDate
        [nguoi_in_id]               BIGINT NULL,                              -- UserPrintedId
        [is_lock_print]             BIT NULL DEFAULT 0,
        [nguoi_lock_print_id]       BIGINT NULL,                              -- UserLockPrintId

        --------------------------------------------------------------------------------
        -- 7. THU HỒI & NỢ THẺ
        --------------------------------------------------------------------------------
        [ma_thu_hoi]                VARCHAR(5) NULL,                          -- ReduceCode
        [ngay_thu_hoi]              DATE NULL,                                -- ReduceDate / RevokeDate
        [da_thu_hoi]                BIT NULL DEFAULT 0,                       -- IsRevoke
        [nguoi_thu_hoi_id]          BIGINT NULL,                              -- RevokeUserId
        --Các trường sau này có thể xóa
        [is_no_the]                 BIT NULL DEFAULT 0,                       -- IsDebt
        [ngay_no_the]               DATE NULL,                                -- DebtDate
        [nguoi_no_the_id]           BIGINT NULL,                              -- DebtUserId

        --------------------------------------------------------------------------------
        -- 8. PHE DUYỆT & ĐIỀU ĐỘNG (Phân hoạch đơn vị)
        --------------------------------------------------------------------------------
        [trang_thai_duyet]          TINYINT NULL,                             -- ApproveStatus
        [ngay_duyet]                DATE NULL,                                -- ApproveDate
        [nguoi_duyet_id]            BIGINT NULL,                              -- ApproveUserId
        --Các trường sau này có thể xóa
        [tt_duyet_dieu_dong]        TINYINT NULL,                             -- ApproveMoveStatus
        [ngay_duyet_dieu_dong]      DATE NULL,                                -- ApproveMoveDate
        [nguoi_duyet_dieu_dong_id]  BIGINT NULL,                              -- ApproveMoveUserId

        --------------------------------------------------------------------------------
        -- 9. TÍCH HỢP VSS / ĐỒNG BỘ 
        --------------------------------------------------------------------------------
        [is_syn_vss]                BIT NULL DEFAULT 0,                       -- Đã đồng bộ VSS
        [ngay_syn_vss]              DATE NULL,                                -- SynVssDate
        [so_cv]                     VARCHAR(50) NULL,                         -- ArriveDocumentCode
        [ngay_cv]                   DATE NULL,
        --Sau này có thể xóa
        [so_Reference]             VARCHAR(50) NULL,                         -- ReferenceNumber
        [ngay_Reference]           DATE NULL,                                -- ReferenceDate
        [renewal_key]               NVARCHAR(25) NULL,
        [id_trung]                  BIGINT NULL,                              -- Idtrung

        --------------------------------------------------------------------------------
        -- 10. GHI CHÚ & BỔ SUNG
        --------------------------------------------------------------------------------
        [ghi_chu]                   NVARCHAR(500) NULL,                       -- Note
        --Sau này có thể xóa
        [ghi_chu_thay_doi]          NVARCHAR(255) NULL,                       -- ChangedInfoNote
        [ghi_chu_check_bhvn]        NVARCHAR(1000) NULL,                      -- NoteCheckBhvn
        [ma_loi]                    NVARCHAR(255) NULL,                       -- ErrorCode

        --------------------------------------------------------------------------------
        -- 11. BỘ AUDIT FIELDS CHUẨN (Quản lý vòng đời dữ liệu)
        --------------------------------------------------------------------------------
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                BIGINT NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                BIGINT NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                BIGINT NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0,                   -- 0: Dùng, 1: Xóa mềm

        CONSTRAINT [PK_bhyt_the] PRIMARY KEY CLUSTERED ([id] ASC),
        -- Ràng buộc khóa ngoại
        CONSTRAINT FK_bhyt_the_donvi FOREIGN KEY ([madv_id]) REFERENCES dm.don_vi([id])
    );
END
GO

--------------------------------------------------------------------------------
-- CÁC INDEX TỐI ƯU CƠ BẢN
--------------------------------------------------------------------------------

-- Index cho GUID (API / Integration)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'uq_idx_bhyt_the_guid' AND object_id = OBJECT_ID(N'[dbo].[bhyt_the]'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX [uq_idx_bhyt_the_guid] ON [dbo].[bhyt_the]([guid]);
END
GO

-- 1. Index tra cứu theo Mã số BHXH
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_bhyt_the_ma_so_bhxh' AND object_id = OBJECT_ID(N'[dbo].[bhyt_the]'))
BEGIN
    CREATE NONCLUSTERED INDEX [idx_bhyt_the_ma_so_bhxh] 
    ON [dbo].[bhyt_the]([ma_so_bhxh]) 
    WHERE [is_deleted] = 0 AND [ma_so_bhxh] IS NOT NULL;
END
GO

-- 2. Index tra cứu theo Số CCCD
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'idx_bhyt_the_so_cccd' AND object_id = OBJECT_ID(N'[dbo].[bhyt_the]'))
BEGIN
    CREATE NONCLUSTERED INDEX [idx_bhyt_the_so_cccd] 
    ON [dbo].[bhyt_the]([so_cccd]) 
    WHERE [is_deleted] = 0 AND [so_cccd] IS NOT NULL;
END
GO
