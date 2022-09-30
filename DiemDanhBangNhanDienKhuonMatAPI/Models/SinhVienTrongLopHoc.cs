using System;
using System.Collections.Generic;

namespace DiemDanhBangNhanDienKhuonMatAPI.Models
{
    public partial class SinhVienTrongLopHoc
    {
        public SinhVienTrongLopHoc()
        {
            ChiTietDiemDanh = new HashSet<ChiTietDiemDanh>();
        }

        public int Id { get; set; }
        public int? IdlopHoc { get; set; }
        public int? IdsinhVien { get; set; }

        public virtual LopHoc IdlopHocNavigation { get; set; }
        public virtual SinhVien IdsinhVienNavigation { get; set; }
        public virtual ICollection<ChiTietDiemDanh> ChiTietDiemDanh { get; set; }
    }
}
