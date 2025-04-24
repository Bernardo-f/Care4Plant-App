using System.ComponentModel.DataAnnotations;

namespace Care4Plant_Api.Models
{
    public class UserLogin
    {
        [Required(ErrorMessage = "Email required")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Password required")]
        public string Password { get; set; }    
    }
}
