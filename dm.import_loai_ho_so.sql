-- 1. Tạo Schema dm (Danh mục) nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dm')
BEGIN
    EXEC('CREATE SCHEMA dm');
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dm].[import_loai_ho_so]') AND type in (N'U'))
BEGIN
   CREATE TABLE dm.import_loai_ho_so (
            [id]                    INT IDENTITY(1,1) PRIMARY KEY,
            [ma]         VARCHAR(50) NOT NULL UNIQUE,     -- VD: 'TNLD_BNN','TNLD_BNN_CD', 'HOSO', 'QUATRINH'
            [ten]        NVARCHAR(150) NOT NULL,          -- VD: 'Hồ sơ đề nghị trợ cấp TNLĐ', 'Hồ sơ điều chỉnh lương'    
            [file_mau_url] VARCHAR(250) NULL,               -- Đường dẫn tải file Excel mẫu chuẩn    
            [cau_hinh_cot_json]     NVARCHAR(MAX) NULL, -- Lưu cấu trúc định nghĩa cột và cột trộn (Merger) của file mẫu dưới dạng JSON, cụ thể xem bên dưới
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
--SET IDENTITY_INSERT dm.import_loai_ho_so ON;
-- Mẫu cột: [cau_hinh_cot_json] Cột trộn (Group/Merged Columns) như nhóm "Nơi cư trú" gồm 3 cột con (Xã, Huyện, Tỉnh), thì lưu như sau:
/*
{
  "sheet_name": "Sheet1",
  "header_row_index": 3,
  "data_start_row": 4,
  "columns": [
    {
      "field": "stt",
      "col_index": 1,
      "excel_header_name": "STT",
      "data_type": "number",
      "required": false
    },
    {
      "field": "ho_ten",
      "col_index": 2,
      "excel_header_name": "Họ và tên",
      "data_type": "string",
      "required": true
    },
    {
      "group_name": "Nơi cư trú",
      "is_merged": true,
      "sub_columns": [
        {
          "field": "xa",
          "col_index": 3,
          "excel_header_name": "Xã / Phường",
          "data_type": "string"
        },
        {
          "field": "huyen",
          "col_index": 4,
          "excel_header_name": "Quận / Huyện",
          "data_type": "string"
        },
        {
          "field": "tinh",
          "col_index": 5,
          "excel_header_name": "Tỉnh / TP",
          "data_type": "string"
        }
      ]
    },
    {
      "field": "so_cccd",
      "col_index": 6,
      "excel_header_name": "Số CCCD",
      "data_type": "string",
      "regex_pattern": "^[0-9]{12}$"
    }
  ]
}
*/

--SET IDENTITY_INSERT dm.import_loai_ho_so OFF;
GO

