# Care4PlantApp

## Description:

*Care4PlantApp* is composed of:

- *Frontend*: Mobile application developed in Flutter.
- *Backend*: RESTful API developed in ASP.NET Core, responsible for managing authentication, users, and activities.

---

## Technologies:

- *Frontend*:
  - Flutter v3.10.0
  - Dart SDK v3.0.0

- *Backend*:
  - .NET 7+
  - C# v11
  - Entity Framework Core (EF Core)
  - Database: PostgreSQL >v15
  - RESTful API
  - Static resources served from wwwroot/

---

## Build Instructions:

### Frontend (Flutter)

```bash
git clone https://github.com/your_user/Care4Plant-App.git
cd server
dotnet run # To run the API
cd Care4Plant-App/app
flutter pub get
flutter build apk   # To build for Android
```

### Backend (.NET)
```bash
git clone https://github.com/tu_usuario/Care4Plant-App.git
cd server
dotnet run # To run the API

