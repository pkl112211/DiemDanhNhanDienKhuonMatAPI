using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DiemDanhBangNhanDienKhuonMatAPI.Helpers
{
    public class ThongBaoHelper
    {
        public int IdlopHoc { get; set; }
        public DateTime NgayTao { get; set; }
        public string TieuDe { get; set; }
        public string NoiDung { get; set; }
        
        public ThongBaoHelper()
        {
            //this.IdlopHoc = idLopHoc;
            //this.TieuDe = tieuDe;
            //this.NoiDung = noiDung;
            this.NgayTao = DateTime.Now;
        }
    }
}
