using System;
using System.Collections.Generic;

namespace DiemDanhBangNhanDienKhuonMatAPI.Models
{
    public partial class LopHoc
    {
        public LopHoc()
        {
            ChiTietNgayHoc = new HashSet<ChiTietNgayHoc>();
            SinhVienTrongLopHoc = new HashSet<SinhVienTrongLopHoc>();
            ThongBao = new HashSet<ThongBao>();
        }

        public int Id { get; set; }
        public int? IdmonHoc { get; set; }
        public int? IdgiangVien { get; set; }

        public virtual GiangVien IdgiangVienNavigation { get; set; }
        public virtual MonHoc IdmonHocNavigation { get; set; }
        public virtual ICollection<ChiTietNgayHoc> ChiTietNgayHoc { get; set; }
        public virtual ICollection<SinhVienTrongLopHoc> SinhVienTrongLopHoc { get; set; }
        public virtual ICollection<ThongBao> ThongBao { get; set; }
    }
}
