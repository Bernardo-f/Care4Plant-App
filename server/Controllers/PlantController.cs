using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Care4Plant_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlantController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        public PlantController(ApplicationDbContext context, IConfiguration configuration)
        {
            _context = context;
        }
        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAll()
        {
            var categoryList = await _context.Planta.Select(l => new { l.Id, l.img_level_2 }).ToListAsync();
            return Ok(categoryList);
        }
    }
}
