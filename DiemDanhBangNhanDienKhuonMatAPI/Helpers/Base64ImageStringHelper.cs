using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DiemDanhBangNhanDienKhuonMatAPI.Helpers
{
    public class Base64ImageStringHelper
    {
        public string base64ImageString { set; get; }

        public Base64ImageStringHelper(string base64ImageString)
        {
            this.base64ImageString = base64ImageString;
        }
    }
}
