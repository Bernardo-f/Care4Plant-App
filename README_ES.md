# Care4PlantApp

## Descripción:

*Care4PlantApp* está compuesta por:

- *Frontend*: Aplicación móvil desarrollada en Flutter.
- *Backend*: API RESTful desarrollada en ASP.NET Core, encargada de gestionar autenticación, usuarios y actividades.

---

## Tecnologías:

- *Frontend*:
  - Flutter v3.10.0
  - Dart SDK v3.0.0

- *Backend*:
  - .NET 7+
  - C# v11
  - Entity Framework Core (EF Core)
  - Base de Datos: PostgresSQL >v15
  - API RESTful
  - Recursos estáticos servidos desde wwwroot/

---

## Compilación:

### Frontend (Flutter)

```bash
git clone https://github.com/tu_usuario/Care4Plant-App.git
cd server
dotnet run # Para ejecutar la API
cd Care4Plant-App/app
flutter pub get
flutter build apk   # Para compilar en Android
```

### Backend (.NET)

```bash
git clone https://github.com/tu_usuario/Care4Plant-App.git
cd server
dotnet run # Para ejecutar la API
