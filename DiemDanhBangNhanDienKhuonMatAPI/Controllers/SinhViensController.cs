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

namespace DiemDanhBangNhanDienKhuonMatAPI.Controllers
{
    [Route("api/sinhvien")]
    [ApiController]
    [Authorize(Roles ="sv")]
    public class SinhViensController : ControllerBase
    {
        private readonly DB_DIEMDANHContext _context;

        public SinhViensController(DB_DIEMDANHContext context)
        {
            _context = context;
        }

        // GET: api/SinhViens
        [HttpGet]

        public async Task<ActionResult<IEnumerable<SinhVien>>> GetSinhVien()
        {
            return await _context.SinhVien.ToListAsync();
        }

        // GET: api/SinhViens/5
        [HttpGet("{mssv}")]

        public async Task<ActionResult<SinhVien>> GetSinhVien(string mssv)
        {
            var sinhVien = await _context.SinhVien.FirstOrDefaultAsync(sv => sv.Mssv.Equals(mssv));

            if (sinhVien == null)
            {
                return NotFound();
            }

            return sinhVien;
        }

        [HttpGet("current")]
        [Authorize(Roles = "sv")]
        public async Task<ActionResult<SinhVien>> GetCurrent()
        {
            var sinhVien = await _context.SinhVien.FirstOrDefaultAsync(sv => sv.Mssv.Equals(User.Identity.Name));

            if (sinhVien == null)
            {
                return NotFound();
            }

            return sinhVien;
        }

        [HttpGet("{mssv}")]
        public async Task<ActionResult<SinhVien>> GetCurrent(string mssv)
        {
            return await _context.SinhVien.FirstOrDefaultAsync(sv => sv.Mssv.Equals(mssv));
        }

        // PUT: api/SinhViens/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPut("{mssv}")]
        public async Task<IActionResult> PutSinhVien(string mssv, SinhVien sinhVienUpdated)
        {

            var temp = await _context.SinhVien.FirstOrDefaultAsync(sv => sv.Mssv.Equals(mssv));
            if (temp == null)
            {
                return NotFound();

            }
            else
            {
                if (sinhVienUpdated.HoTen != null)
                    temp.HoTen = sinhVienUpdated.HoTen;
                if (sinhVienUpdated.NgaySinh != null)
                    temp.NgaySinh = sinhVienUpdated.NgaySinh;
                if (sinhVienUpdated.SoDienThoai != null)
                    temp.SoDienThoai = sinhVienUpdated.SoDienThoai;
                if (sinhVienUpdated.GioiTinh != null)
                    temp.GioiTinh = sinhVienUpdated.GioiTinh;
                if (sinhVienUpdated.DiaChi != null)
                    temp.DiaChi = sinhVienUpdated.DiaChi;
                if (sinhVienUpdated.Email != null)
                    temp.Email = sinhVienUpdated.Email;
                if (sinhVienUpdated.GhiChu != null)
                    temp.GhiChu = sinhVienUpdated.GhiChu;


                _context.SinhVien.Update(temp);
                await _context.SaveChangesAsync();
                return Ok(temp);
            }
        }
        [HttpPut("{mssv}/matkhau")]
        public async Task<IActionResult> DoiMatKhau(string mssv, SinhVienHelper sinhVienHelper)
        {

            var temp = await _context.SinhVien.FirstOrDefaultAsync(sv => sv.Mssv.Equals(mssv));
            if (temp == null)
            {
                return NotFound();

            }
            else
            {
                if (sinhVienHelper.matKhauCu.Equals(temp.MatKhau))
                {

                    temp.MatKhau = sinhVienHelper.matKhauMoi;
                    _context.SinhVien.Update(temp);
                    await _context.SaveChangesAsync();
                    return Ok(temp);
                }
                else
                {
                    return BadRequest("Sai mat khau cu!");
                }
            }
        }


