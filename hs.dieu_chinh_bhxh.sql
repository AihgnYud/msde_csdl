-- 1. Tạo Schema hs (Hồ sơ) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'hs')
BEGIN
    EXEC('CREATE SCHEMA hs');
END
GO
-- 2. Tạo Bảng hs.dieu_chinh_bhxh
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[hs].[dieu_chinh_bhxh]') AND type in (N'U'))
BEGIN
    CREATE TABLE hs.dieu_chinh_bhxh (
        [id]                        BIGINT IDENTITY(1,1) NOT NULL,
        [guid]                      UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Public Key cho API
        doi_tuong_id bigint not null,  --Biến động của đối tượng nào      
        tu_thang int not null,--yyyyMM
        den_thang int not null,--yyyyMM
        [loai_dt_id]                     TINYINT NULL,--join bảng dm đối tượng để biết SQ hay QNCN
        [cap_bac_id]                     TINYINT NULL,
        [chuc_vu_id]                     int NULL,        
        [nghe_nghiep_id]                     int NULL,
        [pa_tang_id]                     TINYINT NULL,--Phương án điều chỉnh tăng
        [pa_giam_id]                     TINYINT NULL,--Phương án điều chỉnh giảm
        [don_vi_id]                     int NULL,
        [don_vi_chuyen_id]              int NULL,--Chuyển đi hay chuyển đến đơn vị nào
        [hsl]               DECIMAL(4, 2) NULL, -- Hệ số lương (VD: 4.65, 10.00)
        [luong]             INT NULL,          -- Tiền lương khoán/HĐLĐ (VNĐ)
        [hs_cv]             DECIMAL(4, 2) NULL, -- Hệ số chức vụ (VD: 0.25, 1.10)
        [phu_cap_cv]        INT NULL,          -- Phụ cấp chức vụ bằng tiền đồng (VNĐ)
        [tham_nien_ng]      TINYINT NULL,       -- % Thâm niên nghề (0 -> 100)
        [tham_nien_vk]      TINYINT NULL,        -- % Thâm niên vượt khung (0 -> 100)
        [hs_bao_luu]        DECIMAL(5, 3) NULL, -- Hệ số bảo lưu (VD: 0.15)
        [phu_cap_khac]      INT NULL,          -- Phụ cấp khác bằng tiền đồng (VNĐ)
		[phu_cap_kv]           DECIMAL(4, 2) NULL, -- Phụ cấp khu vực
		[phu_cap_bck]           DECIMAL(4, 2) NULL, -- Phụ cấp khu vực
        [tong_luong]        INT NOT NULL,      -- Tổng số tiền tính đóng BHXH 
        [tc_tnld_bnn]        INT  NULL,      -- Trợ cấp tnld_bnn 
        [giai_quyet_cd_id] bigint null,  --Là hồ sơ giải quyết chế độ nào
        [ghi_chu]        NVARCHAR(200) NULL,  -- Ghi chú tự do
        --------------------------------------------------------------------------------
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                BIGINT NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                BIGINT NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                BIGINT NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0,                   -- 0: Dùng, 1: Xóa mềm
        --forenky các trường trong danh mục xã, huyện, tỉnh
         FOREIGN KEY (doi_tuong_id) REFERENCES hs.doi_tuong(id) ,
         CONSTRAINT FK_don_vi_id FOREIGN KEY ([don_vi_id]) REFERENCES dm.don_vi([id]),
        )
End

