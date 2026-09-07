-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[dan_toc]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.dan_toc (
        -- Khóa chính Tự tăng (BigInt)
        id SMALLINT IDENTITY(1,1) PRIMARY KEY,
        ma char(2),
        ten nvarchar(50),
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
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'01', N'Kinh');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'02', N'Tày');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'03', N'Thái');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'04', N'Hoa');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'05', N'Khơ-me');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'06', N'Mường');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'07', N'Nùng');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'08', N'Hmông');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'09', N'Dao');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'10', N'Ja-rai');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'11', N'Ngái');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'12', N'Ê-đê');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'13', N'Ba-na');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'14', N'Xơ-đăng');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'15', N'Sán Chay');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'16', N'Cơ-ho');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'17', N'Chăm');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'18', N'Sán Dìu');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'19', N'Hrê');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'20', N'Mnông');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'21', N'Ra-glai');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'22', N'Xtiêng');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'23', N'Bru-Vân Kiều');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'24', N'Thổ');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'25', N'Giáy');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'26', N'Cơ-tu');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'27', N'Gié-Triêng');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'28', N'Mạ');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'29', N'Khơ-mú');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'30', N'Co');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'31', N'Ta-ôi');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'32', N'Chơ-ro');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'33', N'Kháng');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'34', N'Xinh-mun');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'35', N'Hà Nhì');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'36', N'Chu-ru');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'37', N'Lào');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'38', N'La Chi');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'39', N'La Ha');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'40', N'Phù Lá');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'41', N'La Hủ');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'42', N'Lự');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'43', N'Lô Lô');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'44', N'Chứt');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'45', N'Mảng');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'46', N'Pà Thẻn');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'47', N'Cơ Lao');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'48', N'Cống');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'49', N'Bố Y');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'50', N'Si La');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'51', N'Pu Péo');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'52', N'Brâu');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'53', N'Ơ Đu');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'54', N'Rơ-măm');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'58', N'Cao Lan');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'59', N'Thanh');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'60', N'Pa Cô');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'61', N'Pa Hy');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'62', N'Vân Kiều');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'63', N'Ve và Tà Riềng');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'64', N'Ngạn');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'65', N'Sách');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'66', N'Ka dong');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'67', N'Ca dong');
INSERT INTO dm.dan_toc (ma, ten) VALUES (N'68', N'H'' roi');

