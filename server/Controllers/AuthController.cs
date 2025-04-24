using Care4Plant_Api.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Care4Plant_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IConfiguration _configuration;
        public AuthController(ApplicationDbContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }
        [HttpPost("Register")]
        public async Task<IActionResult> Register(UserRegister userRegister)
        {
            if (ModelState.IsValid)
            {
                var validate = await _context.Cuidador.Where(l => l.Email == userRegister.Email).FirstOrDefaultAsync();
                if (validate == null)
                {
                    userRegister.Password = BCrypt.Net.BCrypt.HashPassword(userRegister.Password);
                    var result = await _context.Cuidador.AddAsync(new Cuidador() { Email = userRegister.Email, Nombre = userRegister.Nombre, Password = userRegister.Password });
                    await _context.SaveChangesAsync();
                    return Ok(Resources.AuthController.registerSuccessful);
                }
                else
                {
                    return BadRequest(Resources.AuthController.alreadyRegistered);
                }
            }
            else
            {
                return BadRequest(ModelState);
            }
        }
        [HttpPost("login")]
        public async Task<IActionResult> Login(UserLogin UserLogin)
        {
            if (ModelState.IsValid)
            {
                var User = await _context.Cuidador.Where(l => l.Email == UserLogin.Email).FirstOrDefaultAsync();
                if (User != null)
                {
                    if (BCrypt.Net.BCrypt.Verify(UserLogin.Password, User.Password))
                    {
                        var plant = await _context.Planta.Where(l => l.Id == User.PlantId).FirstOrDefaultAsync();
                        var maxFechaReporte = await _context.ReporteDiario
                            .Where(l => l.UserId == User.Email)
                            .MaxAsync(l => (DateTime?)l.fecha_reporte);
                        var lastReporteDiario = await _context.ReporteDiario
                            .Where(l => l.UserId == User.Email && l.fecha_reporte == maxFechaReporte)
                            .Select(l => new { l.fecha_reporte, l.estado_reporte })
                            .FirstOrDefaultAsync();
                        var haveStressTest = await _context.Test.Where(l => l.UserId == User.Email).AnyAsync();
                        return Ok(new { token = CreateToken(User), User, Plant = plant, ReporteDiario = lastReporteDiario, haveStressTest });

                    }
                    else
                    {
                        return BadRequest(Resources.AuthController.errorLogin);
                    }
                }
                else
                {
                    return BadRequest(Resources.AuthController.errorLogin);
                }
            }
            else
            {
                return BadRequest(ModelState);
            }

        }
        [HttpGet("ValidateToken")]
        [Authorize]
        public async Task<Object> ValidateToken()
        {
            var currentUser = HttpContext.User;
            Cuidador user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            return new { firstLogin = user.First_login, firstStressLevelTest = !await _context.Test.Where(l => l.UserId == user.Email).AnyAsync() };
        }
        private string CreateToken(Cuidador user)
        {
            List<Claim> claims = new List<Claim> {
                new Claim(ClaimTypes.Name, user.Email),
                new Claim(ClaimTypes.Role, "User"),
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(
                _configuration.GetSection("AppSettings:Token").Value!));

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);

            var token = new JwtSecurityToken(
                    claims: claims,
                    expires: DateTime.Now.AddDays(1),
                    signingCredentials: creds
                );

            var jwt = new JwtSecurityTokenHandler().WriteToken(token);

            return jwt;
        }

    }
}
