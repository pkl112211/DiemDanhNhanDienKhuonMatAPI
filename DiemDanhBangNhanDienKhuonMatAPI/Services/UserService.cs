using DiemDanhBangNhanDienKhuonMatAPI.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace DiemDanhBangNhanDienKhuonMatAPI.Services
{


    public interface IUserService
    {
        public UserEntities AuthUser(string username, string password);
        public IEnumerable<UserEntities> getAll();
        public UserEntities getUser(string username);
    }

    public class UserEntities
    {
        public string Username { set; get; }
        public string Password { set; get; }
        public string Role { set; get; }
        public string Token { set; get; }

        public UserEntities(string username, string password)
        {
            this.Username = username;
            this.Password = password;
        }

        public UserEntities withOutPassword()
        {
            UserEntities temp = this;
            temp.Password = null;
            return temp;
        }
    }

    public class UserService : IUserService
    {
        public static string KEY = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("SecurityKey")["SymmetricSecurityKey"];
        static DB_DIEMDANHContext context = new DB_DIEMDANHContext();
        List<UserEntities> LIST_SV = context.SinhVien.Select(sv => new UserEntities(sv.Mssv, sv.MatKhau)).ToList();
        List<UserEntities> LIST_GV = context.GiangVien.Select(gv => new UserEntities(gv.Msgv, gv.MatKhau)).ToList();

        public UserEntities AuthUser(string username, string password)
        {
             LIST_SV = (from sinhVien in context.SinhVien select sinhVien).Select(sv => new UserEntities(sv.Mssv, sv.MatKhau)).ToList();
             LIST_GV = (from giangVien in context.GiangVien select giangVien).Select(gv => new UserEntities(gv.Msgv, gv.MatKhau)).ToList();
            var svTemp = LIST_SV.FirstOrDefault(user => user.Username.Equals(username) && user.Password.Equals(password)); //FIND USER IN LIST USER
            var gvTemp = LIST_GV.FirstOrDefault(user => user.Username.Equals(username) && user.Password.Equals(password));
            UserEntities user = null;
            if (svTemp == null && gvTemp == null) //IF NOT FOUND RETURN NULL
            {
                return null;
            }
            else if (svTemp != null && gvTemp == null)
            {
                user = svTemp;
                user.Role = "sv";
            }
            else
            {
                user = gvTemp;
                user.Role = "gv";
            }

            List<Claim> lstClaim = new List<Claim>(); //CLAIM USER INFO
            lstClaim.Add(new Claim(ClaimTypes.Name, user.Username));
            lstClaim.Add(new Claim(ClaimTypes.Role, user.Role));


            //CREATE JWT TOKEN
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(KEY);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(lstClaim.ToArray()),
                Expires = DateTime.UtcNow.AddHours(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)

            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            user.Token = tokenHandler.WriteToken(token);

            return user.withOutPassword();


        }

        public IEnumerable<UserEntities> getAll()
        {
            return LIST_SV;
        }
        public UserEntities getUser(string username)
        {
            return LIST_SV.SingleOrDefault(user => user.Username == username).withOutPassword();
        }
    }
}
