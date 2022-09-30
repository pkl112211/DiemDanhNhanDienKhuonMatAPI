using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DiemDanhBangNhanDienKhuonMatAPI.Models;
using Microsoft.AspNetCore.Authorization;
using DiemDanhBangNhanDienKhuonMatAPI.Models.Helpers;
using DiemDanhBangNhanDienKhuonMatAPI.Services;
using DiemDanhBangNhanDienKhuonMatAPI.Helpers;

namespace DiemDanhBangNhanDienKhuonMatAPI.Controllers
{

    [Route("api/giangvien")]
    [ApiController]
    [Authorize(Roles = "gv")]
    public class GiangViensController : ControllerBase
    {
        private readonly DB_DIEMDANHContext _context;

        public GiangViensController(DB_DIEMDANHContext context)
        {
            _context = context;

        }

        // GET: api/GiangViens
        [HttpGet]
        public async Task<ActionResult<IEnumerable<GiangVien>>> GetGiangVien()
        {
            return await _context.GiangVien.ToListAsync();
        }

        // GET: api/GiangViens/5
        [HttpGet("{id}")]
        public async Task<ActionResult<GiangVien>> GetGiangVien(int id)
        {
            var giangVien = await _context.GiangVien.FindAsync(id);

            if (giangVien == null)
            {
                return NotFound();
            }

            return giangVien;
        }


        [HttpGet("current")]

        public async Task<ActionResult<GiangVien>> GetCurrent()
        {
            var giangVien = await _context.GiangVien.FirstOrDefaultAsync(gv => gv.Msgv.Equals(User.Identity.Name));

            if (giangVien == null)
            {
                return NotFound();
            }

            return giangVien;
        }

        //[HttpGet("{msgv}")]
        //public async Task<ActionResult<GiangVien>> GetCurrent(string msgv)
        //{
        //    return await _context.GiangVien.FirstOrDefaultAsync(gv => gv.Msgv.Equals(msgv));
        //}




        [HttpGet("{msgv}/lophoc")]
        public async Task<ActionResult> GetLopHoc(string msgv)
        {
            //var kq = await (from lh in _context.LopHoc
            //                join sv in _context.SinhVienTrongLopHoc on lh.Id equals sv.IdlopHoc
            //                join ctnh in _context.ChiTietNgayHoc on lh.Id equals ctnh.IdlopHoc
            //                join s in _context.SinhVien on sv.IdsinhVien equals s.Id
            //                join gv in _context.GiangVien on lh.IdgiangVien equals gv.Id
            //                join mh in _context.MonHoc on lh.IdmonHoc equals mh.Id
            //                where gv.Msgv.Equals(msgv)
            //                select new
            //                {
            //                    maLopHoc = lh.Id,
            //                    tenMonHoc = mh.TenMonHoc,

            //                    msgv = gv.Msgv
            //                }).ToListAsync();

            var kq = await (from lh in _context.LopHoc
                            join gv in _context.GiangVien
                            on lh.IdgiangVien equals gv.Id
                            join mh in _context.MonHoc
                            on lh.IdmonHoc equals mh.Id
                            where gv.Msgv.Equals(msgv)
                            select new
                            {

                                maLopHoc = lh.Id,
                                maMonHoc = mh.Id,
                                tenMonHoc = mh.TenMonHoc,
                                giangVien = gv.Msgv,
                                sinhVienTrongLopHocs = (from sv in _context.SinhVienTrongLopHoc
                                                        join s in _context.SinhVien on sv.IdsinhVien equals s.Id
                                                        where sv.IdlopHoc == lh.Id
                                                        select new
                                                        {
                                                            mssv = s.Mssv,
                                                            tenSinhVien = s.HoTen
                                                        }).ToList(),
                                thoiKhoaBieu = (from tkb in _context.ChiTietNgayHoc
                                                where tkb.IdlopHoc == lh.Id
                                                select tkb).ToList()
                            }).ToListAsync();

            return Ok(kq);




        }

