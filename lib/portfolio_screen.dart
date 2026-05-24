import 'package:flutter/material.dart';

import 'data/portfolio_data.dart';
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
      backgroundColor: const Color(0xFF0A0F1E), // Deep navy/slate
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
            ),
          ),
        ],
      ),
    );
  }
}
