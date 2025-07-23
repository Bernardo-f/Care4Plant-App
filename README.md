# Care4PlantApp

## Description:
Care4Plant is a multilingual mobile application developed to support the emotional well-being of informal caregivers. Unlike existing caregiver apps that focus primarily on patient-related tasks, Care4Plant centers entirely on the caregiver. It uses a virtual plant metaphor to represent users' stress levels and emotional states. The application encourages self-care through mood tracking, guided activities, and community interaction, and is currently available in Spanish, English, and Welsh. A two-week preliminary study involving nine users indicated high usability and user engagement, particularly through the plant-based metaphor and personalized well-being recommendations.

## Main Features

-  **Virtual Plant**: Represents the caregiver’s emotional state and evolves based on user interaction.
-  **Stress Level Test**: Short test based on the Zarit Burden Interview (ZBI) to assess caregiver stress.
-  **Care Center**: Offers relaxing activities and guided content (e.g., music, mindful texts).
-  **Multilingual Interface**: Available in English, Spanish, and Welsh.
-  **User-Centered Interface**: Designed for simplicity and accessibility.
-  **Greenhouse (Community)**: Optional space to anonymously share reflections with other users.



---
## *Care4PlantApp* is composed of:

- *Frontend*: Mobile application developed in Flutter.
- *Backend*: RESTful API developed in ASP.NET Core, responsible for managing authentication, users, and activities.

## Technologies:

| Tool / Language | Purpose |
|-----------------|---------|
| Dart 3.0.0 | Cross-platform mobile logic |
| Flutter 3.10.0 | UI framework for Android/iOS |
| .NET 7 / C# 11 | Backend services |
| PostgreSQL 15 | Database |
| Entity Framework Core | ORM |
| Android Studio | Emulator + Android builds |
| Visual Studio 2022 | Backend development |

## Mobile App Architecture

Care4Plant adopts a **Clean Architecture** approach, organized by layers: `core`, `data`, `domain`, and `presentation`. This structure promotes modularity, testability, and separation of concerns.


``` text

lib/
├── core/ # Shared utilities, constants, and environment
├── data/ # Data sources and repositories (API, persistence)
│ ├── models/ # DTOs and backend-facing entities
│ ├── repositories/ # Implementations of domain repositories
│ └── source/ # API services, database access
├── domain/ # Core business logic (pure Dart)
│ ├── entities/ # Domain entities (e.g. Plant, StressTest)
│ ├── repositories/ # Abstract contracts
│ └── usecases/ # Application use cases
├── l10n/ # Localization files (.arb for en, es, cy)
├── ui/ # User interface (screens, widgets)
│ ├── models/ # View models or UI-bound models
│ ├── provider/ # State management (Provider, Riverpod, etc.)
│ └── views/ # Screens and widgets
├── injection_container.dart # Service locator / dependency injection
├── env.dart # Environment configuration
└── main.dart # Application entry point

```

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

