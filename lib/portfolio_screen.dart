import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/portfolio_data.dart';
import 'utils/locale_provider.dart';
import 'utils/responsive_helper.dart';
import 'utils/theme_provider.dart';
import 'widgets/about_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/experience_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/nav_bar.dart';
import 'widgets/projects_section.dart';
import 'widgets/services_section.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(
    PortfolioData.navItems.length,
    (_) => GlobalKey(),
  );

  int _activeSection = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Determine which section is currently visible
    final viewPortHeight = _scrollController.position.viewportDimension;

    // A simple heuristic: check which section's top is nearest to the middle of the screen.
    double closestDistance = double.infinity;
    int closestIndex = 0;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;

        // Distance to the center of the viewport
        final distance = (position - (viewPortHeight / 2)).abs();

        if (distance < closestDistance) {
          closestDistance = distance;
          closestIndex = i;
        }
      }
    }

    if (closestIndex != _activeSection) {
      setState(() => _activeSection = closestIndex);
    }
  }

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        // Adjust alignment depending on section (0 = top)
        alignment: index == 0 ? 0 : 0.1,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalInset = context.horizontalGutter;
    final isPhone = context.isPhone;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF032D32),
      endDrawer: ValueListenableBuilder<bool>(
        valueListenable: LocaleProvider.isArabic,
        builder: (context, isArabic, _) {
          const gold = Color(0xFFFFC900);
          const goldLight = Color(0xFFFFD83D);
          const aqua = Color(0xFF62DADD);
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final initials = PortfolioData.name
              .split(' ')
              .where((word) => word.isNotEmpty)
              .map((word) => word[0])
              .take(2)
              .join();

          return Drawer(
            backgroundColor: const Color(0xFF032D32),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF022B30),
                    Color(0xFF06454A),
                    Color(0xFF032D32),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, .55, 1],
                ),
                border: Border(
                  left: isArabic
                      ? BorderSide(color: gold.withValues(alpha: .18))
                      : BorderSide.none,
                  right: !isArabic
                      ? BorderSide(color: aqua.withValues(alpha: .18))
                      : BorderSide.none,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 12, 18),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [gold, goldLight],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                initials,
                                style: (isArabic
                                        ? GoogleFonts.cairo
                                        : GoogleFonts.playfairDisplay)(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    letterSpacing: 1.2),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isArabic ? 'القائمة' : 'MENU',
                                  style: (isArabic
                                          ? GoogleFonts.cairo
                                          : GoogleFonts.orbitron)(
                                      color: gold,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                      letterSpacing: isArabic ? 0 : 3),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  PortfolioData.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: (isArabic
                                          ? GoogleFonts.cairo
                                          : GoogleFonts.playfairDisplay)(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: isArabic ? 'إغلاق' : 'Close menu',
                            icon: const Icon(Icons.close_rounded,
                                color: Colors.white70),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: gold.withValues(alpha: .18),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 18, 24, 8),
                      child: Text(
                        isArabic ? 'التنقل' : 'Navigation',
                        style: (isArabic ? GoogleFonts.cairo : GoogleFonts.inter)(
                          color: aqua.withValues(alpha: .85),
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          letterSpacing: isArabic ? 0 : 2.4,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: PortfolioData.navItems.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, i) {
                          final isActive = _activeSection == i;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? gold.withValues(alpha: .12)
                                  : Colors.white.withValues(alpha: .04),
                              border: Border.all(
                                color: isActive
                                    ? gold.withValues(alpha: .5)
                                    : Colors.white.withValues(alpha: .08),
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                Navigator.of(context).pop();
                                _scrollToSection(i);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 13),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? gold
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        PortfolioData.navItems[i],
                                        style: (isArabic
                                                ? GoogleFonts.cairo
                                                : GoogleFonts.inter)(
                                            color: isActive
                                                ? gold
                                                : Colors.white.withValues(
                                                    alpha: .78),
                                            fontWeight: isActive
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Icon(
                                      isActive
                                          ? Icons.arrow_forward_rounded
                                          : Icons.chevron_right_rounded,
                                      size: 16,
                                      color: isActive
                                          ? gold
                                          : Colors.white.withValues(alpha: .38),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: LocaleProvider.toggle,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        minHeight: AppLayout.minTouchTarget),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: .06),
                                      border: Border.all(
                                          color:
                                              Colors.white.withValues(alpha: .14)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.language,
                                            size: 16, color: gold),
                                        const SizedBox(width: 8),
                                        Text(
                                          isArabic ? 'EN' : 'عربي',
                                          style: (isArabic
                                                  ? GoogleFonts.cairo
                                                  : GoogleFonts.inter)(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: ThemeProvider.toggle,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: AppLayout.minTouchTarget,
                                  height: AppLayout.minTouchTarget,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: .06),
                                    border: Border.all(
                                        color:
                                            Colors.white.withValues(alpha: .14)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    isDark
                                        ? Icons.light_mode_outlined
                                        : Icons.dark_mode_outlined,
                                    color: gold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              _scrollToSection(
                                  PortfolioData.navItems.length - 1);
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(
                                  minHeight: AppLayout.minTouchTarget),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [gold, goldLight],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: gold.withValues(alpha: .24),
                                    blurRadius: 18,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  isArabic ? 'وظفني' : 'Hire Me',
                                  style: (isArabic
                                          ? GoogleFonts.cairo
                                          : GoogleFonts.inter)(
                                      color: const Color(0xFF17383A),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      letterSpacing: isArabic ? 0 : 2.2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF022B30),
                    Color(0xFF03464B),
                    Color(0xFF022E35),
                  ],
                  stops: [0, 0.58, 1],
                ),
              ),
            ),
          ),
          Positioned(
            top: isPhone ? -70 : -110,
            left: isPhone ? -80 : -150,
            child: _GlowOrb(size: isPhone ? 180 : 300),
          ),
          Positioned(
            top: isPhone ? 360 : 480,
            right: isPhone ? -110 : -210,
            child: _GlowOrb(size: isPhone ? 220 : 360),
          ),
          // Main content scrollable
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  key: _sectionKeys[0],
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1280),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalInset),
                        child: HeroReferenceSection(
                          toolsKey: _sectionKeys[1],
                          onViewWork: () => _scrollToSection(2),
                        ),
                      ),
                    ),
                  ),
                ),
                // Projects section gets full width so 3D carousel cards are not clipped
                Container(
                  key: _sectionKeys[2],
                  child: const ProjectsSection(),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1280),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalInset),
                      child: Column(
                        children: [
                          Container(
                            key: _sectionKeys[3],
                            child: AboutSection(
                              onContactTap: () => _scrollToSection(6),
                            ),
                          ),
                          Container(
                            key: _sectionKeys[4],
                            child: const ExperienceSection(),
                          ),
                          Container(
                            key: _sectionKeys[5],
                            child: const ServicesSection(),
                          ),
                          Container(
                            key: _sectionKeys[6],
                            child: ContactSection(
                              onNavigate: _scrollToSection,
                              onBackToTop: () => _scrollToSection(0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sticky top navigation bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: NavBar(
                scrollController: _scrollController,
                sectionKeys: _sectionKeys,
                activeSection: _activeSection,
                onNavTap: _scrollToSection,
                onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Color(0xFFFFC900), Color(0x00FFC900)],
          ),
        ),
      );
}
