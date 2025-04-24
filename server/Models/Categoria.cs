using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json;

namespace Care4Plant_Api.Models
{
    public class Categoria
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)] // Para indicar que es autoincremental
        public int id_categoria { get; set; } 
        public JsonDocument nombre_categoria { get; set; } //Contiene el nombre de la categoria en los idiomas disponibles
        public string imagen_categoria { get; set; } // indica la ruta en el servidor de la imagen de la categoria
        public string icono_categoria { get; set; } // indica la ruta en el servidor del icono de la categoria, este se utiliza para desplegarlo en la ruta de actividades recomendadas.
        public JsonDocument descripcion_categoria { get; set; } // Contiene la descripcion de la categoria en los idiomas disponibles
        public List<int> estres_categoria { get; set; } // Indica para que niveles de estres se recomienda esta actividad
        public int layout_categoria { get;set; } //Indica que layout se utiliza para agregar las categorias
        public List<Actividad> actividades { get; set; }
        public List<Visita> Visitas { get; set; }
        public List<Ofrece> Ofrece { get; set; }
        public List<Otorga> Otorga { get; set; }
    }
}