        [HttpGet("{mssv}/thoikhoabieu")]
        public async Task<IActionResult> XemThoiKhoaBieu(string mssv)
        {



            //var sinhVien = await _context.SinhVien.FirstOrDefaultAsync(sv => sv.Mssv.Equals(mssv));
            //if (sinhVien == null)
            //    return NotFound();
            var kq = await (from s in _context.SinhVien
                            join sv in _context.SinhVienTrongLopHoc
                               on s.Id equals sv.IdsinhVien
                            join lh in _context.LopHoc
                               on sv.IdlopHoc equals lh.Id
                            join mh in _context.MonHoc
                               on lh.IdmonHoc equals mh.Id
                            join gv in _context.GiangVien
                               on lh.IdgiangVien equals gv.Id
                            join ctnh in _context.ChiTietNgayHoc
                               on lh.Id equals ctnh.IdlopHoc
                            where s.Mssv.Equals(mssv)
                            orderby mh.TenMonHoc
                            select new
                            {
                                tenMonHoc = mh.TenMonHoc,
                                ngayHoc = ctnh.ThoiGianBatDauBuoiHoc,
                                tenGiangVien = gv.HoTen,
                                phongHoc = ctnh.PhongHoc,
                            }).ToListAsync();

            return Ok(kq);
        }





        [HttpGet("{mssv}/chitietdiemdanh")]
        public async Task<IActionResult> XemChiTietDiemDanhAsync(string mssv)
        {




            var kq = await (
                             from ctdd in _context.ChiTietDiemDanh
                             join sv in _context.SinhVienTrongLopHoc on ctdd.IdsinhVienTrongLopHoc equals sv.Id
                             join s in _context.SinhVien on sv.IdsinhVien equals s.Id
                             join lh in _context.LopHoc on sv.IdlopHoc equals lh.Id
                             join mh in _context.MonHoc on lh.IdmonHoc equals mh.Id
                             join ctnh in _context.ChiTietNgayHoc on ctdd.IdchiTietNgayHoc equals ctnh.Id

                             where s.Mssv.Equals(mssv)
                             select new
                             {
                                 tenMonHoc = mh.TenMonHoc,
                                 ngayHoc = ctnh.ThoiGianBatDauBuoiHoc,
                                 phongHoc = ctnh.PhongHoc,
                                 isDiemDanh = ctdd.IsDiemDanh
                             }).ToListAsync();

            return Ok(kq);
        }

        [HttpGet("{mssv}/lophoc")]
        public async Task<IActionResult> XemDanhSachMonHocAsync(string mssv)
        {




            var kq = await (from s in _context.SinhVien
                            join sv in _context.SinhVienTrongLopHoc
                            on s.Id equals sv.IdsinhVien
                            join lh in _context.LopHoc
                            on sv.IdlopHoc equals lh.Id
                            join gv in _context.GiangVien
                            on lh.IdgiangVien equals gv.Id
                            join mh in _context.MonHoc
                            on lh.IdmonHoc equals mh.Id


                            where s.Mssv.Contains(mssv)
                            select new
                            {
                                tenMonHoc = mh.TenMonHoc,
                                tenGiangVien = gv.HoTen,
                                thongBao =  (from tb in _context.ThongBao
                                                  join lh in _context.LopHoc
                                                  on tb.IdlopHoc equals lh.Id

                                                  join sv in _context.SinhVienTrongLopHoc
                                                  on lh.Id equals sv.IdlopHoc
                                                  join s in _context.SinhVien
                                                  on sv.IdsinhVien equals s.Id
                                                  where s.Mssv.Equals(mssv)
                                                  select tb
                                                ).ToList()
                            }).ToListAsync();

            return Ok(kq);
        }


