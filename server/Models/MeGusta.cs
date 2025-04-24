using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using System.Text.Json.Serialization;

namespace Care4Plant_Api.Models
{
    public class MeGusta
    {
        public string email_emisor { get; set; }
        public DateTime fecha_pensamiento { get; set; }
        [ValidateNever]
        [JsonIgnore]
        public Pensamiento pensamiento { get; set; }
        [ValidateNever]
        [JsonIgnore]
        public string email_megusta { get; set; }
        [ValidateNever]
        [JsonIgnore]
        public Cuidador userMeGusta { get; set; }
    }
}
