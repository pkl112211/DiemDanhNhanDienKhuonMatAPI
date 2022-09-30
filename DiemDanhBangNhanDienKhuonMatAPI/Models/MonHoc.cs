using System;
using System.Collections.Generic;

namespace DiemDanhBangNhanDienKhuonMatAPI.Models
{
    public partial class MonHoc
    {
        public MonHoc()
        {
            LopHoc = new HashSet<LopHoc>();
        }

        public int Id { get; set; }
        public string TenMonHoc { get; set; }

        public virtual ICollection<LopHoc> LopHoc { get; set; }
    }
}
