using Care4Plant_Api.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Microsoft.EntityFrameworkCore;

namespace Care4Plant_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StressTestController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        public StressTestController(ApplicationDbContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
        }
        [HttpPost("Register")]
        [Authorize(Roles = "User")]
        public async Task<IActionResult> RegisterTest(Test stressTest)
        {
            var currentUser = HttpContext.User;
            Cuidador user = _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefault();
            if (user == null)
            {
                return BadRequest();
            }
            stressTest.User = user;
            await _context.Test.AddAsync(stressTest);
            user.Nivel_estres = stressTest.Answer_1 + stressTest.Answer_2 + stressTest.Answer_3 + stressTest.Answer_4 + stressTest.Answer_5 + stressTest.Answer_6;

            var random = new Random();
            var nro_categorias = await _context.AjusteRecomendacion.Where(l => l.nivel_estres == (int)user.Nivel_estres / 5 + 1).Select(l => l.nivel_estres).FirstOrDefaultAsync();
            var categorias = await _context.Categoria.Where(l => l.estres_categoria.Contains((int)(user.Nivel_estres / 5) + 1)).ToListAsync();
            categorias = categorias.OrderBy(l => random.Next()).Take(nro_categorias).ToList();

            Recomendacion recomendacion = new Recomendacion() { email_recom = user.Email, fecha_recom = stressTest.Fecha_test };
            List<Ofrece> ofrece = new List<Ofrece>();
            foreach (var categoria in categorias)
            {
                ofrece.Add(new Ofrece() { email_recom = user.Email, fecha_recom = stressTest.Fecha_test, id_categoria = categoria.id_categoria });
            }
            recomendacion.Ofrece = ofrece;
            await _context.Recomendacion.AddAsync(recomendacion);

            _context.Entry(user).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return Ok(user.Nivel_estres);
        }
        [HttpGet("GetDateNotification")]
        [Authorize]
        public async Task<IActionResult> GetDateNotification()
        {
            var user = await _context.Cuidador.Where(l => l.Email == User.Identity.Name).FirstOrDefaultAsync();
            var dates  = await _context.Test.Where(l => l.UserId == User.Identity.Name).OrderByDescending(l => l.Fecha_test).Select(l => (DateTime)l.Fecha_test).Take((int)user.Frecuencia_test).ToListAsync();
            if(dates.Count < user.Frecuencia_test)
            {
                return Ok(dates.Max().AddDays(1));
            }
            else
            {
                return Ok(dates.Min().AddDays(7*(int)user.Semana_frecuencia_test));
            }
        }
    }
}
