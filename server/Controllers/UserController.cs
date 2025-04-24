using Care4Plant_Api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace Care4Plant_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        public UserController(ApplicationDbContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
        }
        [HttpPost("SaveBasicSettings")]
        [Authorize(Roles = "User")]
        public async Task<IActionResult> SaveBasicSettings(BasicSettings basicSettings)
        {
            var currentUser = HttpContext.User;
            Cuidador user = _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefault();
            if (user == null)
            {
                return BadRequest();
            }
            user.Idioma = basicSettings.Idioma;
            user.Semana_frecuencia_test = basicSettings.Semana_Frecuencia_test;
            user.Frecuencia_test = basicSettings.Frecuencia_test;
            user.PlantId = basicSettings.PlantId;
            user.Acceso_invernadero = basicSettings.Acceso_invernadero;
            user.Notificacion_actividades = basicSettings.Notificacion_actividades;
            user.Notificacion_test = basicSettings.Notificacion_test;
            user.First_login = false;
            _context.Entry(user).State = EntityState.Modified;
            _context.SaveChanges();
            var plantImages = _context.Planta.Where(l => l.Id == user.PlantId).FirstOrDefault();
            return Ok(plantImages);
            //_httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.Name);
        }
        [HttpPost("SetNotificacionActividades")]
        [Authorize(Roles = "User")]
        public async Task<IActionResult> SetNotificacionActividades([FromBody] bool value)
        {
            var currentUser = HttpContext.User;
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            user.Notificacion_actividades = value;
            _context.Entry(user).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return Ok();
        }
        [HttpPost("SetNotificacionTest")]
        [Authorize(Roles = "User")]
        public async Task<IActionResult> SetNotificacionTest([FromBody] bool value)
        {
            var currentUser = HttpContext.User;
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            user.Notificacion_test = value;
            _context.Entry(user).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return Ok();
        }
        [HttpPost("SetAccesoInvernadero")]
        [Authorize(Roles = "User")]
        public async Task<IActionResult> SetAccesoInvernadero([FromBody] bool value)
        {
            var currentUser = HttpContext.User;
            if (currentUser.Identity == null)
            {
                return BadRequest();
            }
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            user.Acceso_invernadero = value;
            _context.Entry(user).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return Ok();
        }
        [HttpPost("SetFrecuenciaTest")]
        [Authorize(Roles = "User")]
        public async Task<IActionResult> SetFrecuenciaTest([FromForm] int semanaFrecuenciaTest, [FromForm] int frecuenciaTest)
        {
            var currentUser = HttpContext.User;
            if (currentUser.Identity == null)
            {
                return BadRequest();
            }
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            user.Semana_frecuencia_test = semanaFrecuenciaTest;
            user.Frecuencia_test = frecuenciaTest;
            _context.Entry(user).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return Ok();
        }
        [HttpGet("GetRecomendacion")]
        [Authorize]
        public async Task<IActionResult> GetRecomendacion()
        {
            var currentUser = HttpContext.User;
            if (currentUser.Identity == null)
            {
                return BadRequest();
            }
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            string acceptLanguageHeader = Request.Headers.AcceptLanguage.ToString(); //se obtiene la cabezera accept language

            var maxFechaReporte = await _context.Recomendacion
                .Where(l => l.email_recom == user.Email)
                .MaxAsync(l => (DateTime?)l.fecha_recom);
            if (maxFechaReporte == null)
            {
                return NotFound();
            }
            var lastReporteDiario = await _context.Ofrece
                .Where(l => l.email_recom == user.Email && l.fecha_recom == maxFechaReporte)
                .Include(l => l.categoria)
                .Select(l => new
                {
                    l.recom_realizada,
                    categoria = new
                    {
                        l.categoria.id_categoria,
                        Nombre_categoria = l.categoria.nombre_categoria.RootElement.GetProperty(acceptLanguageHeader).GetString(),
                        l.categoria.icono_categoria,
                        l.categoria.imagen_categoria,
                        Descripcion_categoria = l.categoria.descripcion_categoria.RootElement.GetProperty(acceptLanguageHeader).GetString(),
                        l.categoria.estres_categoria,
                        l.categoria.layout_categoria
                    }
                }).ToListAsync();
            return Ok(lastReporteDiario);
        }
        [HttpGet("ValidateDateTest")]
        [Authorize]
        public async Task<IActionResult> ValidateDateTest(DateTimeOffset fechaDispositivo) // Valida si es que el usuario puede responder el test segun la configuracion ingresada
        {
            var currentUser = HttpContext.User;
            if (currentUser.Identity == null)
            {
                return BadRequest();
            }
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null || user.Semana_frecuencia_test == null)
            {
                return BadRequest();
            }
            var resEnElPeriodo = await _context.Test.Where(l => l.UserId == user.Email && l.Fecha_test >= fechaDispositivo.AddDays(-7 * (double)user.Semana_frecuencia_test)).CountAsync();
            var ultimaFecha = await _context.Test
                .Where(l => l.UserId == user.Email)
                .MaxAsync(l => (DateTime?)l.Fecha_test);
            TimeSpan tiempo_desde_ultima_respuesta = (TimeSpan)(fechaDispositivo - ultimaFecha);
            return Ok(resEnElPeriodo < user.Frecuencia_test && tiempo_desde_ultima_respuesta.TotalDays > 1);
        }
        [HttpGet("GetAccesorios")]
        [Authorize]
        public async Task<IActionResult> GetAccesorios()
        {
            var currentUser = HttpContext.User;
            if (currentUser.Identity == null)
            {
                return BadRequest();
            }
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null || user.Semana_frecuencia_test == null)
            {
                return BadRequest();
            }
            var accesorio = await _context.Accesorio.Include(l => l.Users).Select(l => new
            {
                l.id_accesorio,
                l.accion_accesorio,
                l.imagen_accesorio,
                cantidad = l.Users.Where(l => l.Email == user.Email).Count(), //Se obtiene la cantidad que tiene el usuario filtrado en el where
            }).ToListAsync();
            return Ok(accesorio);
        }
        [HttpPost("UsarAccesorio")]
        [Authorize]
        public async Task<IActionResult> UsarAccesorio(int id_accesorio)
        {
            var currentUser = HttpContext.User;
            if (currentUser.Identity == null)
            {
                return BadRequest();
            }
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null || user.Semana_frecuencia_test == null)
            {
                return BadRequest();
            }
            Posee? accesorioPosee = await _context.Posee.Where(l => l.UsersEmail == user.Email && l.Accesoriosid_accesorio == id_accesorio).FirstOrDefaultAsync();
            if (accesorioPosee == null)
            {
                return BadRequest();
            }
            int pesoAccesorio = await _context.Accesorio.Where(l => l.id_accesorio == id_accesorio).Select(l => l.peso_accesorio).FirstOrDefaultAsync();
            string sql = $@"
                    DELETE FROM ""public"". ""Posee""
                    WHERE ctid IN (
                        SELECT ctid
                        FROM ""public"". ""Posee""
                        WHERE ""UsersEmail"" = '{user.Email}' AND ""Accesoriosid_accesorio"" = {accesorioPosee.Accesoriosid_accesorio}
                        LIMIT 1
                    )";
            user.Nivel_estres -= pesoAccesorio;
            _context.Entry(user).State = EntityState.Modified;
            _context.Database.ExecuteSqlRaw(sql);
            await _context.SaveChangesAsync();
            return Ok(user.Nivel_estres);
        }
    }
}
