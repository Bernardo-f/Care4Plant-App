using Care4Plant_Api.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Care4Plant_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PensamientoController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        public PensamientoController(ApplicationDbContext context)
        {
            _context = context;
        }
        [Authorize]
        [HttpPost("add")]
        public async Task<IActionResult> AddPensamiento(Pensamiento pensamiento)
        {
            var currentUser = HttpContext.User;
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            pensamiento.email_emisor = user.Email;
            await _context.Pensamiento.AddAsync(pensamiento);
            await _context.SaveChangesAsync();
            return Ok();
        }
        [Authorize]
        [HttpGet("GetPensamientos")]
        public async Task<IActionResult> GetPensamientos(string? Email)
        {
            if (Email == null)
            {
                var currentUser = HttpContext.User;
                Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
                if (user == null)
                {
                    return BadRequest();
                }
                Email = user.Email;
            }
            var Pensamientos = _context.Pensamiento.Where(l => l.email_emisor == Email).Include(l => l.meGustas).ThenInclude(l => l.pensamiento).Select(l => new
            {
                l.fecha_pensamiento,
                l.contenido_pensamiento,
                numero_me_gustas = l.meGustas.Count(),
                megusta = l.meGustas.Where(a => a.pensamiento == l && a.email_megusta == User.Identity.Name).Any()
            }).OrderByDescending(l => l.fecha_pensamiento);
            return Ok(Pensamientos);
        }
        [Authorize]
        [HttpPost("MeGusta")]
        public async Task<IActionResult> MeGusta([FromForm] string? email_emisor, [FromForm] DateTime fecha_pensamiento)
        {
            var currentUser = HttpContext.User;
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            email_emisor = (email_emisor == null) ? user.Email : email_emisor;// Si no llega el email del emisor buscara como emisor al cuidador de ls sesión
            var megusta = _context.Me_Gusta.Where(l => l.email_emisor == email_emisor &&
            l.email_megusta == user.Email &&
            l.fecha_pensamiento == fecha_pensamiento).FirstOrDefault();
            if (megusta != null)
            {
                _context.Me_Gusta.Remove(megusta);
                await _context.SaveChangesAsync();
                return Ok();
            }
            var pensamiento = await _context.Pensamiento.Where(l => l.email_emisor == email_emisor && l.fecha_pensamiento == fecha_pensamiento).FirstOrDefaultAsync();
            if (pensamiento == null)
            {
                return NotFound();
            }
            await _context.Me_Gusta.AddAsync(new MeGusta() { pensamiento = pensamiento, email_megusta = user.Email });
            await _context.SaveChangesAsync();
            return Ok();
        }
        [Authorize]
        [HttpGet("GetUser")]
        public async Task<IActionResult> GetUsers(int page)
        {
            var query = _context.Cuidador.Where(l => l.Acceso_invernadero == true && l.First_login == false && l.Email != User.Identity.Name);

            int totalRecords = await query.CountAsync();
            int pageSize = 9;
            int totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

            var cuidadores = await query
                .Select(l => new
                {
                    l.Nombre,
                    l.Email,
                    plant = (l.Nivel_estres >= 0 && l.Nivel_estres <= 5)
                        ? l.Plant.img_level_1 : (l.Nivel_estres >= 6 && l.Nivel_estres <= 10)
                        ? l.Plant.img_level_2 : (l.Nivel_estres >= 11 && l.Nivel_estres <= 15)
                        ? l.Plant.img_level_3 : (l.Nivel_estres >= 16 && l.Nivel_estres <= 20)
                        ? l.Plant.img_level_4 : l.Plant.img_level_5
                })
                .Skip(page * pageSize)
                .Take(pageSize)
                .ToListAsync();

            bool hasNextPage = (page < totalPages - 1);

            return Ok(new
            {
                usersGreenhouse = cuidadores,
                nextPage = hasNextPage
            });
        }

    }
}
