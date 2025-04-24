namespace Care4Plant_Api.Models
{
    public class Ofrece
    {
        public DateTime fecha_recom { get; set; }
        public string email_recom { get; set; }
        public Recomendacion Recomendacion { get; set;}
        public int id_categoria { get; set; }
        public Categoria categoria { get; set;}
        public bool recom_realizada { get; set; } = false;
    }
}
