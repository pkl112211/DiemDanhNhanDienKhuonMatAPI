using System;
using System.Collections.Generic;

namespace DiemDanhBangNhanDienKhuonMatAPI.Models
{
    public partial class ChiTietDiemDanh
    {
        public int Id { get; set; }
        public int? IdchiTietNgayHoc { get; set; }
        public int? IdsinhVienTrongLopHoc { get; set; }
        public bool IsDiemDanh { get; set; }

        public virtual ChiTietNgayHoc IdchiTietNgayHocNavigation { get; set; }
        public virtual SinhVienTrongLopHoc IdsinhVienTrongLopHocNavigation { get; set; }
    }
}
