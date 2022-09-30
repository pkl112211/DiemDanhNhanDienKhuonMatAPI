using System;
using System.Collections.Generic;

namespace DiemDanhBangNhanDienKhuonMatAPI.Models
{
    public partial class SinhVien
    {
        public SinhVien()
        {
            SinhVienTrongLopHoc = new HashSet<SinhVienTrongLopHoc>();
        }

        public int Id { get; set; }
        public string Mssv { get; set; }
        public string MatKhau { get; set; }
        public string HoTen { get; set; }
        public DateTime NgaySinh { get; set; }
        public bool? GioiTinh { get; set; }
        public string DiaChi { get; set; }
        public string SoDienThoai { get; set; }
        public string Email { get; set; }
        public string GhiChu { get; set; }
        public bool? HasRegisteredFace { get; set; }

        public virtual ICollection<SinhVienTrongLopHoc> SinhVienTrongLopHoc { get; set; }
    }
}
