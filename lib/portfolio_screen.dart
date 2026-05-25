import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/portfolio_data.dart';
import 'utils/locale_provider.dart';
import 'widgets/about_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/experience_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/nav_bar.dart';
import 'widgets/projects_section.dart';
import 'widgets/skills_section.dart';

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
    final scrollOffset = _scrollController.offset;
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0A0F1E), // Deep navy/slate
      endDrawer: ValueListenableBuilder<bool>(
        valueListenable: LocaleProvider.isArabic,
        builder: (context, isArabic, _) {
          return Drawer(
            backgroundColor: const Color(0xFF0D1321),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: isArabic
                      ? BorderSide(
                          color: const Color(0xFF00D4FF).withOpacity(0.1))
                      : BorderSide.none,
                  right: !isArabic
                      ? BorderSide(
                          color: const Color(0xFF00D4FF).withOpacity(0.1))
                      : BorderSide.none,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Drawer Header with Close Button
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0xFF00D4FF),
                                    Color(0xFF7B2FFF)
                                  ]),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    PortfolioData.name
                                        .split(' ')
                                        .where((w) => w.isNotEmpty)
                                        .map((w) => w[0])
                                        .take(2)
                                        .join(),
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded,
                                color: Colors.white70),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.white10, height: 1),
                    const SizedBox(height: 16),
                    // Navigation links
                    Expanded(
                      child: ListView.builder(
                        itemCount: PortfolioData.navItems.length,
                        itemBuilder: (context, i) {
                          final isActive = _activeSection == i;
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            title: Text(
                              PortfolioData.navItems[i],
                              style: GoogleFonts.inter(
                                color: isActive
                                    ? const Color(0xFF00D4FF)
                                    : Colors.white70,
                                fontWeight: isActive
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            leading: Container(
                              width: 6,
                              height: 24,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? const Color(0xFF00D4FF)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(); // Close drawer
                              _scrollToSection(i);
                            },
                          );
                        },
                      ),
                    ),
                    // Language toggle and Hire Me in the bottom
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isArabic ? 'اللغة' : 'Language',
                                style: GoogleFonts.inter(
                                    color: Colors.white38, fontSize: 14),
                              ),
                              InkWell(
                                onTap: () {
                                  LocaleProvider.toggle();
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.language,
                                          size: 16, color: Colors.white),
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
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              _scrollToSection(
                                  PortfolioData.navItems.length - 1);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xFF00D4FF),
                                  Color(0xFF7B2FFF)
                                ]),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  isArabic ? 'وظفني' : 'Hire Me',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
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
          // Main content scrollable
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // 0: Home / Hero
                Container(
                  key: _sectionKeys[0],
                  child: const HeroSection(),
                ),

                // Content wrapper for max width (desktop)
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      children: [
                        // 1: About
                        Container(
                          key: _sectionKeys[1],
                          child: const AboutSection(),
                        ),

                        // 2: Skills
                        Container(
                          key: _sectionKeys[2],
                          child: const SkillsSection(),
                        ),

                        // 3: Experience
                        Container(
                          key: _sectionKeys[3],
                          child: const ExperienceSection(),
                        ),

                        // 4: Projects
                        Container(
                          key: _sectionKeys[4],
                          child: const ProjectsSection(),
                        ),

                        // 5: Contact
                        Container(
                          key: _sectionKeys[5],
                          child: const ContactSection(),
                        ),
                      ],
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
            child: NavBar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
              activeSection: _activeSection,
              onNavTap: _scrollToSection,
              onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}
