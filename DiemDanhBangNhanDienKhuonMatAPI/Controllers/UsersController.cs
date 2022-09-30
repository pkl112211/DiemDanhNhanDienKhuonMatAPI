using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DiemDanhBangNhanDienKhuonMatAPI.Models;
using DiemDanhBangNhanDienKhuonMatAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace DiemDanhBangNhanDienKhuonMatAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private IUserService userService;
        private static DB_DIEMDANHContext context = new DB_DIEMDANHContext();

        public UsersController(IUserService userService)
        {
            this.userService = userService;
        }

        [Authorize]
        public IActionResult getAll()
        {
            return Ok(userService.getAll());
        }


        [AllowAnonymous]
        [HttpPost("login")]
        public IActionResult login([FromForm] string username, [FromForm]string password)
        {

            var userTemp = userService.AuthUser(username, password);

            if (userTemp == null)
                return BadRequest(new { message = "Username password fail" });
            return Ok(userTemp);

        }
        
    }
}