using Care4Plant_Api.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Care4Plant_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReporteDiarioController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        public ReporteDiarioController(ApplicationDbContext context)
        {
            _context = context;
        }
        [HttpPost("Add")]
        [Authorize]
        public async Task<IActionResult> Add(ReporteDiario reporteDiario)
        {
            var currentUser = HttpContext.User;
            Cuidador? user = await _context.Cuidador.Where(l => l.Email == currentUser.Identity.Name).FirstOrDefaultAsync();
            if (user == null)
            {
                return BadRequest();
            }
            reporteDiario.UserId = user.Email;
            await _context.ReporteDiario.AddAsync(reporteDiario);
            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