        [HttpGet("current/lophoc/{idLopHoc}/thongbao/{idThongBao}")]
        public async Task<ActionResult> GetThongBao(int idLopHoc, int idThongBao)
        {
            var danhSachLopHocCuaSinhVien = await (from lh in _context.LopHoc
                                                    join s in _context.SinhVienTrongLopHoc
                                                    on lh.Id equals s.IdlopHoc
                                                    join sv in _context.SinhVien
                                                    on s.IdsinhVien equals sv.Id
                                                    where sv.Mssv.Equals(User.Identity.Name)
                                                    select lh
                          ).ToListAsync();
            var lopHocDaChon = danhSachLopHocCuaSinhVien.FirstOrDefault(lh => lh.Id.Equals(idLopHoc));
            if (lopHocDaChon == null)
            {
                return BadRequest("Sinh vien nay khong hoc lop hoc nay!");

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

        [HttpGet("current/lophoc/{idLopHoc}/thongbao")]
        public async Task<ActionResult> GetDanhSachThongBaoTheoLopHoc(int idLopHoc)
        {
            var danhSachLopHocCuaSinhVien = await (from lh in _context.LopHoc
                                                   join s in _context.SinhVienTrongLopHoc
                                                   on lh.Id equals s.IdlopHoc
                                                   join sv in _context.SinhVien
                                                   on s.IdsinhVien equals sv.Id
                                                   where sv.Mssv.Equals(User.Identity.Name)
                                                   select lh
                          ).ToListAsync();
            var lopHocDaChon = danhSachLopHocCuaSinhVien.FirstOrDefault(lh => lh.Id.Equals(idLopHoc));
            if (lopHocDaChon == null)
            {
                return BadRequest("Sinh vien nay khong hoc lop hoc nay!");

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


        [HttpGet("current/lophoc/thongbao")]
        public async Task<ActionResult> GetDanhSachThongBaoTheoLopHoc()
        {
            var kq = await (from s in _context.SinhVien
                            join sv in _context.SinhVienTrongLopHoc
                            on s.Id equals sv.IdsinhVien
                            join lh in _context.LopHoc
                            on sv.IdlopHoc equals lh.Id
                            join gv in _context.GiangVien
                            on lh.IdgiangVien equals gv.Id
                            join mh in _context.MonHoc
                            on lh.IdmonHoc equals mh.Id


                            where s.Mssv.Contains(User.Identity.Name)
                            select new
                            {
                                tenMonHoc = mh.TenMonHoc,
                                tenGiangVien = gv.HoTen,
                                thongBao = (from tb in _context.ThongBao
                                            join lh2 in _context.LopHoc
                                            on tb.IdlopHoc equals lh2.Id

                                            join sv in _context.SinhVienTrongLopHoc
                                            on lh2.Id equals sv.IdlopHoc
                                            join s in _context.SinhVien
                                            on sv.IdsinhVien equals s.Id
                                            where s.Mssv.Equals(User.Identity.Name) && lh2.Id==lh.Id
                                            select tb
                                                ).ToList()
                            }).ToListAsync();

            return Ok(kq);
        }

        //[HttpGet("lophoc/thongbao")]
        //public async Task<ActionResult> GetDanhSachThongBao()
        //{
        //    var danhSachLopHocCuaSinhVien = await (from lh in _context.LopHoc
        //                                           join s in _context.SinhVienTrongLopHoc
        //                                           on lh.Id equals s.IdlopHoc
        //                                           join sv in _context.SinhVien
        //                                           on s.IdsinhVien equals sv.Id
        //                                           where sv.Mssv.Equals(User.Identity.Name)
        //                                           select lh
        //                  ).ToListAsync();
        //    var lopHocDaChon = danhSachLopHocCuaSinhVien.FirstOrDefault(lh => lh.Id.Equals(idLopHoc));
        //    if (lopHocDaChon == null)
        //    {
        //        return BadRequest("Sinh vien nay khong hoc lop hoc nay!");

        //    }
        //    else
        //    {
        //        var danhSachThongBao = await _context.ThongBao.Where(tb => tb.IdlopHoc == idLopHoc).ToListAsync();
        //        if (danhSachThongBao == null)
        //            return NotFound();
        //        else
        //        {

        //            return Ok(danhSachThongBao);
        //        }
        //    }
        //}



        // POST: api/SinhViens
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        //[HttpPost]
        //public async Task<ActionResult<SinhVien>> PostSinhVien(SinhVien sinhVien)
        //{
        //    _context.SinhVien.Add(sinhVien);
        //    await _context.SaveChangesAsync();

        //    return CreatedAtAction("GetSinhVien", new { id = sinhVien.Id }, sinhVien);
        //}

        //// DELETE: api/SinhViens/5
        //[HttpDelete("{id}")]
        //public async Task<ActionResult<SinhVien>> DeleteSinhVien(int id)
        //{
        //    var sinhVien = await _context.SinhVien.FindAsync(id);
        //    if (sinhVien == null)
        //    {
        //        return NotFound();
        //    }

        //    _context.SinhVien.Remove(sinhVien);
        //    await _context.SaveChangesAsync();

        //    return sinhVien;
        //}

        private bool SinhVienExists(int id)
        {
            return _context.SinhVien.Any(e => e.Id == id);
        }
    }
}
