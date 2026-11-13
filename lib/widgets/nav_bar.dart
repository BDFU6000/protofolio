import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';
import '../utils/locale_provider.dart';
import '../utils/theme_provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.activeSection,
    required this.onNavTap,
    required this.onMenuTap,
  });

  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  final int activeSection;
  final ValueChanged<int> onNavTap;
  final VoidCallback onMenuTap;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 80;
    if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        final isWide = MediaQuery.of(context).size.width > 920;
        final inset = MediaQuery.of(context).size.width > 1200 ? 36.0 : 16.0;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _isScrolled
                ? const Color(0xFF032D32).withValues(alpha: .96)
                : Colors.transparent,
            border: _isScrolled
                ? Border(
                    bottom: BorderSide(
                        color: const Color(0xFF62DADD).withValues(alpha: .12)))
                : null,
            boxShadow: _isScrolled
                ? [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: .18),
                        blurRadius: 18)
                  ]
                : null,
          ),
          padding: EdgeInsets.symmetric(horizontal: inset, vertical: 12),
          child: Row(
            children: [
              Flexible(child: _Logo(name: PortfolioData.name)),
              const Spacer(),
              if (isWide) ...[
                Row(
                  children: List.generate(
                    PortfolioData.navItems.length,
                    (i) => _NavLink(
                      label: PortfolioData.navItems[i],
                      isActive: widget.activeSection == i,
                      onTap: () => widget.onNavTap(i),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                _LanguageToggle(isArabic: isArabic),
                const SizedBox(width: 10),
                _HireMeButton(
                  isArabic: isArabic,
                  onTap: () =>
                      widget.onNavTap(PortfolioData.navItems.length - 1),
                ),
              ] else ...[
                _ThemeToggle(isDark: isDark),
                IconButton(
                  icon: Icon(Icons.menu_rounded,
                      color: isDark ? Colors.white : Color(0xFF1D1B1C),
                      size: 28),
                  onPressed: widget.onMenuTap,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final initials = name
        .split(' ')
        .where((w) => w.isNotEmpty)
        .map((w) => w[0])
        .take(2)
        .join();
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFC900), Color(0xFFFFE36E)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(initials,
                style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 1.5)),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: (LocaleProvider.isArabic.value
                      ? GoogleFonts.cairo
                      : GoogleFonts.playfairDisplay)(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 1.5)),
        ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink(
      {required this.label, required this.isActive, required this.onTap});
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: (LocaleProvider.isArabic.value
                        ? GoogleFonts.cairo
                        : GoogleFonts.inter)(
                    color: (widget.isActive || _hovered)
                        ? const Color(0xFFFFC900)
                        : Colors.white70,
                    fontWeight:
                        widget.isActive ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 10,
                    letterSpacing: 0.3),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: (widget.isActive || _hovered) ? 20 : 0,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFC900),
                    borderRadius: BorderRadius.circular(2)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HireMeButton extends StatefulWidget {
  const _HireMeButton({required this.onTap, required this.isArabic});
  final VoidCallback onTap;
  final bool isArabic;

  @override
  State<_HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<_HireMeButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFFFFC900), Color(0xFFFFD83D)]),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered
                ? [
                    const BoxShadow(
                        color: Color(0x66FFC900),
                        blurRadius: 20,
                        spreadRadius: 2)
                  ]
                : [],
          ),
          child: Text(
            widget.isArabic ? 'وظفني' : 'Hire Me',
            style: (widget.isArabic ? GoogleFonts.cairo : GoogleFonts.inter)(
                color: const Color(0xFF17383A),
                fontWeight: FontWeight.w600,
                fontSize: 12,
                letterSpacing: 2.2),
          ),
        ),
      ),
    );
  }
}

/// Language toggle — already uses ValueListenableBuilder internally,
/// but now receives the value from the parent builder to avoid nesting.
class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle({required this.isArabic});
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: LocaleProvider.toggle,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .06),
          border: Border.all(color: Colors.white.withValues(alpha: .14)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 6),
            Text(
              isArabic ? 'EN' : 'عربي',
              style: (isArabic ? GoogleFonts.cairo : GoogleFonts.inter)(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      onPressed: ThemeProvider.toggle,
      icon: Icon(
        isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        color: Colors.white,
      ),
    );
  }
}