        [HttpGet("chitietdiemdanh/{maNgayHoc}")]
        public async Task<ActionResult> GetChiTietDiemDanhTheoThoiKhoaBieu(int maNgayHoc)
        {
            // initChiTietDiemDanh();

            var rs = await (from ctdd in _context.ChiTietDiemDanh
                            join nh in _context.ChiTietNgayHoc
                            on ctdd.IdchiTietNgayHoc equals nh.Id
                            join sv in _context.SinhVienTrongLopHoc
                            on ctdd.IdsinhVienTrongLopHoc equals sv.Id
                            join s in _context.SinhVien
                            on sv.IdsinhVien equals s.Id
                            where nh.Id == maNgayHoc
                            select new
                            {
                                mssv = s.Mssv,
                                isDiemDanh = ctdd.IsDiemDanh
                            }).ToListAsync();


            return Ok(rs);
        }



        [HttpGet("lophoc/{idLopHoc}/thongbao/{idThongBao}")]
        public async Task<ActionResult> GetThongBao(int idLopHoc, int idThongBao)
        {
            var danhSachLopHocCuaGiangVien = await (from lh in _context.LopHoc
                                                    join gv in _context.GiangVien
                                                    on lh.IdgiangVien equals gv.Id
                                                    where gv.Msgv.Equals(User.Identity.Name)
                                                    select lh
                          ).ToListAsync();
            var lopHocDaChon = danhSachLopHocCuaGiangVien.FirstOrDefault(lh => lh.Id.Equals(idLopHoc));
            if (lopHocDaChon == null)
            {
                return BadRequest("Giang vien nay khong day lop hoc nay!");

            }
            else
            {
                var thongBao = await _context.ThongBao.FindAsync(idThongBao);
                if (thongBao == null)
                    return NotFound();
                else
                {

                    return Ok(thongBao);
                }
            }
        }

        [HttpGet("lophoc/{idLopHoc}/thongbao")]
        public async Task<ActionResult> GetDanhSachThongBao(int idLopHoc)
        {
            var danhSachLopHocCuaGiangVien = await (from lh in _context.LopHoc
                                                    join gv in _context.GiangVien
                                                    on lh.IdgiangVien equals gv.Id
                                                    where gv.Msgv.Equals(User.Identity.Name)
                                                    select lh
                          ).ToListAsync();
            var lopHocDaChon = danhSachLopHocCuaGiangVien.FirstOrDefault(lh => lh.Id.Equals(idLopHoc));
            if (lopHocDaChon == null)
            {
                return BadRequest("Giang vien nay khong day lop hoc nay!");

            }
            else
            {
                var danhSachThongBao = await _context.ThongBao.Where(tb => tb.IdlopHoc == idLopHoc).ToListAsync();
                if (danhSachThongBao == null)
                    return NotFound();
                else
                {

                    return Ok(danhSachThongBao);
                }
            }
        }


        [HttpPost("diemdanh/{maNgayHoc}")]
        public async Task<ActionResult> DiemDanhTheoNgayHoc(int maNgayHoc, [FromBody]Base64ImageStringHelper base64ImageString)
        {
            // initChiTietDiemDanh();

            MSCognitionService.CreateClient();
            var danhSachDiemDanh = (from ctdd in _context.ChiTietDiemDanh
                                    join nh in _context.ChiTietNgayHoc
                                    on ctdd.IdchiTietNgayHoc equals nh.Id
                                    join sv in _context.SinhVienTrongLopHoc
                                    on ctdd.IdsinhVienTrongLopHoc equals sv.Id
                                    join s in _context.SinhVien
                                    on sv.IdsinhVien equals s.Id
                                    where nh.Id == maNgayHoc
                                    select new
                                    {
                                        chiTietDiemDanh = ctdd,
                                        mssv = s.Mssv,
                                        isDiemDanh = ctdd.IsDiemDanh
                                    }).ToList();


            MSCognitionService.CreateClient();

            try
            {
                var faceResults = await MSCognitionService.IdentityAFaceAsyncFromStream(base64ImageString.base64ImageString);

                if (faceResults == null || faceResults.Count == 0)
                {
                    return BadRequest("Hình ảnh hợp lệ, nhưng không có khuôn mặt nào được tìm thấy!");
                }
                foreach (var chiTietDiemdanh in danhSachDiemDanh)

                {

                    foreach (var faceResult in faceResults)
                    {
                        var mssv = faceResult.ExternalID;
                        if (chiTietDiemdanh.mssv.Equals(mssv))
                        {
                            var ctddTemp = chiTietDiemdanh.chiTietDiemDanh;
                            ctddTemp.IsDiemDanh = true;
                            _context.Update(ctddTemp);

                        }
                    }
                }
                await _context.SaveChangesAsync();

                danhSachDiemDanh = (from ctdd in _context.ChiTietDiemDanh
                                    join nh in _context.ChiTietNgayHoc
                                    on ctdd.IdchiTietNgayHoc equals nh.Id
                                    join sv in _context.SinhVienTrongLopHoc
                                    on ctdd.IdsinhVienTrongLopHoc equals sv.Id
                                    join s in _context.SinhVien
                                    on sv.IdsinhVien equals s.Id
                                    where nh.Id == maNgayHoc
                                    select new
                                    {
                                        chiTietDiemDanh = ctdd,
                                        mssv = s.Mssv,
                                        isDiemDanh = ctdd.IsDiemDanh
                                    }).ToList();
                return Ok(new
                {
                    danhSachKhuonMatTimThay = faceResults,
                    danhSachDiemDanh = danhSachDiemDanh

                });
            }
            catch (Exception e)
            {
                return BadRequest("Hình ảnh không hợp lệ: \n-sai định dạng\n-không có khuôn mặt nào trong ảnh\n... !\n" + e.Message);
            }



        }


