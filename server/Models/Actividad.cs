using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text.Json;

namespace Care4Plant_Api.Models
{
    public class Actividad
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id_actividad {  get; set; }  
        public JsonDocument nombre_actividad { get; set; }
        public string imagen_actividad { get; set; }
        public JsonDocument descripcion_actividad { get; set; } 
        public JsonDocument contenido_actividad { get; set; }
        public TimeOnly tiempo_actividad { get; set; }
        public int id_categoria { get; set; }   
        public Categoria Categoria { get; set; }
        public List<Ingresa> Ingresos { get; set; }
    }
}
