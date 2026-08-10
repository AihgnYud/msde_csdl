
-- 1. Bật cho phép chèn giá trị thủ công vào cột IDENTITY (giữ nguyên ID cũ)
SET IDENTITY_INSERT [dbo].[bhyt_the] ON;

-- 2. Thực hiện Chuyển đổi và Insert dữ liệu
INSERT INTO [dbo].[bhyt_the] (
    ----------------------------------------------------------------------------
    -- 1. ĐỊNH DANH & KHÓA CHÍNH
    ----------------------------------------------------------------------------
    [id],
    [guid],
    [the_cu_id],
    [order_number],

    ----------------------------------------------------------------------------
    -- 2. THÔNG TIN CÁ NHÂN
    ----------------------------------------------------------------------------
    [doi_tuong_id],
    [ho_ten],
    [ngay_sinh],
    [chi_nam_sinh],
    [gioi_tinh],
    [so_cccd],
    [ma_so_bhxh],
    [ma_so_bhxh_cu],
    [ma_so_bhxh_qn],
    [ho_ten_qn],
    [dia_chi],
    [tinh_id],
    [huyen_id],
    [xa_id],

    ----------------------------------------------------------------------------
    -- 3. THÔNG TIN THẺ BHYT & MÃ DANH MỤC
    ----------------------------------------------------------------------------
    [ma_the_bhyt],
    [ma_the_prefix],
    [loai_the],
    [madt_id],
    [madt_qn_id],
    [mabv_id],
    [ten_bv],
    [ma_khoi_kcb_id],
    [ma_tinh_kcb_id],
    [ma_tro_cap_id],
    [ma_dt_kcb_id],
    [ma_khu_vuc_song],
    [so_thang_lien_tuc],
    [ngay_nam_namlt],

    ----------------------------------------------------------------------------
    -- 4. ĐƠN VỊ
    ----------------------------------------------------------------------------
    [madv_id],

    ----------------------------------------------------------------------------
    -- 5. THỜI HẠN & TRẠNG THÁI NGHỆP VỤ
    ----------------------------------------------------------------------------
    [gtri_tu],
    [gtri_den],
    [ngay_cap],
    [lan_cap],
    [trang_thai],
    [loai_phat_sinh],
    [is_expired],

    ----------------------------------------------------------------------------
    -- 6. IN ẤN & PHÁT HÀNH THẺ
    ----------------------------------------------------------------------------
    [da_in],
    [ngay_in],
    [nguoi_in_id],
    [is_lock_print],
    [nguoi_lock_print_id],

    ----------------------------------------------------------------------------
    -- 7. THU HỒI & NỢ THẺ
    ----------------------------------------------------------------------------
    [ma_thu_hoi],
    [ngay_thu_hoi],
    [da_thu_hoi],
    [nguoi_thu_hoi_id],
    [is_no_the],
    [ngay_no_the],
    [nguoi_no_the_id],

    ----------------------------------------------------------------------------
    -- 8. PHÊ DUYỆT & ĐIỀU ĐỘNG
    ----------------------------------------------------------------------------
    [trang_thai_duyet],
    [ngay_duyet],
    [nguoi_duyet_id],
    [tt_duyet_dieu_dong],
    [ngay_duyet_dieu_dong],
    [nguoi_duyet_dieu_dong_id],

    ----------------------------------------------------------------------------
    -- 9. TÍCH HỢP VSS / ĐỒNG BỘ
    ----------------------------------------------------------------------------
    [is_syn_vss],
    [ngay_syn_vss],
    [so_cv],
    [ngay_cv],
    [so_Reference],
    [ngay_Reference],
    [renewal_key],
    [id_trung],

    ----------------------------------------------------------------------------
    -- 10. GHI CHÚ & BỔ SUNG
    ----------------------------------------------------------------------------
    [ghi_chu],
    [ghi_chu_thay_doi],
    [ghi_chu_check_bhvn],
    [ma_loi],

    ----------------------------------------------------------------------------
    -- 11. BỘ AUDIT FIELDS
    ----------------------------------------------------------------------------
    [created_at],
    [created_by],
    [updated_at],
    [updated_by],
    [deleted_at],
    [deleted_by],
    [is_deleted]
)
SELECT 
    -- 1. Định danh
    [id]                                        = [id],
    [guid]                                      = NEWID(),
    [the_cu_id]                                 = [MiCardOldId],
    [order_number]                              = [OrderNumber],

    -- 2. Thông tin cá nhân
    [doi_tuong_id]                              = [PersonalProfileId],
    [ho_ten]                                    = [FullName],
    [ngay_sinh]                                 = [DateOfBirth],
    [chi_nam_sinh]                              = [IsOnlyBirthYear],
    [gioi_tinh]                                 = CASE 
                                                    WHEN [Sex] IN ('1', 'M') THEN 1 
                                                    WHEN [Sex] IN ('0', 'F') THEN 0 
                                                    ELSE TRY_CAST([Sex] AS BIT) 
                                                  END,
    [so_cccd]                                   = LEFT([IdCardNumber], 12),
    [ma_so_bhxh]                                = [SiBookNum],
    [ma_so_bhxh_cu]                             = [SiBookNumOld],
    [ma_so_bhxh_qn]                             = [SiBookNumQn],
    [ho_ten_qn]                                 = [FullNameQn],
    [dia_chi]                                   = [Address],
    [tinh_id]                                   = [AddressProvinceId],
    [huyen_id]                                  = [AddressDistrictId],
    [xa_id]                                     = [AddressCommuneId],

    -- 3. Thông tin thẻ BHYT & Mã danh mục
    [ma_the_bhyt]                               = [MiCardNum],
    [ma_the_prefix]                             = [MiCardNumPrefix],
    [loai_the]                                  = [CardType],
    [madt_id]                                   = ISNULL([CategoryObjectId], 0), -- Đảm bảo NOT NULL
    [madt_qn_id]                                = [CategoryObjectQnId],
    [mabv_id]                                   = [CategoryHospitalId],
    [ten_bv]                                    = [HospitalName],
    [ma_khoi_kcb_id]                            = [CategoryMedicalBlockId],
    [ma_tinh_kcb_id]                            = [CategoryMedicalProvinceId],
    [ma_tro_cap_id]                             = [CategorySupportId],
    [ma_dt_kcb_id]                              = [CategoryMedicalObjectId],
    [ma_khu_vuc_song]                           = [LivingAreaCode],
    [so_thang_lien_tuc]                         = [NumberOfConsecutiveMonths],
    [ngay_nam_namlt]                            = [HighServiceDate],

    -- 4. Đơn vị
    [madv_id]                                   = [CategoryOrganizationId],

    -- 5. Thời hạn & Trạng thái
    [gtri_tu]                                   = [FromDate],
    [gtri_den]                                  = [ToDate],
    [ngay_cap]                                  = [IssuedDate],
    [lan_cap]                                   = [Issuance],
    [trang_thai]                                = [Status],
    [loai_phat_sinh]                            = [Type],
    [is_expired]                                = ISNULL([IsExpired], 0),

    -- 6. In ấn
    [da_in]                                     = ISNULL([IsPrinted], 0),
    [ngay_in]                                   = [PrintedDate],
    [nguoi_in_id]                               = TRY_CAST([UserPrintedId] AS BIGINT),
    [is_lock_print]                             = ISNULL([IsLockPrint], 0),
    [nguoi_lock_print_id]                       = TRY_CAST([UserLockPrintId] AS BIGINT),

    -- 7. Thu hồi & Nợ thẻ
    [ma_thu_hoi]                                = [ReduceCode],
    [ngay_thu_hoi]                              = COALESCE([RevokeDate], [ReduceDate]),
    [da_thu_hoi]                                = ISNULL([IsRevoke], 0),
    [nguoi_thu_hoi_id]                          = TRY_CAST([RevokeUserId] AS BIGINT),
    [is_no_the]                                 = ISNULL([IsDebt], 0),
    [ngay_no_the]                               = [DebtDate],
    [nguoi_no_the_id]                           = TRY_CAST([DebtUserId] AS BIGINT),

    -- 8. Phê duyệt
    [trang_thai_duyet]                          = [ApproveStatus],
    [ngay_duyet]                                = [ApproveDate],
    [nguoi_duyet_id]                            = TRY_CAST([ApproveUserId] AS BIGINT),
    [tt_duyet_dieu_dong]                        = [ApproveMoveStatus],
    [ngay_duyet_dieu_dong]                      = [ApproveMoveDate],
    [nguoi_duyet_dieu_dong_id]                  = TRY_CAST([ApproveMoveUserId] AS BIGINT),

    -- 9. Tích hợp VSS
    [is_syn_vss]                                = ISNULL([IsSynVss], 0),
    [ngay_syn_vss]                              = [SynVssDate],
    [so_cv]                                     = [ArriveDocumentCode],
    [ngay_cv]                                   = NULL,
    [so_Reference]                             = [ReferenceNumber],
    [ngay_Reference]                           = [ReferenceDate],
    [renewal_key]                               = [RenewalKey],
    [id_trung]                                  = [Idtrung],

    -- 10. Ghi chú
    [ghi_chu]                                   = [Note],
    [ghi_chu_thay_doi]                          = [ChangedInfoNote],
    [ghi_chu_check_bhvn]                        = [NoteCheckBhvn],
    [ma_loi]                                    = [ErrorCode],

    -- 11. Audit Fields
    [created_at]                                = ISNULL([created_at], SYSDATETIMEOFFSET()),
    [created_by]                                = TRY_CAST([UserId] AS BIGINT),
    [updated_at]                                = CAST([UpdatedDate] AS DATETIMEOFFSET),
    [updated_by]                                = NULL,
    [deleted_at]                                = NULL,
    [deleted_by]                                = NULL,
    [is_deleted]                                = 0
FROM [dbo].[healthcarddtl];

-- 3. Tắt IDENTITY_INSERT sau khi xong
SET IDENTITY_INSERT [dbo].[bhyt_the] OFF;
GO