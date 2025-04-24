using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using System.Text.Json.Serialization;

namespace Care4Plant_Api.Models
{
    public class Ingresa
    {
        [ValidateNever]
        [JsonIgnore]
        public string email_ingresa { get; set; }
        [ValidateNever]
        [JsonIgnore]
        public Cuidador User { get; set; }
        public int id_actividad { get;set; }
        [ValidateNever]
        [JsonIgnore]
        public Actividad Actividad { get; set; }
        public DateTime fecha_ingreso { get; set; } 
        public bool finalizada { get; set;  }
    }
}
