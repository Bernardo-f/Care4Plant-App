using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using System.ComponentModel.DataAnnotations;

namespace Care4Plant_Api.Models
{
    public class Cuidador
    {
        [Key]
        [Required(ErrorMessage ="Email required")]
        public string Email { get; set; }
        [Required(ErrorMessage ="Name required")]
        public string Nombre { get; set; }
        [Required(ErrorMessage ="Password required")]
        public string Password { get; set; }
        public Planta? Plant { get; set; }
        public int? PlantId { get; set; }
        public bool First_login { get; set; } = true;
        public int? Nivel_estres { get; set; } 
        public int? Frecuencia_test { get;set; }
        public int? Semana_frecuencia_test { get; set; }
        public bool? Notificacion_test { get; set; }
        public bool? Notificacion_actividades { get; set; }
        public bool? Acceso_invernadero { get; set; }
        public string? Idioma { get; set; }
        public List<Test> StressTests { get; set;}
        public List<ReporteDiario> ReportesDiarios { get; set; }
        public List<Visita> Visitas { get; set; }
        public List<Recomendacion> Recomendaciones { get; set; }    
        public List<Accesorio> Accesorios { get; set; }
        public List<Ingresa> IngresoActividades { get; set; }   
        public List<Pensamiento> Pensamientos { get; set; }
        public List<MeGusta> LeGusta { get; set; }
    }
}
