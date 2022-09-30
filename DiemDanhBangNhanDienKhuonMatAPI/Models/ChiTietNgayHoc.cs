using System;
using System.Collections.Generic;

namespace DiemDanhBangNhanDienKhuonMatAPI.Models
{
    public partial class ChiTietNgayHoc
    {
        public ChiTietNgayHoc()
        {
            ChiTietDiemDanh = new HashSet<ChiTietDiemDanh>();
        }

        public int Id { get; set; }
        public int? IdlopHoc { get; set; }
        public DateTime ThoiGianBatDauBuoiHoc { get; set; }
        public string PhongHoc { get; set; }

        public virtual LopHoc IdlopHocNavigation { get; set; }
        public virtual ICollection<ChiTietDiemDanh> ChiTietDiemDanh { get; set; }
    }
}
