# Alphabet Launcher — Flutter

A minimal, high-performance Android home screen built with **Flutter**, featuring a vertical A-Z alphabet sidebar that smoothly bends towards the user's finger during touch drag interactions.

Built following strict **Clean Architecture** principles, **BLoC state management**, and **Dependency Injection with GetIt**.

---

## Features

### Core Requirements
* **Live Home Screen**: Displays current time and date alongside a quick-access favorites app list.
* **A-Z Alphabet Sidebar**: Vertical column pinned to the right edge with a custom curving bulge animation tracking touch drag in real-time.
* **Package Visibility & Querying**: Reads launchable device apps (name + icon) using `installed_apps` with Android 11+ `QUERY_ALL_PACKAGES` permission support.
* **Curved Animation**: Written with `CustomPainter` and trigonometry math (Cosine deflection) running at a smooth 60/120 fps[cite: 1, 3].
* **Floating Letter Bubble**: Displays an enlarged circular indicator of the currently targeted letter next to the finger[cite: 1, 3].
* **Filtered App List & Empty States**: Instantly filters apps starting with the targeted letter and presents a clear "No apps" indicator when no matches exist[cite: 1, 3].
* **App Launching**: Tap any app in either list to launch its native Android activity[cite: 1, 3].
* **Performance Optimizations**: Pre-groups and caches installed apps in an $O(1)$ lookup map on app launch to eliminate runtime overhead during touch drags[cite: 1, 3].

### Bonus Features
* **Haptic Feedback**: Triggers a micro-vibration tick whenever the targeted letter changes during a drag gesture.
* **Default Launcher Ready**: Configured in `AndroidManifest.xml` with `CATEGORY_HOME` and `CATEGORY_DEFAULT` intent filters to act as a system home launcher replacement[cite: 1, 3].

---

## How the Curve Animation Works

The curve animation is powered by a custom mathematical deflection model rendered inside a Flutter `CustomPainter`.

### Mathematical Deflection Formula
When the user touches the sidebar at vertical coordinate $Y_{\text{touch}}$, the vertical distance $\Delta Y$ to the center of each letter $Y_{\text{letter}}$ is calculated:

$$\Delta Y = \vert{}Y_{\text{touch}} - Y_{\text{letter}}\vert{}$$

If $\Delta Y$ is within the defined radius of influence ($140\text{px}$), a Cosine factor determines the horizontal shift $\Delta X$:

$$\Delta X = -\text{MaxOffset} \times \cos\left(\frac{\Delta Y}{\text{Radius}} \times \frac{\pi}{2}\right)$$

* **At the finger ($\Delta Y = 0$)**: $\cos(0) = 1.0 \implies \Delta X = -\text{MaxOffset}$ (Maximum leftward bulge)[cite: 1, 3].
* **At boundary ($\Delta Y = \text{Radius}$)**: $\cos(\pi/2) = 0.0 \implies \Delta X = 0$ (Zero deflection)[cite: 1, 3].

When the finger is lifted, touch coordinates reset to `null`, causing the sidebar to spring back to its straight resting column[cite: 1, 3].

---

## Architecture Overview

This project follows **Clean Architecture** (Domain, Data, Presentation) combined with **BLoC** and **GetIt**:

```text
lib/
├── core/
│   ├── constants/       # Global app colors & theme specs
│   ├── di/              # GetIt service locator setup
│   └── utils/          # Pure math (CurveMath) & Haptics helpers
├── domain/              # Pure business logic layer (No Flutter/Data dependencies)
│   ├── entities/        # AppEntity
│   ├── repositories/    # AppRepository interface contract
│   └── usecases/        # GetInstalledAppsUseCase, LaunchAppUseCase
├── data/                # Data & Infrastructure layer
│   ├── datasources/     # AppLocalDataSource (installed_apps plugin)
│   ├── models/          # AppModel
│   └── repositories/    # AppRepositoryImpl (A-Z grouping & caching)
└── presentation/        # UI layer
    ├── bloc/            # LauncherBloc, LauncherEvent, LauncherState
    ├── components/      # AlphabetCurvePainter, AlphabetSidebar, LetterBubble
    └── views/           # LauncherHomeScreen, HomeContentView, FilteredAppsView
