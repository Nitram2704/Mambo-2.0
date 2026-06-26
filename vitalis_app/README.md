# Vitalis App

Flutter implementation of the **Vitalis** fitness app, rebuilt from a Dark Botanical HTML/JS design system using **Flutter + Material 3 + Google Fonts**.

## Features

- Five tabs: **Inicio · Entrenamiento · Sueño · Alimentación · Social**
- 36+ screens covering dashboard, profile, training flows, sleep tracking, nutrition, social, groups, and events
- Dark Botanical design system (`#0F0F0F` background, gold `#C8A464` accent, Cormorant serif typography)
- Phone-frame container (393 × 852) on desktop; fullscreen on mobile devices
- Animated skeleton loaders, ring progress, toast overlay, custom tab icons

## Stack

- Flutter 3.x (Dart >= 3.2)
- `google_fonts: ^6.1.0` for the Cormorant typeface (no local font files required)

## Project structure

```
vitalis_app/
├── lib/
│   ├── main.dart                  # Entry point
│   ├── app.dart                   # MaterialApp + theme
│   ├── theme/app_theme.dart       # Dark Botanical color tokens + Material 3
│   ├── widgets/
│   │   ├── common_widgets.dart    # AppButton, AppCard, StatCard, RingProgress, etc.
│   │   ├── toast.dart             # Animated toast overlay
│   │   └── phone_frame.dart       # PhoneFrame shell + Nav helper + custom painters
│   └── screens/
│       ├── home/home_screens.dart
│       ├── training/training_screens.dart
│       ├── sleep/sleep_screens.dart
│       ├── nutrition/nutrition_screens.dart
│       └── social/social_screens.dart
├── assets/                        # 19 PNG images from the source design
└── test/widget_test.dart          # Smoke tests
```

## Run it

### 1. Install Flutter (you don't have it yet)

Download and install Flutter 3.22+ from <https://docs.flutter.dev/get-started/install/windows>.

After install, verify:

```powershell
flutter --version
flutter doctor
```

### 2. Get dependencies

```powershell
cd C:\Users\juani\Projects\Mambo-2.0\vitalis_app
flutter pub get
```

### 3. Run on a device or emulator

```powershell
flutter run
```

For an Android emulator, start it first (`flutter emulators --launch <name>`).

For a Windows desktop build:

```powershell
flutter config --enable-windows-desktop
flutter run -d windows
```

For Chrome (web):

```powershell
flutter config --enable-web
flutter run -d chrome
```

> **Note:** The Cormorant typeface is fetched at runtime via `google_fonts`, so the very first launch needs internet access. After the first launch it's cached.

## Verify the build

```powershell
flutter analyze
flutter test
```

## Design source

This Flutter project was rebuilt from:

```
C:\Users\juani\AppData\Roaming\Open Design\namespaces\release-stable-win\data\projects\brand-dark-botanical-eb95ee\
```

Original brand system docs and HTML mockup are there for reference.