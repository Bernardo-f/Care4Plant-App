using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;

namespace Care4Plant_Api.Models
{
    public class Recomendacion
    {
        public string email_recom { get; set; }
        public Cuidador User { get; set; }
        public DateTime fecha_recom { get; set; }
        public bool accesorio_entregado { get; set; } = false;
        public List<Ofrece> Ofrece { get; set; }
    }
}