/*
Nếu không có dòng $D_2$ (dòng giảm triệt tiêu), thuật toán SQL 2 chiều (Two-Dimensional Ordering) nêu trên sẽ thất bại hoàn toàn ở Báo cáo Biến động và gây lỗi tính trùng ở Báo cáo Chi trả.Dưới đây là lời giải chi tiết cho câu hỏi của bạn: Nếu giữ nguyên $D_1$ và sinh cả $D_2, D_3$, chúng ta sẽ truy vấn Báo cáo Tháng 4 thế nào?1. Báo cáo BIẾN ĐỘNG (Thống kê số Tăng/Giảm phát sinh trong Tháng 4/2026)Báo cáo biến động (Mẫu D02-LT gửi BHXH) chỉ quan tâm đến các giao dịch mới phát sinh trong kỳ (lọc theo thang_phat_sinh = 202604).
SELECT doi_tuong_id, pa_tang, pa_giam, luong 
FROM hs.dieu_chinh_bhxh
WHERE ma_don_vi = '10.01.103.01' 
  AND thang_phat_sinh = 202604;

  Kết quả quét CSDL:Bỏ qua $D_1$: Vì $D_1$ có thang_phat_sinh = 202601 (biến động của quá khứ).Quét thấy $D_2$ (pa_giam = 'DC', luong = 10M): Đưa quân nhân vào cột GIẢM ĐIỀU CHỈNH (Giảm mức 10 triệu cũ).Quét thấy $D_3$ (pa_tang = 'DC', luong = 12M): Đưa quân nhân vào cột TĂNG ĐIỀU CHỈNH (Tăng mức 12 triệu mới).👉 Ý nghĩa nghiệp vụ: Báo cáo biến động thể hiện chính xác 100% bản chất: Trong tháng 4, quân nhân X đóng sổ mức lương cũ 10M và mở sổ mức lương mới 12M. (Nếu không có $D_2$, cơ quan BHXH sẽ không biết phải giảm mức 10M cũ).2. Báo cáo DANH SÁCH CHI TRẢ / THU NỘP (Số tiền thực chi Tháng 4/2026)Khi xuất danh sách chi trả Tháng 4/2026, CSDL đang chứa cả 3 dòng:$D_1$: tu_thang: 202601, den_thang: 202604, thang_phat_sinh: 202601, luong: 10M$D_2$: tu_thang: 202604, den_thang: 202604, thang_phat_sinh: 202604, luong: 10M, pa_giam: 'DC' (Anti-Record)$D_3$: tu_thang: 202604, den_thang: NULL, thang_phat_sinh: 202604, luong: 12M, pa_tang: 'DC'Có 2 cách truy vấn SQL tùy theo mục đích báo cáo:Cách A: Thuật toán Cộng trừ Triệt tiêu (Dùng cho Báo cáo Tổng hợp Quỹ Lương)Bạn tính tổng tiền bằng cách lấy Tăng - Giảm:

  SELECT 
    doi_tuong_id,
    -- D1 (10M Tăng) - D2 (10M Giảm) + D3 (12M Tăng) = 12M
    SUM(CASE WHEN pa_tang IS NOT NULL THEN luong ELSE 0 END) - 
    SUM(CASE WHEN pa_giam IS NOT NULL THEN luong ELSE 0 END) AS luong_thuc_huong
FROM hs.dieu_chinh_bhxh
WHERE ma_don_vi = '10.01.103.01'
  AND tu_thang <= 202604 
  AND (den_thang IS NULL OR den_thang >= 202604)
  AND thang_phat_sinh <= 202604
GROUP BY doi_tuong_id;

👉 Kết quả: $10.000.000 - 10.000.000 + 12.000.000 = \mathbf{12.000.000 \text{ VNĐ}}$.Cách B: Thuật toán Ưu tiên Dòng Tăng mới nhất (Dùng cho Danh sách Chi tiết)Nếu xuất danh sách từng người, bạn lọc lấy bản ghi TĂNG MỚI NHẤT tính đến Tháng 4:

WITH ValidRecords AS (
    SELECT 
        doi_tuong_id, luong, pa_tang, pa_giam, thang_phat_sinh, id,
        ROW_NUMBER() OVER (
            PARTITION BY doi_tuong_id 
            -- Ưu tiên dòng phát sinh mới nhất, nếu cùng tháng phát sinh thì lấy dòng Tăng (D3)
            ORDER BY thang_phat_sinh DESC, CASE WHEN pa_tang IS NOT NULL THEN 1 ELSE 2 END, id DESC
        ) as rn
    FROM hs.dieu_chinh_bhxh
    WHERE ma_don_vi = '10.01.103.01'
      AND tu_thang <= 202604 
      AND (den_thang IS NULL OR den_thang >= 202604)
      AND thang_phat_sinh <= 202604
)
SELECT doi_tuong_id, luong 
FROM ValidRecords 
WHERE rn = 1; -- Nhặt duy nhất dòng D3 (Mức lương 12 triệu)

3. Điều gì xảy ra khi In lại Báo cáo Tháng 3/2026 (Quá khứ)?Khi sếp hoặc đoàn kiểm tra yêu cầu in lại Báo cáo Tháng 03/2026:SQL sẽ chạy với điều kiện: thang_phat_sinh <= 202603.Cả $D_2$ và $D_3$ đều có thang_phat_sinh = 202604 nên lập tức bị gạt ra ngoài.Hệ thống chỉ nhìn thấy $D_1$ (tu_thang: 202601, den_thang: 202604, luong: 10M).Kết quả Tháng 3 ra đúng 10.000.000 VNĐ $\rightarrow$ Khớp 100% với con số đã đóng sổ/ký duyệt vào tháng trước.Kết luậnBắt buộc phải sinh $D_2$ để phục vụ Báo cáo Biến động (đóng sổ khoản 10M cũ) và làm Triệt tiêu số liệu khi dùng phép cộng dồn quỹ.Không sửa $D_1$ để bảo vệ tính bất biến (Immutable) của lịch sử kiểm toán.Cách truy vấn rất đơn giản:Báo cáo Biến động: Lọc thang_phat_sinh = KyBaoCao.Báo cáo Thực chi: Lọc thang_phat_sinh <= KyBaoCao kết hợp SUM(Tăng - Giảm) hoặc ROW_NUMBER().


Quyết định của bạn hoàn toàn chính xác! Việc kết hợp cả dòng $D_2$ (dòng triệt tiêu / Anti-Record) và Thuật toán SQL 2 chiều (Two-Dimensional Ordering) chính là "Tiêu chuẩn vàng" (Gold Standard) trong thiết kế CSDL cho các hệ thống Core Tài chính - Bảo hiểm Xã hội khắt khe nhất.Mô hình này giúp CSDL của bạn đạt được 3 tiêu chuẩn tối thượng:Bảo mật Audit 100%: Dữ liệu đã đóng sổ ($D_1$) vĩnh viễn không bị sửa (UPDATE).Nghiệp vụ Bảo hiểm chuẩn xác: Báo cáo Biến động luôn đủ cặp Tăng/Giảm ($D_2, D_3$).Mọi kịch bản báo cáo không bị lỗi: Xử lý triệt để từ nhập đè, nhập sửa đến nhập hồi tố (Backdated adjustments).Tổng hợp Bộ SQL Chuẩn cho Hệ thống của bạnDưới đây là bộ câu lệnh SQL đã tích hợp hoàn chỉnh cả 2 cơ chế để bạn sẵn sàng đưa vào Production:1. SQL Báo cáo Biến động (Thống kê Tăng/Giảm phát sinh trong kỳ 202604)Dùng để xuất Mẫu D02-LT gửi cơ quan quản lý BHXH:
SELECT 
    doi_tuong_id,
    pa_tang,
    pa_giam,
    luong,
    tu_thang,
    den_thang
FROM hs.dieu_chinh_bhxh
WHERE ma_don_vi = '10.01.103.01' 
  AND thang_phat_sinh = 202604; -- Lọc đúng giao dịch thực hiện trong kỳ

  Dòng $D_2$ (pa_giam = 'DC'): Tự động đưa vào cột Giảm điều chỉnh (mức 10M cũ).Dòng $D_3$ (pa_tang = 'DC'): Tự động đưa vào cột Tăng điều chỉnh (mức 12M mới).2. SQL Báo cáo Chi trả / Thu nộp (Xuất danh sách chốt lương Tháng 202604)Áp dụng Thuật toán SQL 2 chiều kết hợp lọc dòng Tăng ($D_3$):

  WITH ValidRecordsAtReportingTime AS (
    SELECT 
        doi_tuong_id,
        luong,
        tu_thang,
        den_thang,
        pa_tang,
        pa_giam,
        thang_phat_sinh,
        id,
        -- Trục 1 (System Time): Với cùng 1 tu_thang, chọn bản ghi ghi nhận MUỘN NHẤT
        ROW_NUMBER() OVER (
            PARTITION BY doi_tuong_id, tu_thang 
            ORDER BY thang_phat_sinh DESC, id DESC
        ) AS rn_version
    FROM hs.dieu_chinh_bhxh
    WHERE ma_don_vi = '10.01.103.01'
      AND thang_phat_sinh <= 202604 -- Chỉ xét các dữ liệu đã chốt tính đến T4
),
LatestEffectiveState AS (
    SELECT 
        doi_tuong_id,
        luong,
        tu_thang,
        den_thang,
        pa_tang,
        -- Trục 2 (Effective Time): Chọn mốc thời gian hiệu lực MỚI NHẤT
        ROW_NUMBER() OVER (
            PARTITION BY doi_tuong_id
            ORDER BY tu_thang DESC, CASE WHEN pa_tang IS NOT NULL THEN 1 ELSE 2 END, id DESC
        ) AS rn_effective
    FROM ValidRecordsAtReportingTime
    WHERE rn_version = 1
      AND tu_thang <= 202604 
      AND (den_thang IS NULL OR den_thang >= 202604)
)
SELECT doi_tuong_id, luong, tu_thang, pa_tang
FROM LatestEffectiveState 
WHERE rn_effective = 1;

👉 Kết quả: Lấy duy nhất dòng $D_3$ (Mức lương 12.000.000 VNĐ) cho Tháng 4.3. SQL In lại Báo cáo Quá khứ (Ví dụ: In lại Báo cáo Tháng 202603)Chỉ cần đổi tham số thời điểm báo cáo về 202603:Đoạn SQL trên với thang_phat_sinh <= 202603 sẽ tự động loại bỏ cả $D_2$ và $D_3$ (do $D_2, D_3$ sinh ở T4).Hệ thống quét trúng dòng $D_1$ (Mức lương 10.000.000 VNĐ).👉 Kết quả: Con số báo cáo Tháng 3 ra chính xác tuyệt đối so với thời điểm đã duyệt trong quá khứ.

CÓ, BẮT BUỘC PHẢI SINH RA 2 DÒNG ĐIỀU CHỈNH (CẶP ANTI-RECORD ĐẶC BIỆT) khi có nghiệp vụ chuyển đơn vị!Trong nghiệp vụ BHXH, việc chuyển đơn vị không chỉ là thay đổi thuộc tính ID đơn vị, mà bản chất là: Cơ quan cũ chốt giảm số đóng BHXH của nhân sự đó, và cơ quan mới báo tăng số đóng BHXH của nhân sự đó.Nếu bạn chỉ UPDATE trường don_vi_id trên dòng cũ, hoặc chỉ sinh 1 dòng mới, bạn sẽ làm sai lệch hoàn toàn Báo cáo Biến động (D02-LT) và Số liệu Thu nộp/Chi trả của cả 2 đơn vị.1. Kịch bản Nghiệp vụ Chuyển Đơn vị (Ví dụ cụ thể)Hoàn cảnh: Tháng 04/2026, Quân nhân X chuyển từ Đơn vị A (don_vi_id = 101) sang Đơn vị B (don_vi_id = 102). Mức lương đóng BHXH giữ nguyên là 12.000.000 VNĐ.Thời điểm Tháng 1 đến Tháng 3: Quân nhân X thuộc Đơn vị A (đã chốt báo cáo, dòng $D_1$ đã bất biến).Để xử lý chuẩn nghiệp vụ và đúng thuật toán Append-Only, hệ thống sẽ sinh ra Cặp 2 dòng giao dịch mới ($D_2$ và $D_3$) tại kỳ thang_phat_sinh = 202604:Dòng $D_2$: Báo GIẢM HẲN tại Đơn vị A (Đơn vị cũ)don_vi_id: 101 (Đơn vị A)don_vi_chuyen_id: 102 (Đơn vị B - Lưu vết chuyển tới đâu)tu_thang: 202604, den_thang: 202604thang_phat_sinh: 202604pa_giam: 'GH' (Giảm hẳn / Chuyển đi) — hoặc mã phương án giảm chuyển đơn vị theo quy định.luong: 12,000,000Dòng $D_3$: Báo TĂNG MỚI tại Đơn vị B (Đơn vị mới)don_vi_id: 102 (Đơn vị B)don_vi_chuyen_id: 101 (Đơn vị A - Lưu vết chuyển từ đâu đến)tu_thang: 202604, den_thang: NULLthang_phat_sinh: 202604pa_tang: 'TM' (Tăng mới / Chuyển đến) — hoặc mã phương án tăng chuyển đơn vị.luong: 12,000,0002. Tác dụng khi xuất Báo cáo ở cả 2 Đơn vịA. Báo cáo BIẾN ĐỘNG Tháng 4/2026 (thang_phat_sinh = 202604):Tại Đơn vị A (WHERE ma_don_vi = '101'):Quét thấy dòng $D_2$ (pa_giam = 'GH').👉 Đưa quân nhân X vào danh sách GIẢM TRONG THÁNG 4 của Đơn vị A (Lý do: Chuyển sang Đơn vị B).Tại Đơn vị B (WHERE ma_don_vi = '102'):Quét thấy dòng $D_3$ (pa_tang = 'TM').👉 Đưa quân nhân X vào danh sách TĂNG TRONG THÁNG 4 của Đơn vị B (Lý do: Nhận từ Đơn vị A sang).B. Báo cáo THỰC CHI / DANH SÁCH CHI TRẢ Tháng 4/2026 (thang_phat_sinh <= 202604):Tại Đơn vị A:Dòng $D_1$ (Tăng 12M từ T1-T4) + Dòng $D_2$ (Giảm 12M từ T4).Phép tính triệt tiêu: $12M - 12M = \mathbf{0 \text{ VNĐ}}$.👉 Đơn vị A không phải trả lương/đóng BHXH cho quân nhân X từ Tháng 4 trở đi.Tại Đơn vị B:Quét thấy duy nhất dòng $D_3$ (tu_thang = 202604, luong = 12M).👉 Đơn vị B bắt đầu chi trả/đóng BHXH 12M cho quân nhân X từ Tháng 4.C. Khi In lại Báo cáo Quá khứ (Ví dụ: Tháng 3/2026 tại Đơn vị A):SQL chạy với điều kiện thang_phat_sinh <= 202603.Cả $D_2$ và $D_3$ đều bị gạt ra ngoài (do sinh ở T4).Đơn vị A quét thấy dòng $D_1$ (don_vi_id = 101, luong = 12M).👉 Kết quả Tháng 3 của Đơn vị A vẫn có mặt quân nhân X với mức lương 12M $\rightarrow$ Khớp 100% với lịch sử kiểm toán đã ký chốt.3. Cấu trúc trường khuyến nghị cho Bảng hs.dieu_chinh_bhxhĐể hỗ trợ nghiệp vụ chuyển đơn vị hoàn hảo, bạn nên thiết kế 2 trường đúng như bạn dự tính

Tóm lại: Sinh 2 dòng điều chỉnh khi chuyển đơn vị là điều kiện bắt buộc để giữ vững nguyên tắc bất biến (Immutable) và đảm bảo báo cáo biến động tăng/giảm ở cả 2 đơn vị cũ - mới đều chính xác.

*/
