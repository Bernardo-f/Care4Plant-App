namespace Care4Plant_Api.Models
{
    public class BasicSettings
    {
        public int? PlantId { get; set; }
        public bool FirstLogin { get; set; } 
        public int? Frecuencia_test { get; set; }
        public int? Semana_Frecuencia_test { get; set; }
        public bool? Notificacion_test { get; set; }
        public bool? Notificacion_actividades { get; set; }
        public bool? Acceso_invernadero { get; set; }
        public string Idioma { get; set; }  
    }
}
