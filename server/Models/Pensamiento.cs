using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using System.Text.Json.Serialization;

namespace Care4Plant_Api.Models
{
    public class Pensamiento
    {
        [ValidateNever]
        [JsonIgnore]
        public string email_emisor { get; set; }
        [ValidateNever]
        [JsonIgnore]
        public Cuidador emisor { get; set; }
        public DateTime fecha_pensamiento { get; set; }
        public string contenido_pensamiento { get; set; }
        [JsonIgnore]
        [ValidateNever]
        public List<MeGusta> meGustas { get; set; }
    }
}
