-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[nganh]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.nganh (        
        id SMALLINT IDENTITY(1,1) PRIMARY KEY,
        ma char(3),
        ten nvarchar(150),
        tu_thang_tham_nien int,
        [trang_thai]    TINYINT NOT NULL DEFAULT 1,         -- 1: Hoạt động, 0: Khóa      
        -- Quản lý dữ liệu hệ thống (Audit Fields)
        [created_at]                DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
        [created_by]                int NULL,                              -- ID người tạo
        [updated_at]                DATETIMEOFFSET NULL,                      -- Thời điểm sửa
        [updated_by]                int NULL,                              -- ID người sửa
        [deleted_at]                DATETIMEOFFSET NULL,                      -- Thời điểm xóa mềm
        [deleted_by]                int NULL,                              -- ID người xóa mềm
        [is_deleted]                BIT NOT NULL DEFAULT 0                   -- 0: Dùng, 1: Xóa mềm                
    );
END
GO
SET IDENTITY_INSERT dm.nganh ON;

INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (1, N'001', N'Công an nhân dân', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (2, N'002', N'Phòng không - Tên lửa - Tác chiến điện tử', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (3, N'003', N'Không quân', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (4, N'004', N'Hoá học quân sự', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (5, N'005', N'Vũ khí đạn dược', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (6, N'006', N'Biên phòng', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (7, N'007', N'Bảo vệ lăng chủ tịch Hồ Chí Minh', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (8, N'008', N'Bản đồ quân sự', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (9, N'009', N'Bảo đảm quân sự (Hậu cần)', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (10, N'010', N'Công binh và xây dựng công trình quân sự', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (11, N'011', N'Hải quân', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (12, N'012', N'Pháo binh', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (13, N'013', N'Tăng - Thiết giáp', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (14, N'014', N'Đặc công', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (15, N'015', N'Tình báo', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (16, N'016', N'Bưu chính - Viễn thông', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (17, N'017', N'Chăn nuôi-Chế biến gia súc, gia cầm', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (18, N'018', N'Cơ khí', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (19, N'019', N'Cơ khí-Luyện kim', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (20, N'020', N'Cơ yếu', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (21, N'021', N'Da giầy, dệt', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (22, N'022', N'Dược', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (23, N'023', N'Dệt may', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (24, N'024', N'Dự trữ quốc gia', 201311);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (25, N'025', N'Giao thông vận tải', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (26, N'026', N'Hoá chất', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (27, N'027', N'Hàng không', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (28, N'028', N'Khai khoáng', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (29, N'029', N'Khai thác mỏ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (30, N'030', N'Khoa học - Công nghệ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (31, N'031', N'Khí tượng thuỷ văn', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (32, N'032', N'Luyện kim', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (33, N'033', N'Lâm nghiệp', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (34, N'034', N'Ngân hàng', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (35, N'035', N'Nông nghiệp', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (36, N'036', N'Nông nghiệp - Lâm nghiệp', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (37, N'037', N'Phát thanh - Truyền hình', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (38, N'038', N'Sành sứ, thuỷ tinh, nhựa tạp phẩm, giấy gỗ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (39, N'039', N'Sản xuất bánh kẹo', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (40, N'040', N'Sản xuất giấy', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (41, N'041', N'Sản xuất gạch, gốm, sứ, đá,cát, sỏi, kính xây dựng', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (42, N'042', N'Sản xuất thuốc lá', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (43, N'043', N'Sản xuất xi măng', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (44, N'044', N'Sản xuất, chế biến muối ăn', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (45, N'045', N'Thuỷ lợi', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (46, N'046', N'Thuỷ sản', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (47, N'047', N'Thông tin', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (48, N'048', N'Thông tin liên lạc', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (49, N'049', N'Thương mại', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (50, N'050', N'Trồng trọt, khai thác, chế biến nông, lâm sản', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (51, N'051', N'Văn hoá-Thông tin', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (52, N'052', N'Vận tải', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (53, N'053', N'Vệ sinh môi trường đô thị', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (54, N'054', N'Xây dựng (Xây lắp)', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (55, N'055', N'Xây dựng giao thông và kho tàng bến bãi', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (56, N'057', N'Y tế', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (57, N'058', N'Điện, Điện Tử', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (58, N'059', N'Địa chất.  trắc địa', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (59, N'060', N'Địa chính', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (60, N'061', N'Nghệ thuật, vui chơi giải trí', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (61, N'064', N'Hải quan', 200212);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (62, N'065', N'Tòa án', 200901);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (63, N'066', N'Kiểm sát', 200901);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (64, N'067', N'Kiểm toán', 200901);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (65, N'068', N'Thanh tra', 200901);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (66, N'069', N'Thi hành án dân sự', 200901);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (67, N'070', N'Kiểm lâm', 200901);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (68, N'071', N'Kiểm tra Đảng', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (69, N'072', N'Khoa học giáo dục và đào tạo giáo viên', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (70, N'073', N'Nghệ thuật', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (71, N'074', N'Nhân văn', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (72, N'075', N'Khoa học xã hội và hành vi', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (73, N'076', N'Báo chí và thông tin', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (74, N'077', N'Kinh doanh và quản lý', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (75, N'078', N'Luật', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (76, N'079', N'Khoa học sự sống', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (77, N'080', N'Khoa học tự nhiên', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (78, N'081', N'Toán và thống kê', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (79, N'082', N'Ngành Công nghệ thông tin', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (80, N'083', N'Công nghệ kỹ thuật', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (81, N'084', N'Kỹ thuật', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (82, N'085', N'Sản xuất và chế biến', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (83, N'086', N'Kiến trúc và xây dựng', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (84, N'087', N'Nông, lâm nghiệp và thuỷ sản', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (85, N'088', N'Thú y', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (86, N'089', N'Sức khoẻ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (87, N'090', N'Dịch vụ xã hội', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (88, N'091', N'Khách sạn, du lịch, thể thao và dịch vụ cá nhân', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (89, N'092', N'Dịch vụ vận tải', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (90, N'093', N'Môi trường và bảo vệ môi trường', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (91, N'094', N'An ninh, Quốc phòng', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (92, N'158', N'Công nghiệp chế biến, chế tạo', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (93, N'159', N'SẢN XUẤT VÀ PHÂN PHỐI ĐIỆN, KHÍ ĐỐT, NƯỚC NÓNG, HƠ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (94, N'160', N'CUNG CẤP NƯỚC; HOẠT ĐỘNG QUẢN LÝ VÀ XỬ LÝ RÁC THẢI', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (95, N'161', N'BÁN BUÔN VÀ BÁN LẺ; SỬA CHỮA Ô TÔ, MÔ TÔ, XE MÁY V', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (96, N'162', N'VẬN TẢI KHO BÃI', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (97, N'163', N'DỊCH VỤ LƯU TRÚ VÀ ĂN UỐNG', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (98, N'164', N'THÔNG TIN VÀ TRUYỀN THÔNG', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (99, N'165', N'HOẠT ĐỘNG TÀI CHÍNH, NGÂN HÀNG VÀ BẢO HIỂM', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (100, N'166', N'HOẠT ĐỘNG KINH DOANH BẤT ĐỘNG SẢN', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (101, N'167', N'HOẠT ĐỘNG CHUYÊN MÔN, KHOA HỌC VÀ CÔNG NGHỆ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (102, N'168', N'HOẠT ĐỘNG HÀNH CHÍNH VÀ DỊCH VỤ HỖ TRỢ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (103, N'169', N'HOẠT ĐỘNG CỦA ĐẢNG CỘNG SẢN, TỔ CHỨC CHÍNH TRỊ – X', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (104, N'170', N'GIÁO DỤC VÀ ĐÀO TẠO', 201105);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (105, N'171', N'Y TẾ VÀ HOẠT ĐỘNG TRỢ GIÚP XÃ HỘI', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (106, N'172', N'NGHỆ THUẬT, VUI CHƠI VÀ GIẢI TRÍ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (107, N'173', N'HOẠT ĐỘNG DỊCH VỤ KHÁC', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (108, N'174', N'HOẠT ĐỘNG LÀM THUÊ CÁC CÔNG VIỆC TRONG CÁC HỘ GIA ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (109, N'175', N'HOẠT ĐỘNG CỦA CÁC TỔ CHỨC VÀ CƠ QUAN QUỐC TẾ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (110, N'176', N'Tòa án (không tính TN)  ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (111, N'177', N'Kiểm sát (Không tính thâm niên)  ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (112, N'178', N'Kiểm toán (Không tính thâm niên)  ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (113, N'179', N'Thanh tra (Không tính thâm niên)    ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (114, N'180', N'Thi hành án dân sự (Không tính thâm niên)  ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (115, N'181', N'Kiểm lâm (Không tính thâm niên)  ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (116, N'182', N'Kinh Tế', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (117, N'183', N'Ngoại Ngữ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (118, N'184', N'KỸ THUẬT XÂY DỰNG, KIẾN TRÚC, THỦY LỢI  ', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (119, N'185', N'Dự trữ quốc gia (không tính thâm niên)', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (120, N'186', N'Cao su', NULL);
INSERT INTO dm.nganh (id,ma, ten,tu_thang_tham_nien) VALUES (121, N'999', N'Ngành khác', NULL);

SET IDENTITY_INSERT dm.nganh OFF;
GO

