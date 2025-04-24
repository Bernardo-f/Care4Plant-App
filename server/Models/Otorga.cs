namespace Care4Plant_Api.Models
{
    public class Otorga
    {
        public int id_categoria { get; set;  }
        public Categoria categoria { get; set; }
        public int id_accesorio { get; set; }   
        public Accesorio accesorio { get; set; }
    }
}
