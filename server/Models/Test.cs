using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;

namespace Care4Plant_Api.Models
{
    public class Test
    {
        [ValidateNever]
        public String UserId { get; set; }
        [ValidateNever]
        public Cuidador User { get; set; }
        public DateTime Fecha_test { get; set; }
        public int Answer_1 { get; set; }
        public int Answer_2 { get; set; }
        public int Answer_3 { get; set; }
        public int Answer_4 { get; set; }
        public int Answer_5 { get; set; }
        public int Answer_6 { get; set; }
    }
}
