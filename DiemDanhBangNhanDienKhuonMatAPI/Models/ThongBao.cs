using System;
using System.Collections.Generic;

namespace DiemDanhBangNhanDienKhuonMatAPI.Models
{
    public partial class ThongBao
    {
        public int Id { get; set; }
        public int IdlopHoc { get; set; }
        public DateTime NgayTao { get; set; }
        public string TieuDe { get; set; }
        public string NoiDung { get; set; }

        public virtual LopHoc IdlopHocNavigation { get; set; }
    }
}
