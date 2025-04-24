using Microsoft.AspNetCore.Mvc;

namespace Care4Plant_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriaController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        public CategoriaController(ApplicationDbContext context)
        {
            _context = context;
        }
        [HttpGet("GetAll")]
        public IActionResult GetAll()
        {
            string acceptLanguageHeader = Request.Headers.AcceptLanguage.ToString(); //se obtiene la cabezera accept language
            var query = _context.Categoria
            .Select(c => new
            {
                c.id_categoria,
                Nombre_categoria = c.nombre_categoria.RootElement.GetProperty(acceptLanguageHeader).GetString(),
                c.imagen_categoria,
                c.icono_categoria,
                Descripcion_categoria = c.descripcion_categoria.RootElement.GetProperty(acceptLanguageHeader).GetString(),
                c.estres_categoria,
                c.layout_categoria
            })
            .ToList();
            return Ok(query);
        }
    }
}
