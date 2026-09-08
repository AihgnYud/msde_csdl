-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[luong_co_so]') AND type in (N'U'))
BEGIN
    CREATE TABLE dm.luong_co_so (        
        id SMALLINT IDENTITY(1,1) PRIMARY KEY,
        ma char(2),--THANG
        ten nvarchar(50),--NGHỊ ĐỊNH
        luong int,
        he_so_dc decimal (6,4),
        tu_thang int,
        den_thang int,
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
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (199304, N'Nghị định số 27/CP', 120000, 0.0000, 199304, 199612);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (199701, N'Nghị định số 06/CP', 144000, 1.2000, 199701, 199912);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (200001, N'Nghị định số 175/CP', 180000, 1.2500, 200001, 200012);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (200101, N'Nghị định số 77/CP', 210000, 1.1670, 200101, 200212);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (200301, N'Nghị định số 03/CP', 290000, 1.3810, 200301, 200509);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (200510, N'Nghị định số 118/CP', 350000, 1.2070, 200510, 200609);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (200610, N'Nghị định số 94/CP', 450000, 1.2860, 200610, 200712);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (200801, N'NĐ 166, NĐ 184/CP', 540000, 1.2000, 200801, 200904);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (200905, N'NĐ 33, NĐ 34/CP', 650000, 1.2037, 200905, 201004);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (201005, N'NĐ 28, NĐ 29/CP', 730000, 1.1230, 201005, 201104);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (201105, N'NĐ 22, NĐ 23/CP', 830000, 1.1370, 201105, 201204);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (201205, N'NĐ 31, NĐ 35/CP', 1050000, 1.2650, 201205, 201306);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (201307, N'NĐ 66, NĐ 73/CP', 1150000, 1.0952, 201307, 201604);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (201605, N'NĐ 47/2016/NĐ-CP', 1210000, 1.0522, 201605, 201706);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (201707, N'NĐ 76/2017/NĐ-CP', 1300000, 1.0744, 201707, 201806);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (201807, N'NĐ 72, NĐ 88/2018/NĐ-CP', 1390000, 1.0692, 201807, 201906);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (201907, N'NĐ 44/2019/NĐ-CP', 1490000, 1.0719, 201907, 202306);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (202307, N'NĐ 42/2023/NĐ-CP', 1800000, 1.2080, 202307, 202406);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (202407, N'NĐ 75/2024/NĐ-CP', 2340000, 1.1500, 202407, 202606);
INSERT INTO dm.luong_co_so (ma, ten,luong,he_so_dc,tu_thang,den_thang) VALUES (202607, N'NĐ 162/2026/NĐ-CP', 2530000, 1.0800, 202607, 999912);

