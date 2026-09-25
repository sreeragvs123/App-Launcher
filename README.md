# Alphabet Launcher — Flutter

A minimal, high-performance Android home screen built with **Flutter**, featuring a vertical A-Z alphabet sidebar that smoothly bends towards the user's finger during touch drag interactions.

Built following strict **Clean Architecture** principles, **BLoC** state management, and **Dependency Injection** with **GetIt**.

---

## Features

### Core Requirements

* **Live Home Screen** — Displays current time and date alongside a quick-access favorites app list.
* **A-Z Alphabet Sidebar** — Vertical column pinned to the right edge with a custom curving bulge animation tracking touch drag in real-time.
* **Package Visibility & Querying** — Reads launchable device apps (name + icon) using `installed_apps`, with Android 11+ `QUERY_ALL_PACKAGES` permission support.
* **Curved Animation** — Written with `CustomPainter` and trigonometry math (cosine deflection), running at a smooth 60/120 fps.
* **Floating Letter Bubble** — Displays an enlarged circular indicator of the currently targeted letter next to the finger.
* **Filtered App List & Empty States** — Instantly filters apps starting with the targeted letter, and presents a clear "No apps" indicator when no matches exist.
* **App Launching** — Tap any app in either list to launch its native Android activity.
* **Performance Optimizations** — Pre-groups and caches installed apps in an O(1) lookup map on app launch to eliminate runtime overhead during touch drags.

### Bonus Features

* **Haptic Feedback** — Triggers a micro-vibration tick whenever the targeted letter changes during a drag gesture.
* **Default Launcher Ready** — Configured in `AndroidManifest.xml` with `CATEGORY_HOME` and `CATEGORY_DEFAULT` intent filters to act as a system home launcher replacement.

---

## How the Curve Animation Works

The curve animation is powered by a custom mathematical deflection model rendered inside a Flutter `CustomPainter`.

### Mathematical Deflection Formula

When the user touches the sidebar at vertical coordinate `Y_touch`, the vertical distance `ΔY` to the center of each letter `Y_letter` is calculated:

```
ΔY = |Y_touch - Y_letter|
```

If `ΔY` is within the defined radius of influence (**140px**), a cosine factor determines the horizontal shift `ΔX`:

```
ΔX = -MaxOffset × cos((ΔY / Radius) × π/2)
```

* **At the finger (ΔY = 0):** `cos(0) = 1.0` → `ΔX = -MaxOffset` (maximum leftward bulge)
* **At the boundary (ΔY = Radius):** `cos(π/2) = 0.0` → `ΔX = 0` (zero deflection)

When the finger is lifted, touch coordinates reset to `null`, causing the sidebar to spring back to its straight resting column.

---

## Architecture Overview

This project follows **Clean Architecture** (Domain, Data, Presentation) combined with **BLoC** and **GetIt**:

```text
lib/
├── core/
│   ├── constants/       # Global app colors & theme specs
│   ├── di/              # GetIt service locator setup
│   └── utils/           # Pure math (CurveMath) & Haptics helpers
├── domain/               # Pure business logic layer (no Flutter/Data dependencies)
│   ├── entities/         # AppEntity
│   ├── repositories/     # AppRepository interface contract
│   └── usecases/         # GetInstalledAppsUseCase, LaunchAppUseCase
├── data/                 # Data & infrastructure layer
│   ├── datasources/      # AppLocalDataSource (installed_apps plugin)
│   ├── models/           # AppModel
│   └── repositories/     # AppRepositoryImpl (A-Z grouping & caching)
└── presentation/         # UI layer
    ├── bloc/             # LauncherBloc, LauncherEvent, LauncherState
    ├── components/       # AlphabetCurvePainter, AlphabetSidebar, LetterBubble
    └── views/            # LauncherHomeScreen, HomeContentView, FilteredAppsView
```

---


### Library Details & Justification

| Library | Version | Purpose / Justification |
|---|---|---|
| `flutter_bloc` | ^8.1.3 | Clean state management separating touch gesture logic from UI rendering. |
| `get_it` | ^7.6.0 | Dependency injection service locator for decoupling layer dependencies. |
| `installed_apps` | ^2.0.1 | Native Android package querying and app launching, compatible with AGP 8.0+ and Android 11+ package visibility rules. |
| `vibration` | ^2.0.0 | Cross-platform physical micro-haptic feedback during letter scrolling. |
| `equatable` | ^2.0.5 | Immutable object equality comparison inside BLoC states and domain entities. |

---

## Setup & Installation Instructions

### Prerequisites

* **Flutter SDK:** >=3.0.0
* **Android SDK:** Target API Level 30+ (Android 11 or higher)
* **Java/JDK Version:** JDK 17 (compatible with AGP 8.0+)

### Installation Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/YOUR_USERNAME/launcher.git
   cd launcher
   ```

2. **Install Flutter packages:**

   ```bash
   flutter pub get
   ```

3. **Verify Android setup:**

   Ensure `android/app/src/main/AndroidManifest.xml` includes package query visibility permissions:

   ```xml
   <uses-permission android:name="android.permission.QUERY_ALL_PACKAGES"/>
   ```

4. **Build and run on an Android device:**

   ```bash
   flutter run
   ```

---

## AI Tools & AI Usage

In accordance with transparency requirements:

* **AI Tool Used:** Gemini
* **Purpose:** Assisted in designing the cosine curve deflection math formula, resolving Android Gradle Plugin (AGP 8.0+) namespace compatibility settings in `build.gradle.kts`, and structuring the Clean Architecture layers.