        public void initChiTietDiemDanh()
        {
            var danhSachLopHoc = _context.LopHoc.ToList();
            foreach (var lopHoc in danhSachLopHoc)
            {
                var danhSachSinhVien = _context.SinhVienTrongLopHoc.Where(sv => sv.IdlopHoc == lopHoc.Id).ToList();
                var danhSachNgayHoc = _context.ChiTietNgayHoc.Where(ctnh => ctnh.IdlopHoc == lopHoc.Id).ToList();
                foreach (var nh in danhSachNgayHoc)
                {
                    foreach (var sv in danhSachSinhVien)
                    {
                        var chiTietDiemDanh = _context.ChiTietDiemDanh.FirstOrDefault(ctdd => ctdd.IdchiTietNgayHoc == nh.Id && ctdd.IdsinhVienTrongLopHoc == sv.Id);
                        if (chiTietDiemDanh == null)
                        {
                            var chiTietDiemDanhTemp = new ChiTietDiemDanh();
                            chiTietDiemDanhTemp.IdchiTietNgayHoc = nh.Id;
                            chiTietDiemDanhTemp.IdsinhVienTrongLopHoc = sv.Id;
                            chiTietDiemDanhTemp.IsDiemDanh = false;
                            _context.ChiTietDiemDanh.Add(chiTietDiemDanhTemp);

                        }
                    }
                }
            }
            _context.SaveChanges();
        }

        [HttpPost("lophoc/{idLopHoc}/thongbao")]
        public async Task<IActionResult> PostThongBao(int idLopHoc, ThongBaoHelper thongBaoHelper)
        {
            var danhSachLopHocCuaGiangVien = await (from lh in _context.LopHoc
                                                    join gv in _context.GiangVien
                                                    on lh.IdgiangVien equals gv.Id
                                                    where gv.Msgv.Equals(User.Identity.Name)
                                                    select lh
                          ).ToListAsync();
            var lopHocDaChon = danhSachLopHocCuaGiangVien.FirstOrDefault(lh => lh.Id.Equals(idLopHoc));
            if (lopHocDaChon == null)
            {
                return BadRequest("Giang vien nay khong day lop hoc nay!");
            }
            else
            {
                var temp = new ThongBao();

                temp.IdlopHoc = idLopHoc;
                temp.NgayTao = DateTime.Now;
                temp.TieuDe = thongBaoHelper.TieuDe;
                temp.NoiDung = thongBaoHelper.NoiDung;
                await _context.ThongBao.AddAsync(temp);
                await _context.SaveChangesAsync();
                return Ok(temp);
            }
        }
        //[HttpPost("diemdanh/{maNgayHoc}/{mssv}")]
        //public async Task<IActionResult> PutGiangVien(int maNgayHoc, String mssv)
        //{

        //}



