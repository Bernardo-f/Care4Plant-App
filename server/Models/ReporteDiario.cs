using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;

namespace Care4Plant_Api.Models
{
    public class ReporteDiario
    {
        [ValidateNever] // Se obtiene a traves del token de autenticación
        public string UserId { get; set; }
        [ValidateNever] // Para indicar a .Net que este modelo esta relacionado con el usuario
        public Cuidador User { get; set; }
        public DateTime fecha_reporte { get; set; } //Fecha del dispositivo en que se hizo el reporte 
        public int estado_reporte { get; set; } //Estado del reporte va de 1 a 5 (1 muy bueno, 5 muy malo)
    }
}
