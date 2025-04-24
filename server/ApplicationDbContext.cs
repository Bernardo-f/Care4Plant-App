using Care4Plant_Api.Models;
using Microsoft.EntityFrameworkCore;

namespace Care4Plant_Api
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public ApplicationDbContext()
        {
        }
        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<AjusteRecomendacion>().HasKey(l => l.nivel_estres);
            builder.Entity<Test>().HasKey(l => new { l.UserId, l.Fecha_test });
            builder.Entity<ReporteDiario>().HasKey(l => new { l.UserId, l.fecha_reporte });
            builder.Entity<Otorga>().HasKey(l => new { l.id_accesorio, l.id_categoria });
            builder.Entity<Ingresa>().HasKey(l => new { l.email_ingresa, l.id_actividad, l.fecha_ingreso });
            builder.Entity<Pensamiento>().HasKey(l => new { l.fecha_pensamiento, l.email_emisor });
            builder.Entity<MeGusta>().HasKey(l => new { l.email_emisor, l.fecha_pensamiento, l.email_megusta });
            //
            builder.Entity<Actividad>().HasOne(l => l.Categoria).WithMany(l => l.actividades).HasForeignKey(l => l.id_categoria);
            //
            builder.Entity<Visita>().HasKey(l => new { l.fecha_visita, l.email_visita });
            builder.Entity<Visita>().HasOne(l => l.Usuario).WithMany(l => l.Visitas).HasForeignKey(l => l.email_visita);
            builder.Entity<Visita>().HasOne(l => l.categoria).WithMany(l => l.Visitas).HasForeignKey(l => l.id_categoria);
            //
            builder.Entity<Recomendacion>().HasKey(l => new { l.fecha_recom, l.email_recom });
            builder.Entity<Recomendacion>().HasOne(l => l.User).WithMany(l => l.Recomendaciones).HasForeignKey(l => l.email_recom);
            //
            builder.Entity<Ofrece>().HasKey(l => new { l.fecha_recom, l.email_recom, l.id_categoria });
            builder.Entity<Ofrece>().HasOne(l => l.Recomendacion).WithMany(l => l.Ofrece).HasForeignKey(l => new { l.fecha_recom, l.email_recom });
            builder.Entity<Ofrece>().HasOne(l => l.categoria).WithMany(l => l.Ofrece).HasForeignKey(l => l.id_categoria);
            //
            builder.Entity<Cuidador>().HasMany(l => l.Accesorios).WithMany(l => l.Users).UsingEntity<Posee>().HasNoKey();
            builder.Entity<Accesorio>().HasMany(l => l.Users).WithMany(l => l.Accesorios).UsingEntity<Posee>().HasNoKey();
            //
            builder.Entity<Ingresa>().HasOne(l => l.Actividad).WithMany(l => l.Ingresos).HasForeignKey(l => l.id_actividad);
            builder.Entity<Ingresa>().HasOne(l => l.User).WithMany(l => l.IngresoActividades).HasForeignKey(l => l.email_ingresa);
            //    
            builder.Entity<Otorga>().HasOne(l => l.accesorio).WithMany(l => l.Otorga).HasForeignKey(l => l.id_accesorio);
            builder.Entity<Otorga>().HasOne(l => l.categoria).WithMany(l => l.Otorga).HasForeignKey(l => l.id_categoria);
            //
            builder.Entity<Pensamiento>().HasOne(l => l.emisor).WithMany(l => l.Pensamientos).HasForeignKey(l => l.email_emisor);
            //
            builder.Entity<MeGusta>().HasOne(l => l.userMeGusta).WithMany(l => l.LeGusta).HasForeignKey(l => l.email_megusta);
            builder.Entity<MeGusta>().HasOne(l => l.pensamiento).WithMany(l => l.meGustas).HasForeignKey(l => new { l.fecha_pensamiento, l.email_emisor });
            //
            base.OnModelCreating(builder);
        }
        public virtual DbSet<Cuidador> Cuidador { get; set; }
        public virtual DbSet<Planta> Planta { get; set; }
        public virtual DbSet<Test> Test { get; set; }
        public virtual DbSet<ReporteDiario> ReporteDiario { get; set; }
        public virtual DbSet<Categoria> Categoria { get; set; }
        public virtual DbSet<Actividad> Actividad { get; set; }
        public virtual DbSet<Visita> Visita { get; set; }
        public virtual DbSet<Recomendacion> Recomendacion { get; set; }
        public virtual DbSet<Ofrece> Ofrece { get; set; }
        public virtual DbSet<AjusteRecomendacion> AjusteRecomendacion { get; set; }
        public virtual DbSet<Posee> Posee { get; set; }
        public virtual DbSet<Accesorio> Accesorio { get; set; }
        public virtual DbSet<Ingresa> Ingresa { get; set; }
        public virtual DbSet<Otorga> Otorga { get; set; }
        public virtual DbSet<Pensamiento> Pensamiento { get; set; }
        public virtual DbSet<MeGusta> Me_Gusta { get; set; }
    }
}