        // PUT: api/GiangViens/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.


        [HttpPut("diemdanh/{maNgayHoc}")]
        public async Task<ActionResult> DiemDanhSinhVien(int maNgayHoc, List<SinhVienHelper> sinhVienHelper)
        {
            // initChiTietDiemDanh();

            MSCognitionService.CreateClient();
            var chiTietDiemDanh = await (from ctdd in _context.ChiTietDiemDanh
                                         join nh in _context.ChiTietNgayHoc
                                         on ctdd.IdchiTietNgayHoc equals nh.Id
                                         join sv in _context.SinhVienTrongLopHoc
                                         on ctdd.IdsinhVienTrongLopHoc equals sv.Id
                                         join s in _context.SinhVien
                                         on sv.IdsinhVien equals s.Id
                                         where nh.Id == maNgayHoc
                                         select new
                                         {

                                             chiTietDiemDanh = ctdd,
                                             mssv = s.Mssv,
                                             isDiemDanh = ctdd.IsDiemDanh
                                         }).ToListAsync();


            if (chiTietDiemDanh == null)
                return NotFound("Không tìm thấy ChiTietDiemDanh cho mã ngày học này");


            List<String> lstChiTietDiemDanhAfter = new List<String>();
            foreach (var sh in sinhVienHelper)
            {

                var ctddTemp = chiTietDiemDanh.FirstOrDefault(ctdt => ctdt.mssv.Equals(sh.MSSV)).chiTietDiemDanh;
                
                ctddTemp.IsDiemDanh = sh.isDiemDanh;


                _context.Update(ctddTemp);

                if (sh.isDiemDanh)
                    lstChiTietDiemDanhAfter.Add(sh.MSSV + " " + "Có mặt");
                else if (!sh.isDiemDanh)
                    lstChiTietDiemDanhAfter.Add(sh.MSSV + " " + "Vắng mặt");

            }
            await _context.SaveChangesAsync();


            //TODO: Gui thong bao, fix lai danh sach ChiTietDiemDanh
            var lopHoc = (await (from lh in _context.LopHoc
                                 join nh in _context.ChiTietNgayHoc
                                 on lh.Id equals nh.IdlopHoc
                                 where nh.Id == maNgayHoc
                                 select new { idLopHoc = lh.Id, ngayHoc = nh.ThoiGianBatDauBuoiHoc }
                                  ).ToListAsync()).FirstOrDefault();


            string chiTietDiemDanhString = "";
            foreach (var ctdd in lstChiTietDiemDanhAfter)
            {
                chiTietDiemDanhString += ctdd + "\n";
            }
            if (lopHoc != null)
            {
                await PostThongBao(lopHoc.idLopHoc, new ThongBaoHelper
                {
                    TieuDe = "Điểm danh ngày: " + lopHoc.ngayHoc,
                    NoiDung = chiTietDiemDanhString,

                });
            }
            //
            return Ok(chiTietDiemDanh);



        }




        [HttpPut("{msgv}")]
        public async Task<IActionResult> PutGiangVien(string msgv, GiangVien giangVienUpdated)
        {

            var temp = await _context.GiangVien.FirstOrDefaultAsync(gv => gv.Msgv.Equals(msgv));
            if (temp == null)
            {
                return NotFound();

            }
            else
            {
                if (giangVienUpdated.HoTen != null)
                    temp.HoTen = giangVienUpdated.HoTen;
                if (giangVienUpdated.NgaySinh != null)
                    temp.NgaySinh = giangVienUpdated.NgaySinh;
                if (giangVienUpdated.SoDienThoai != null)
                    temp.SoDienThoai = giangVienUpdated.SoDienThoai;
                if (giangVienUpdated.GioiTinh != null)
                    temp.GioiTinh = giangVienUpdated.GioiTinh;
                if (giangVienUpdated.DiaChi != null)
                    temp.DiaChi = giangVienUpdated.DiaChi;
                if (giangVienUpdated.Email != null)
                    temp.Email = giangVienUpdated.Email;
                if (giangVienUpdated.GhiChu != null)
                    temp.GhiChu = giangVienUpdated.GhiChu;


                _context.GiangVien.Update(temp);
                await _context.SaveChangesAsync();
                return Ok(temp);
            }
        }



