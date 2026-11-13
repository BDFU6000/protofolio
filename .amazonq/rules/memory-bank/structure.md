# Project Structure

## Directory Layout

```
my_protofolio/
├── lib/                        # All Dart/Flutter application code
│   ├── main.dart               # App entry point; MaterialApp setup, theme & locale wiring
│   ├── portfolio_screen.dart   # Root screen; scroll controller, section keys, nav, drawer
│   ├── data/
│   │   └── portfolio_data.dart # Single source of truth for all content (projects, skills, nav items, etc.)
│   ├── models/
│   │   ├── project_model.dart  # ProjectModel, ProjectDetailSection, ProjectTechStackItem, etc.
│   │   ├── experience_model.dart
│   │   └── skill_model.dart
│   ├── screens/
│   │   └── project_details_screen.dart  # Full-page project case study view
│   ├── utils/
│   │   ├── theme_provider.dart    # ValueNotifier<ThemeMode> singleton
│   │   ├── locale_provider.dart   # ValueNotifier<bool> isArabic singleton
│   │   ├── responsive_helper.dart # BuildContext extension (isMobile, isTablet, isDesktop)
│   │   └── cv_generator.dart      # PDF CV generation logic
│   └── widgets/
│       ├── nav_bar.dart
│       ├── hero_section.dart
│       ├── hero_reference_section.dart
│       ├── projects_section.dart
│       ├── about_section.dart
│       ├── experience_section.dart
│       ├── services_section.dart
│       ├── skills_section.dart
│       └── contact_section.dart
├── assets/
│   ├── fonts/                  # Cairo (Regular + Bold) for Arabic; Inter via google_fonts
│   └── images/                 # Profile photos, tech logos, project screenshots, QR code
├── test/                       # Widget and unit tests
├── web/                        # Flutter web entry (index.html, manifest, icons)
├── android/ ios/ macos/ linux/ windows/  # Platform runners (standard Flutter scaffolding)
├── pubspec.yaml                # Dependencies and asset declarations
└── analysis_options.yaml       # Lint rules (flutter_lints)
```

## Core Components and Relationships

```
main.dart
  └── MyPortfolioApp
        ├── ValueListenableBuilder (ThemeProvider.mode)
        │     └── ValueListenableBuilder (LocaleProvider.isArabic)
        │           └── MaterialApp → PortfolioScreen
        └── PortfolioScreen
              ├── NavBar (sticky, scroll-aware)
              ├── Drawer (mobile nav + language toggle)
              └── SingleChildScrollView
                    ├── HeroReferenceSection (section 0 + 1)
                    ├── ProjectsSection       (section 2)
                    ├── AboutSection          (section 3)
                    ├── ExperienceSection     (section 4)
                    ├── ServicesSection       (section 5)
                    └── ContactSection        (section 6)
```

## Architectural Patterns

- **Single-page scroll with GlobalKey anchors**: Each section is wrapped in a `Container` with a `GlobalKey`; `Scrollable.ensureVisible` drives navigation.
- **ValueNotifier state management**: `ThemeProvider` and `LocaleProvider` expose `ValueNotifier` singletons; UI rebuilds via `ValueListenableBuilder` — no external state package needed.
- **Static data layer**: All portfolio content lives in `PortfolioData` (a static class in `data/portfolio_data.dart`), keeping widgets purely presentational.
- **Responsive via BuildContext extension**: `responsive_helper.dart` adds `isMobile`, `isTablet`, `isDesktop` getters directly on `BuildContext`.
- **Bilingual / RTL**: `Directionality` wraps the entire app and is toggled by `LocaleProvider.isArabic`; font family switches between Cairo (Arabic) and Inter (English) via `google_fonts`.
- **Constrained layout**: Content columns are wrapped in `ConstrainedBox(maxWidth: 1280)` for large screens, with dynamic horizontal padding based on breakpoints.
