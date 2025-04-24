using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Care4Plant_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ActividadController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        public ActividadController(ApplicationDbContext context)
        {
            _context = context;
        }
        [HttpGet("GetByCategoria")]
        [Authorize]
        public async Task<IActionResult> GetByCategoria(int id_categoria)
        {
            string acceptLanguageHeader = Request.Headers.AcceptLanguage.ToString(); //se obtiene la cabezera accept language
            var actividades = await _context.Actividad.Where(l => l.id_categoria == id_categoria).Select(c => new
            {
                c.id_actividad,
                nombre_actividad = c.nombre_actividad.RootElement.GetProperty(acceptLanguageHeader).GetString(),
                c.imagen_actividad,
                descripcion_actividad = c.descripcion_actividad.RootElement.GetProperty(acceptLanguageHeader).GetString(),
                contenido_actividad = (c.contenido_actividad.RootElement.GetProperty("all").GetString() != null) ? // Primero se consulta si es que esta la propiedad all
                c.contenido_actividad.RootElement.GetProperty("all").GetString() :  // Si esta se retorna all
                c.contenido_actividad.RootElement.GetProperty(acceptLanguageHeader).GetString(), // Si no se retorna segun el acceptlanguage
                c.tiempo_actividad
            }).ToListAsync();
            return Ok(actividades);
        }
    }
}
