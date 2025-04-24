using Microsoft.EntityFrameworkCore;

namespace Care4Plant_Api.Models
{
    [Keyless]
    public class Posee
    {
        public string UsersEmail { get; set; }
        public int Accesoriosid_accesorio { get; set; }   
    }
}
