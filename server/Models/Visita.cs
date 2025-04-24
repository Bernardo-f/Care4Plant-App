using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;

namespace Care4Plant_Api.Models
{
    public class Visita
    {
        [ValidateNever] // Se obtiene desde el token de autenticación 
        public string email_visita {get;set;}
        [ValidateNever]
        public Cuidador Usuario { get;set;}    
        public int id_categoria { get;set;}
        [ValidateNever]
        public Categoria categoria { get;set;}
        public DateTime fecha_visita { get;set;}    
        public TimeOnly tiempo_visita { get;set;}   
    }
}
