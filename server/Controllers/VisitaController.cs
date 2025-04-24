using Care4Plant_Api.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Care4Plant_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VisitaController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        public VisitaController(ApplicationDbContext context)
        {
            _context = context;
        }
        [Authorize]
        [HttpPost("AddVisitaCategoria")]
        public async Task<IActionResult> AddVisitaCategoria(Visita visita)
        {
            var currentUser = HttpContext.User;
            Cuidador user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            visita.email_visita = user.Email;
            await _context.Visita.AddAsync(visita);
            await _context.SaveChangesAsync();
            return Ok();
        }
        [Authorize]
        [HttpPost("addIngresoActividad")]
        public async Task<IActionResult> addIngresaActividad(Ingresa ingresa)
        {
            string acceptLanguageHeader = Request.Headers.AcceptLanguage.ToString(); //se obtiene la cabezera accept language
            var currentUser = HttpContext.User;
            Cuidador user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            ingresa.email_ingresa = user.Email;
            await _context.Ingresa.AddAsync(ingresa);
            if (!ingresa.finalizada)
            {
                await _context.SaveChangesAsync();
                return Ok();
            }
            //
            var id_categoria = await _context.Actividad.Where(l => l.id_actividad == ingresa.id_actividad).Select(l => l.id_categoria).FirstOrDefaultAsync();
            var ids_accesorios = await _context.Categoria.Where(l => l.id_categoria == id_categoria)
                .Include(l => l.Otorga)
                .SelectMany(l => l.Otorga)
                .Select(l => l.id_accesorio).ToListAsync();
            var accesorios = await _context.Accesorio.Where(l => ids_accesorios.Contains(l.id_accesorio))
                .Select(l => new { l.id_accesorio, Accion_accesorio = l.accion_accesorio.RootElement.GetProperty(acceptLanguageHeader).GetString() })
                .ToListAsync();
            //
            var random = new Random();
            var accesorio = accesorios.OrderBy(l => random.Next()).Take(1).FirstOrDefault();
            string sql = $@"
                    INSERT INTO public.""Posee""(
	                ""UsersEmail"", ""Accesoriosid_accesorio"")
	                VALUES ('{user.Email}', {accesorio.id_accesorio})";
            _context.Database.ExecuteSqlRaw(sql);

            var maxFechaReporte = await _context.Recomendacion
                .Where(l => l.email_recom == user.Email)
                .MaxAsync(l => (DateTime?)l.fecha_recom);
            var Recomendacion = await _context.Recomendacion.Where(l => l.email_recom == user.Email && l.fecha_recom == maxFechaReporte).FirstOrDefaultAsync();
            if (Recomendacion != null)
            {
                var Ofrece = await _context.Ofrece.Where(l => l.email_recom == user.Email && l.fecha_recom == maxFechaReporte && l.id_categoria == id_categoria && l.recom_realizada == false).FirstOrDefaultAsync();
                if (Ofrece != null)
                {
                    Ofrece.recom_realizada = true;
                    _context.Entry(Ofrece).State = EntityState.Modified;
                    await _context.SaveChangesAsync();
                }
                if (Recomendacion.accesorio_entregado == false)
                {
                    var checkActividades = await _context.Ofrece.Where(l => l.email_recom == user.Email && l.fecha_recom == maxFechaReporte).AllAsync(l => l.recom_realizada == true);
                    if (checkActividades == true)
                    {
                        Console.Write("entro 2");
                        var Accesorios = await _context.Accesorio.ToListAsync();
                        var AccesorioRecomendacion = Accesorios.OrderBy(r => random.Next()).FirstOrDefault();
                        sql = $@"
                            INSERT INTO public.""Posee""(
	                        ""UsersEmail"", ""Accesoriosid_accesorio"")
	                        VALUES ('{user.Email}', {AccesorioRecomendacion.id_accesorio})";
                        _context.Database.ExecuteSqlRaw(sql);
                        Recomendacion.accesorio_entregado = true;
                        _context.Entry(Recomendacion).State = EntityState.Modified;
                    }
                }
            }
            if (accesorios.Count() == 0)
            {
                return BadRequest();
            }

            await _context.SaveChangesAsync();
            return Ok(accesorio.Accion_accesorio);
        }
    }
}
