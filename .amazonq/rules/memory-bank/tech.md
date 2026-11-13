# Technology Stack

## Languages & Runtime
- **Dart** ^3.6.0 (Flutter SDK constraint)
- **Flutter** (multi-platform: Web, Android, iOS, macOS, Linux, Windows)
- **Kotlin** — Android runner (MainActivity.kt)
- **Swift** — iOS/macOS runner (AppDelegate.swift)
- **C++** — Windows/Linux runners (CMake-based)
- **Python** — iOS LLDB helper script (ephemeral tooling only)

## Flutter / Dart Dependencies (`pubspec.yaml`)

| Package | Version | Purpose |
|---|---|---|
| `google_fonts` | ^6.2.1 | Inter (EN) and Cairo (AR) typography |
| `url_launcher` | ^6.3.0 | Open GitHub, LinkedIn, email links |
| `animate_do` | ^3.3.4 | Entrance animations (FadeInUp, etc.) |
| `pdf` | ^3.11.3 | CV PDF document generation |
| `printing` | ^5.14.3 | Print/share/download the generated PDF |
| `cupertino_icons` | ^1.0.8 | iOS-style icon set |

## Dev Dependencies
| Package | Version | Purpose |
|---|---|---|
| `flutter_lints` | ^5.0.0 | Recommended lint rules |
| `image` | ^4.2.0 | Web icon/favicon generation (`tool/gen_web_icons.dart`) |
| `flutter_test` | SDK | Widget and unit testing |

## Custom Assets
- **Fonts**: `assets/fonts/Cairo-Regular.ttf`, `Cairo-Bold.ttf` (weight 700)
- **Images**: `assets/images/` — profile photos, tech logos, project screenshots, QR code, roadmap

## Build & Development Commands

```bash
# Install dependencies
flutter pub get

# Run on Chrome (primary dev target)
flutter run -d chrome

# Run on a connected device
flutter run

# Build for web (production)
flutter build web

# Build for Android APK
flutter build apk

# Run all tests
flutter test

# Regenerate web icons (PWA / favicon)
dart tool/gen_web_icons.dart

# Check for outdated packages
flutter pub outdated

# Upgrade packages
flutter pub upgrade --major-versions
```

## Platform Targets
- **Web** — primary deployment target (index.html + manifest.json in `web/`)
- **Android** — Gradle (Kotlin DSL), minSdk via Flutter defaults
- **iOS** — Xcode workspace, Swift AppDelegate
- **macOS** — Xcode workspace, Swift
- **Linux** — CMake + GTK runner
- **Windows** — CMake + Win32 runner

## Linting
- `analysis_options.yaml` uses `flutter_lints` recommended rule set
- No custom lint overrides noted beyond the package defaults
