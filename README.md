# Care4PlantApp

## Description:
Care4Plant is a multilingual mobile application developed to support the emotional well-being of informal caregivers. Unlike existing caregiver apps that focus primarily on patient-related tasks, Care4Plant centers entirely on the caregiver. It uses a virtual plant metaphor to represent users' stress levels and emotional states. The application encourages self-care through mood tracking, guided activities, and community interaction, and is currently available in Spanish, English, and Welsh. A two-week preliminary study involving nine users indicated high usability and user engagement, particularly through the plant-based metaphor and personalized well-being recommendations.

## Main Features

- **Multilingual Interface**: Available in English, Spanish, and Welsh.

- **Virtual Plant**: Represents the caregiver’s emotional state and evolves based on user interaction.

<div align="center">
  <img src="screenshots/MyPlant-EN-1.png" alt="MyPlant" width="250"/>
</div>

- **Stress Level Test**: Short test based on the Zarit Burden Interview (ZBI) to assess caregiver stress.

<div align="center">
  <img src="screenshots/StreesTest-CY-2.png" alt="Stress Test" width="250"/>
</div>

- **Care Center**: Offers relaxing activities and guided content (e.g., music, mindful texts).

<div align="center">
  <img src="screenshots/CareCenter-ES-1.png" alt="Care Center ES" width="250"/>
  <img src="screenshots/CareCenter-EN-5.png" alt="Care Center EN" width="250"/>
</div>

- **Greenhouse (Community)**: Optional space to anonymously share reflections with other users.

<div align="center">
  <img src="screenshots/Greenhouse-EN-1.png" alt="Greenhouse EN" width="250"/>
  <img src="screenshots/Greenhouse-CY-2.png" alt="Greenhouse CY" width="250"/>
</div>



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

Care4Plant adopts a **Clean Architecture** approach, organized by layers: `data`, `domain`, and `ui`. This structure promotes modularity, testability, and separation of concerns.


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
## Technical Implementation Details

The mobile application has been developed using Flutter, a cross-platform framework based on the Dart programming language. The source code is structured following a layered architecture, distributed mainly across three folders: ui, domain, and data.

* The ui folder contains all elements related to the visual presentation of the application, including views, reusable components, and navigation logic.

* The domain folder represents the core business logic. It defines entities, repository interfaces, and use cases that encapsulate the specific logic for each functionality.
 
* The data folder implements data access mechanisms, whether from local sources (e.g., device storage) or remote sources (such as RESTful APIs).

Complementing these layers, the project includes a core folder that groups reusable cross-cutting services throughout the application. These services include notification handling, local storage, user authentication, and server connectivity.
Among the most relevant dependencies used in the project are:

* flutter_localizations: for multilingual support.

* flutter_svg: for displaying vector graphics in SVG format.

* get_it: for implementing the dependency injection pattern.

Some key files within the source code include:

* injection_container.dart, which centralizes the configuration and initialization of application dependencies;

* .env.dart.example, which provides an example file with configuration parameters such as server URL and notification options.

The application entry point is located in the main.dart file, where essential services such as localization configuration, storage, and authentication are initialized. From this initialization, the user's session state is evaluated to determine whether the authentication screen should be presented or navigate directly to MyPlant in the application.

---

## Build Instructions:

### Frontend (Flutter)


```bash
# Clone the repository from GitHub
git clone https://github.com/Bernardo-f/Care4Plant-App.git

# Navigate to the backend folder to run the API (required for app functionality)
cd server
dotnet run  # Starts the ASP.NET Core backend API

# Go to the Flutter app directory
cd Care4Plant-App/app

# Install Flutter dependencies
flutter pub get

# Build the Android APK (can be installed on any Android device)
flutter build apk
```

### Backend (.NET)

```bash
# Clone the repository
git clone https://github.com/Bernardo-f/Care4Plant-App.git
cd server

# Restore dependencies
dotnet restore

# (Optional) Create a local configuration file if needed
# e.g., appsettings.Development.json with your PostgreSQL connection string

# Apply existing EF Core migrations to create or update the database
dotnet ef database update

# Run the backend API
dotnet run

