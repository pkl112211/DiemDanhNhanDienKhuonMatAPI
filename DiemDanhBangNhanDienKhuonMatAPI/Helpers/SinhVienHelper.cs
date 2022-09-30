using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DiemDanhBangNhanDienKhuonMatAPI.Models.Helpers
{
    public class SinhVienHelper
    {
        public string MSSV { set; get; }
        public bool isDiemDanh { set; get; }
        public string[] base64ImagesStrings { set; get; }

        public string matKhauCu { set; get; }
        public string matKhauMoi { set; get; }

        public SinhVienHelper(string mSSV, string[] base64ImagesStrings)
        {
            MSSV = mSSV;
            this.base64ImagesStrings = base64ImagesStrings;
        }


    }




}
