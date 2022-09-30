using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DiemDanhBangNhanDienKhuonMatAPI.Helpers;
using DiemDanhBangNhanDienKhuonMatAPI.Models;
using DiemDanhBangNhanDienKhuonMatAPI.Models.Helpers;
using DiemDanhBangNhanDienKhuonMatAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;

namespace DiemDanhBangNhanDienKhuonMatAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KhuonMatsController : ControllerBase
    {
        private readonly DB_DIEMDANHContext _context;

        public KhuonMatsController(DB_DIEMDANHContext context)
        {
            _context = context;
            MSCognitionService.CreateClient();
        }
        [HttpPost]
        
        public async Task<IActionResult> dangKiKhuonMatAsync(SinhVienHelper sv)
        {

            SinhVien sinhVien = await _context.SinhVien.FirstOrDefaultAsync((s) => s.Mssv.Equals(sv.MSSV));
            if (sinhVien != null)
            {
                if (sinhVien.HasRegisteredFace == false || sinhVien.HasRegisteredFace == null)
                {
                    if (await MSCognitionService.AddNewPersonFromStream(sv.MSSV, sv.base64ImagesStrings))
                    {
                        sinhVien.HasRegisteredFace = true;
                        _context.SinhVien.Update(sinhVien);
                        await _context.SaveChangesAsync();
                    }
                    else
                    {
                        sinhVien.HasRegisteredFace = false;
                        _context.SinhVien.Update(sinhVien);
                        await _context.SaveChangesAsync();
                        return BadRequest();
                    }
                }
                else
                {
                    if (!await MSCognitionService.UpdatePersonFaceFromStream(sv.MSSV, sv.base64ImagesStrings))
                    {

                        sinhVien.HasRegisteredFace = false;
                        _context.SinhVien.Update(sinhVien);
                        await _context.SaveChangesAsync();
                        return BadRequest();
                    }

                }

                return Ok(JsonConvert.SerializeObject(sinhVien));
            }
            return NotFound("Not found!");


        }

        [HttpPost("nhandien")]
       
        public async Task<ActionResult<IEnumerable<MSCognitionService.DetectedPerson>>> nhanDienKhuonMat(Base64ImageStringHelper base64ImageString)
        {

            var rs = await MSCognitionService.IdentityAFaceAsyncFromStream(base64ImageString.base64ImageString);
            if (rs.Count == 0)
            {
                return NoContent();
            }
            return rs;



        }

    }
}