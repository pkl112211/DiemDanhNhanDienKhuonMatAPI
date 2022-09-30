using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DiemDanhBangNhanDienKhuonMatAPI.Models;

namespace DiemDanhBangNhanDienKhuonMatAPI.Controllers
{
    [Route("api/thongbao")]
    [ApiController]
    public class ThongBaosController : ControllerBase
    {
        private readonly DB_DIEMDANHContext _context;

        public ThongBaosController(DB_DIEMDANHContext context)
        {
            _context = context;
        }

        // GET: api/ThongBaos
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ThongBao>>> GetThongBao()
        {
            return await _context.ThongBao.ToListAsync();
        }

        // GET: api/ThongBaos/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ThongBao>> GetThongBao(int id)
        {
            var thongBao = await _context.ThongBao.FindAsync(id);

            if (thongBao == null)
            {
                return NotFound();
            }

            return thongBao;
        }

        // PUT: api/ThongBaos/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutThongBao(int id, ThongBao thongBao)
        {
            if (id != thongBao.Id)
            {
                return BadRequest();
            }

            _context.Entry(thongBao).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ThongBaoExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/ThongBaos
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPost]
        public async Task<ActionResult<ThongBao>> PostThongBao(ThongBao thongBao)
        {
            _context.ThongBao.Add(thongBao);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetThongBao", new { id = thongBao.Id }, thongBao);
        }

        // DELETE: api/ThongBaos/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<ThongBao>> DeleteThongBao(int id)
        {
            var thongBao = await _context.ThongBao.FindAsync(id);
            if (thongBao == null)
            {
                return NotFound();
            }

            _context.ThongBao.Remove(thongBao);
            await _context.SaveChangesAsync();

            return thongBao;
        }

        private bool ThongBaoExists(int id)
        {
            return _context.ThongBao.Any(e => e.Id == id);
        }
    }
}