        [HttpPut("{msgv}/matkhau")]
        public async Task<IActionResult> DoiMatKhau(string msgv, GiangVienHelper giangVienHelper)
        {

            var temp = await _context.GiangVien.FirstOrDefaultAsync(gv => gv.Msgv.Equals(msgv));
            if (temp == null)
            {
                return NotFound();

            }
            else
            {
                if (giangVienHelper.matKhauCu.Equals(temp.MatKhau))
                {

                    temp.MatKhau = giangVienHelper.matKhauMoi;
                    _context.GiangVien.Update(temp);
                    await _context.SaveChangesAsync();
                    return Ok(temp);
                }
                else
                {
                    return BadRequest("Sai mat khau cu!");
                }
            }
        }


        [HttpPut("lophoc/{idLopHoc}/thongbao/{idThongBao}")]
        public async Task<ActionResult> UpdateThongBao(int idLopHoc, int idThongBao, ThongBaoHelper thongBaoHelper)
        {
            var danhSachLopHocCuaGiangVien = await (from lh in _context.LopHoc
                                                    join gv in _context.GiangVien
                                                    on lh.IdgiangVien equals gv.Id
                                                    where gv.Msgv.Equals(User.Identity.Name)
                                                    select lh
                          ).ToListAsync();
            var lopHocDaChon = danhSachLopHocCuaGiangVien.FirstOrDefault(lh => lh.Id.Equals(idLopHoc));
            if (lopHocDaChon == null)
            {
                return BadRequest("Giang vien nay khong day lop hoc nay!");

            }
            else
            {
                var thongBao = await _context.ThongBao.FindAsync(idThongBao);
                if (thongBao == null)
                    return NotFound();
                else
                {
                    thongBao.TieuDe = thongBaoHelper.TieuDe + "(Cập nhật " + DateTime.Now + ")";
                    thongBao.NoiDung = thongBaoHelper.NoiDung;
                    _context.ThongBao.Update(thongBao);
                    await _context.SaveChangesAsync();
                    return Ok(thongBao);
                }
            }
        }








        [HttpDelete("lophoc/{idLopHoc}/thongbao/{idThongBao}")]
        public async Task<ActionResult> DeleteThongBao(int idLopHoc, int idThongBao)
        {
            var danhSachLopHocCuaGiangVien = await (from lh in _context.LopHoc
                                                    join gv in _context.GiangVien
                                                    on lh.IdgiangVien equals gv.Id
                                                    where gv.Msgv.Equals(User.Identity.Name)
                                                    select lh
                          ).ToListAsync();
            var lopHocDaChon = danhSachLopHocCuaGiangVien.FirstOrDefault(lh => lh.Id.Equals(idLopHoc));
            if (lopHocDaChon == null)
            {
                return BadRequest("Giang vien nay khong day lop hoc nay!");

            }
            else
            {
                var thongBao = await _context.ThongBao.FindAsync(idThongBao);
                if (thongBao == null)
                    return NotFound();
                else
                {
                    _context.ThongBao.Remove(thongBao);
                    await _context.SaveChangesAsync();
                    return Ok();
                }
            }
        }

        //// POST: api/GiangViens
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for
        //// more details see https://aka.ms/RazorPagesCRUD.
        //[HttpPost]
        //public async Task<ActionResult<GiangVien>> PostGiangVien(GiangVien giangVien)
        //{
        //    _context.GiangVien.Add(giangVien);
        //    await _context.SaveChangesAsync();

        //    return CreatedAtAction("GetGiangVien", new { id = giangVien.Id }, giangVien);
        //}

        //// DELETE: api/GiangViens/5
        //[HttpDelete("{id}")]
        //public async Task<ActionResult<GiangVien>> DeleteGiangVien(int id)
        //{
        //    var giangVien = await _context.GiangVien.FindAsync(id);
        //    if (giangVien == null)
        //    {
        //        return NotFound();
        //    }

        //    _context.GiangVien.Remove(giangVien);
        //    await _context.SaveChangesAsync();

        //    return giangVien;
        //}

        private bool GiangVienExists(int id)
        {
            return _context.GiangVien.Any(e => e.Id == id);
        }
    }
}
