using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text.Json;

namespace Care4Plant_Api.Models
{
    public class Accesorio
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id_accesorio { get; set; }
        public string imagen_accesorio { get; set; }
        public int peso_accesorio { get; set; }
        public JsonDocument accion_accesorio { get; set; }
        public List<Otorga> Otorga { get; set; }
        public List<Cuidador>  Users { get; set; }
    }
}
