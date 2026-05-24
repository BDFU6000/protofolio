import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';
import '../utils/locale_provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.activeSection,
    required this.onNavTap,
  });

  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  final int activeSection;
  final ValueChanged<int> onNavTap;

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
        final isWide = MediaQuery.of(context).size.width > 768;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _isScrolled
                ? const Color(0xFF0A0F1E).withOpacity(0.95)
                : Colors.transparent,
            border: _isScrolled
                ? Border(
                    bottom: BorderSide(
                        color: const Color(0xFF00D4FF).withOpacity(0.15)))
                : null,
            boxShadow: _isScrolled
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20)
                  ]
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Row(
            children: [
              _Logo(name: PortfolioData.name),
              const Spacer(),
              if (isWide)
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
              const SizedBox(width: 16),
              _HireMeButton(
                isArabic: isArabic,
                onTap: () =>
                    widget.onNavTap(PortfolioData.navItems.length - 1),
              ),
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
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF00D4FF), Color(0xFF7B2FFF)]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(initials,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
        ),
        const SizedBox(width: 12),
        Text(name,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18)),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink(
      {required this.label,
      required this.isActive,
      required this.onTap});
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
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                    color: (widget.isActive || _hovered)
                        ? const Color(0xFF00D4FF)
                        : Colors.white70,
                    fontWeight: widget.isActive
                        ? FontWeight.w600
                        : FontWeight.w400,
                    fontSize: 14),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: (widget.isActive || _hovered) ? 20 : 0,
                decoration: BoxDecoration(
                    color: const Color(0xFF00D4FF),
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
  const _HireMeButton(
      {required this.onTap, required this.isArabic});
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
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF00D4FF), Color(0xFF7B2FFF)]),
            borderRadius: BorderRadius.circular(24),
            boxShadow: _hovered
                ? [
                    const BoxShadow(
                        color: Color(0x6600D4FF),
                        blurRadius: 20,
                        spreadRadius: 2)
                  ]
                : [],
          ),
          child: Text(
            widget.isArabic ? 'وظفني' : 'Hire Me',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14),
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
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, size: 16, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              isArabic ? 'EN' : 'عربي',
              style: GoogleFonts.inter(
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
