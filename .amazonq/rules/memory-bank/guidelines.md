# Development Guidelines

## Code Quality Standards

### Naming Conventions
- **Classes**: PascalCase — `ProjectModel`, `NavBar`, `ThemeProvider`, `LocaleProvider`
- **Private widget classes**: Prefixed with `_` — `_NavBarState`, `_Logo`, `_NavLink`, `_SectionPill`, `_TechChip`
- **Private fields/methods**: Prefixed with `_` — `_isScrolled`, `_activeIndex`, `_onScroll()`
- **Constants**: lowerCamelCase with `static const` — `static const _aqua = Color(0xFF52D8DE)`
- **Files**: snake_case — `portfolio_data.dart`, `theme_provider.dart`, `responsive_helper.dart`
- **C++ variables**: snake_case — `g_active_window_count`, `window_handle_`, `child_content_`

### Documentation
- Public model fields use `///` doc comments explaining purpose (see `project_model.dart`)
- Inline comments explain non-obvious logic (scroll heuristics, DPI scaling, Win32 registry keys)
- Platform runner files follow Flutter's generated comment style

### Dart/Flutter Formatting
- `const` constructors used wherever possible — `const NavBar(...)`, `const SizedBox(height: 12)`
- `super.key` shorthand used in all widget constructors
- Arrow syntax (`=>`) for single-expression `build` methods in simple widgets
- Trailing commas on all multi-line constructor/function calls for clean `dart format` output

---

## Architectural Patterns

### State Management — ValueNotifier Singletons
No external state package. Global reactive state uses static `ValueNotifier` singletons:

```dart
// Provider pattern
class ThemeProvider {
  ThemeProvider._(); // private constructor
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.dark);
  static void toggle() { mode.value = isDark ? ThemeMode.light : ThemeMode.dark; }
}

// Consumer pattern
ValueListenableBuilder<bool>(
  valueListenable: LocaleProvider.isArabic,
  builder: (context, isArabic, _) { ... },
)
```

### Static Data Layer
All content is centralized in `PortfolioData` (static class). Widgets never hardcode strings:

```dart
PortfolioData.projects      // List<ProjectModel>
PortfolioData.navItems      // List<String>
PortfolioData.name          // String
```

### Section Navigation — GlobalKey Anchors
Sections are identified by `GlobalKey` and scrolled to with `Scrollable.ensureVisible`:

```dart
final List<GlobalKey> _sectionKeys = List.generate(
  PortfolioData.navItems.length, (_) => GlobalKey(),
);

Scrollable.ensureVisible(
  context,
  duration: const Duration(milliseconds: 800),
  curve: Curves.easeInOutCubic,
);
```

### Responsive Layout
Use the `BuildContext` extension from `responsive_helper.dart`:

```dart
context.isMobile    // width <= 600
context.isTablet    // 601–960
context.isDesktop   // > 960
```

Or inline `MediaQuery` for one-off checks:
```dart
final isWide = MediaQuery.sizeOf(context).width > 760;
```

Content is constrained to `maxWidth: 1280` with dynamic horizontal padding:
```dart
final horizontalInset = screenWidth > 1200 ? 36.0 : (screenWidth > 700 ? 28.0 : 16.0);
```

---

## Widget Patterns

### Private Sub-Widgets
Large widgets are decomposed into private classes within the same file:

```dart
// In nav_bar.dart
class NavBar extends StatefulWidget { ... }
class _Logo extends StatelessWidget { ... }
class _NavLink extends StatefulWidget { ... }
class _HireMeButton extends StatefulWidget { ... }
class _LanguageToggle extends StatelessWidget { ... }
class _ThemeToggle extends StatelessWidget { ... }
```

### Hover Interactions (Desktop)
Interactive elements use `MouseRegion` + local `_hovered` state:

```dart
class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    cursor: SystemMouseCursors.click,
    child: ...,
  );
}
```

### Animated Transitions
Prefer `AnimatedContainer` and `AnimatedPositioned` over explicit `AnimationController` for simple transitions:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 420),
  curve: Curves.easeOutCubic,
  ...
)
```

### Bilingual Text
Always provide both EN and AR strings inline using the `isArabic` boolean:

```dart
Text(isArabic ? 'وظفني' : 'Hire Me')
Text(isArabic ? 'السابق' : 'Previous project')
```

Font family switches based on locale:
```dart
(isArabic ? GoogleFonts.cairo : GoogleFonts.inter)(
  color: Colors.white,
  fontWeight: FontWeight.w600,
)
```

### Semantics for Accessibility
Interactive carousel dots include `Semantics` labels:

```dart
Semantics(
  button: true,
  label: isArabic ? 'المشروع ${index + 1}' : 'Project ${index + 1}',
  child: InkWell(...),
)
```

---

## Color System

All colors are defined as `const` hex values. Core palette:

| Token | Hex | Usage |
|---|---|---|
| Background | `0xFF032D32` | Scaffold background |
| Surface | `0xFF06454A` | Card/drawer surfaces |
| Primary (Gold) | `0xFFFFC900` | Active states, CTAs, highlights |
| Secondary (Aqua) | `0xFF62DADD` / `0xFF52D8DE` | Inactive states, borders, chips |
| Accent Blue | `0xFF00D4FF` | Gradient accents |
| Accent Purple | `0xFF7B2FFF` | Gradient accents |

Use `.withValues(alpha: x)` (not deprecated `.withOpacity`) for transparency.

---

## Typography

- **Headings / Logo**: `GoogleFonts.playfairDisplay` or `GoogleFonts.orbitron`
- **Body / UI text (EN)**: `GoogleFonts.inter`
- **Body / UI text (AR)**: `GoogleFonts.cairo`
- **Card titles**: `GoogleFonts.poppins`
- **Custom font (bundled)**: `Cairo` family in `assets/fonts/` for offline Arabic support

---

## Model Design

Models use `const` constructors with all optional fields nullable:

```dart
const ProjectModel({
  required this.title,
  required this.description,
  required this.technologies,
  required this.emoji,
  required this.gradientColors,
  this.liveUrl,        // nullable optional
  this.githubUrl,
  this.detailedSections,
  // ...
});
```

---

## Platform Runner Conventions (C++)

- Anonymous namespace `namespace { }` for file-local helpers
- `constexpr` for compile-time string constants
- Singleton via static pointer + lazy init (`GetInstance()`)
- `noexcept` on Win32 message handlers
- UTF-16 → UTF-8 conversion via `WideCharToMultiByte` for Flutter engine args
