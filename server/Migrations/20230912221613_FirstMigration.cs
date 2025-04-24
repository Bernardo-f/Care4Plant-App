using System;
using System.Collections.Generic;
using System.Text.Json;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Care4Plant_Api.Migrations
{
    /// <inheritdoc />
    public partial class FirstMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Accesorio",
                columns: table => new
                {
                    id_accesorio = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    imagen_accesorio = table.Column<string>(type: "text", nullable: false),
                    peso_accesorio = table.Column<int>(type: "integer", nullable: false),
                    accion_accesorio = table.Column<JsonDocument>(type: "jsonb", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Accesorio", x => x.id_accesorio);
                });

            migrationBuilder.CreateTable(
                name: "AjusteRecomendacion",
                columns: table => new
                {
                    nivel_estres = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    nro_categorias = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AjusteRecomendacion", x => x.nivel_estres);
                });

            migrationBuilder.CreateTable(
                name: "Categoria",
                columns: table => new
                {
                    id_categoria = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    nombre_categoria = table.Column<JsonDocument>(type: "jsonb", nullable: false),
                    imagen_categoria = table.Column<string>(type: "text", nullable: false),
                    icono_categoria = table.Column<string>(type: "text", nullable: false),
                    descripcion_categoria = table.Column<JsonDocument>(type: "jsonb", nullable: false),
                    estres_categoria = table.Column<List<int>>(type: "integer[]", nullable: false),
                    layout_categoria = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Categoria", x => x.id_categoria);
                });

            migrationBuilder.CreateTable(
                name: "Planta",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    img_level_1 = table.Column<string>(type: "text", nullable: false),
                    img_level_2 = table.Column<string>(type: "text", nullable: false),
                    img_level_3 = table.Column<string>(type: "text", nullable: false),
                    img_level_4 = table.Column<string>(type: "text", nullable: false),
                    img_level_5 = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Planta", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Actividad",
                columns: table => new
                {
                    id_actividad = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    nombre_actividad = table.Column<JsonDocument>(type: "jsonb", nullable: false),
                    imagen_actividad = table.Column<string>(type: "text", nullable: false),
                    descripcion_actividad = table.Column<JsonDocument>(type: "jsonb", nullable: false),
                    contenido_actividad = table.Column<JsonDocument>(type: "jsonb", nullable: false),
                    tiempo_actividad = table.Column<TimeOnly>(type: "time without time zone", nullable: false),
                    id_categoria = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Actividad", x => x.id_actividad);
                    table.ForeignKey(
                        name: "FK_Actividad_Categoria_id_categoria",
                        column: x => x.id_categoria,
                        principalTable: "Categoria",
                        principalColumn: "id_categoria",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Otorga",
                columns: table => new
                {
                    id_categoria = table.Column<int>(type: "integer", nullable: false),
                    id_accesorio = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Otorga", x => new { x.id_accesorio, x.id_categoria });
                    table.ForeignKey(
                        name: "FK_Otorga_Accesorio_id_accesorio",
                        column: x => x.id_accesorio,
                        principalTable: "Accesorio",
                        principalColumn: "id_accesorio",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Otorga_Categoria_id_categoria",
                        column: x => x.id_categoria,
                        principalTable: "Categoria",
                        principalColumn: "id_categoria",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Cuidador",
                columns: table => new
                {
                    Email = table.Column<string>(type: "text", nullable: false),
                    Nombre = table.Column<string>(type: "text", nullable: false),
                    Password = table.Column<string>(type: "text", nullable: false),
                    PlantId = table.Column<int>(type: "integer", nullable: true),
                    First_login = table.Column<bool>(type: "boolean", nullable: false),
                    Nivel_estres = table.Column<int>(type: "integer", nullable: true),
                    Frecuencia_test = table.Column<int>(type: "integer", nullable: true),
                    Semana_frecuencia_test = table.Column<int>(type: "integer", nullable: true),
                    Notificacion_test = table.Column<bool>(type: "boolean", nullable: true),
                    Notificacion_actividades = table.Column<bool>(type: "boolean", nullable: true),
                    Acceso_invernadero = table.Column<bool>(type: "boolean", nullable: true),
                    Idioma = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cuidador", x => x.Email);
                    table.ForeignKey(
                        name: "FK_Cuidador_Planta_PlantId",
                        column: x => x.PlantId,
                        principalTable: "Planta",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Ingresa",
                columns: table => new
                {
                    email_ingresa = table.Column<string>(type: "text", nullable: false),
                    id_actividad = table.Column<int>(type: "integer", nullable: false),
                    fecha_ingreso = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    finalizada = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ingresa", x => new { x.email_ingresa, x.id_actividad, x.fecha_ingreso });
                    table.ForeignKey(
                        name: "FK_Ingresa_Actividad_id_actividad",
                        column: x => x.id_actividad,
                        principalTable: "Actividad",
                        principalColumn: "id_actividad",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Ingresa_Cuidador_email_ingresa",
                        column: x => x.email_ingresa,
                        principalTable: "Cuidador",
                        principalColumn: "Email",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Pensamiento",
                columns: table => new
                {
                    email_emisor = table.Column<string>(type: "text", nullable: false),
                    fecha_pensamiento = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    contenido_pensamiento = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Pensamiento", x => new { x.fecha_pensamiento, x.email_emisor });
                    table.ForeignKey(
                        name: "FK_Pensamiento_Cuidador_email_emisor",
                        column: x => x.email_emisor,
                        principalTable: "Cuidador",
                        principalColumn: "Email",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Posee",
                columns: table => new
                {
                    UsersEmail = table.Column<string>(type: "text", nullable: false),
                    Accesoriosid_accesorio = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.ForeignKey(
                        name: "FK_Posee_Accesorio_Accesoriosid_accesorio",
                        column: x => x.Accesoriosid_accesorio,
                        principalTable: "Accesorio",
                        principalColumn: "id_accesorio",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Posee_Cuidador_UsersEmail",
                        column: x => x.UsersEmail,
                        principalTable: "Cuidador",
                        principalColumn: "Email",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Recomendacion",
                columns: table => new
                {
                    email_recom = table.Column<string>(type: "text", nullable: false),
                    fecha_recom = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    accesorio_entregado = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Recomendacion", x => new { x.fecha_recom, x.email_recom });
                    table.ForeignKey(
                        name: "FK_Recomendacion_Cuidador_email_recom",
                        column: x => x.email_recom,
                        principalTable: "Cuidador",
                        principalColumn: "Email",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ReporteDiario",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "text", nullable: false),
                    fecha_reporte = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    estado_reporte = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ReporteDiario", x => new { x.UserId, x.fecha_reporte });
                    table.ForeignKey(
                        name: "FK_ReporteDiario_Cuidador_UserId",
                        column: x => x.UserId,
                        principalTable: "Cuidador",
                        principalColumn: "Email",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Test",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "text", nullable: false),
                    Fecha_test = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Answer_1 = table.Column<int>(type: "integer", nullable: false),
                    Answer_2 = table.Column<int>(type: "integer", nullable: false),
                    Answer_3 = table.Column<int>(type: "integer", nullable: false),
                    Answer_4 = table.Column<int>(type: "integer", nullable: false),
                    Answer_5 = table.Column<int>(type: "integer", nullable: false),
                    Answer_6 = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Test", x => new { x.UserId, x.Fecha_test });
                    table.ForeignKey(
                        name: "FK_Test_Cuidador_UserId",
                        column: x => x.UserId,
                        principalTable: "Cuidador",
                        principalColumn: "Email",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Visita",
                columns: table => new
                {
                    email_visita = table.Column<string>(type: "text", nullable: false),
                    fecha_visita = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    id_categoria = table.Column<int>(type: "integer", nullable: false),
                    tiempo_visita = table.Column<TimeOnly>(type: "time without time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Visita", x => new { x.fecha_visita, x.email_visita });
                    table.ForeignKey(
                        name: "FK_Visita_Categoria_id_categoria",
                        column: x => x.id_categoria,
                        principalTable: "Categoria",
                        principalColumn: "id_categoria",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Visita_Cuidador_email_visita",
                        column: x => x.email_visita,
                        principalTable: "Cuidador",
                        principalColumn: "Email",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Me_Gusta",
                columns: table => new
                {
                    email_emisor = table.Column<string>(type: "text", nullable: false),
                    fecha_pensamiento = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    email_megusta = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Me_Gusta", x => new { x.email_emisor, x.fecha_pensamiento, x.email_megusta });
                    table.ForeignKey(
                        name: "FK_Me_Gusta_Cuidador_email_megusta",
                        column: x => x.email_megusta,
                        principalTable: "Cuidador",
                        principalColumn: "Email",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Me_Gusta_Pensamiento_fecha_pensamiento_email_emisor",
                        columns: x => new { x.fecha_pensamiento, x.email_emisor },
                        principalTable: "Pensamiento",
                        principalColumns: new[] { "fecha_pensamiento", "email_emisor" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Ofrece",
                columns: table => new
                {
                    fecha_recom = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    email_recom = table.Column<string>(type: "text", nullable: false),
                    id_categoria = table.Column<int>(type: "integer", nullable: false),
                    recom_realizada = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ofrece", x => new { x.fecha_recom, x.email_recom, x.id_categoria });
                    table.ForeignKey(
                        name: "FK_Ofrece_Categoria_id_categoria",
                        column: x => x.id_categoria,
                        principalTable: "Categoria",
                        principalColumn: "id_categoria",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Ofrece_Recomendacion_fecha_recom_email_recom",
                        columns: x => new { x.fecha_recom, x.email_recom },
                        principalTable: "Recomendacion",
                        principalColumns: new[] { "fecha_recom", "email_recom" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Actividad_id_categoria",
                table: "Actividad",
                column: "id_categoria");

            migrationBuilder.CreateIndex(
                name: "IX_Cuidador_PlantId",
                table: "Cuidador",
                column: "PlantId");

            migrationBuilder.CreateIndex(
                name: "IX_Ingresa_id_actividad",
                table: "Ingresa",
                column: "id_actividad");

            migrationBuilder.CreateIndex(
                name: "IX_Me_Gusta_email_megusta",
                table: "Me_Gusta",
                column: "email_megusta");

            migrationBuilder.CreateIndex(
                name: "IX_Me_Gusta_fecha_pensamiento_email_emisor",
                table: "Me_Gusta",
                columns: new[] { "fecha_pensamiento", "email_emisor" });

            migrationBuilder.CreateIndex(
                name: "IX_Ofrece_id_categoria",
                table: "Ofrece",
                column: "id_categoria");

            migrationBuilder.CreateIndex(
                name: "IX_Otorga_id_categoria",
                table: "Otorga",
                column: "id_categoria");

            migrationBuilder.CreateIndex(
                name: "IX_Pensamiento_email_emisor",
                table: "Pensamiento",
                column: "email_emisor");

            migrationBuilder.CreateIndex(
                name: "IX_Posee_Accesoriosid_accesorio",
                table: "Posee",
                column: "Accesoriosid_accesorio");

            migrationBuilder.CreateIndex(
                name: "IX_Posee_UsersEmail",
                table: "Posee",
                column: "UsersEmail");

            migrationBuilder.CreateIndex(
                name: "IX_Recomendacion_email_recom",
                table: "Recomendacion",
                column: "email_recom");

            migrationBuilder.CreateIndex(
                name: "IX_Visita_email_visita",
                table: "Visita",
                column: "email_visita");

            migrationBuilder.CreateIndex(
                name: "IX_Visita_id_categoria",
                table: "Visita",
                column: "id_categoria");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AjusteRecomendacion");

            migrationBuilder.DropTable(
                name: "Ingresa");

            migrationBuilder.DropTable(
                name: "Me_Gusta");

            migrationBuilder.DropTable(
                name: "Ofrece");

            migrationBuilder.DropTable(
                name: "Otorga");

            migrationBuilder.DropTable(
                name: "Posee");

            migrationBuilder.DropTable(
                name: "ReporteDiario");

            migrationBuilder.DropTable(
                name: "Test");

            migrationBuilder.DropTable(
                name: "Visita");

            migrationBuilder.DropTable(
                name: "Actividad");

            migrationBuilder.DropTable(
                name: "Pensamiento");

            migrationBuilder.DropTable(
                name: "Recomendacion");

            migrationBuilder.DropTable(
                name: "Accesorio");

            migrationBuilder.DropTable(
                name: "Categoria");

            migrationBuilder.DropTable(
                name: "Cuidador");

            migrationBuilder.DropTable(
                name: "Planta");
        }
    }
}
