import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';
import '../models/project_model.dart';
import '../screens/project_details_screen.dart';
import '../utils/locale_provider.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  static const _aqua = Color(0xFF52D8DE);
  static const _gold = Color(0xFFFFC800);
  int _activeIndex = 0;

  void _move(int delta, int count) {
    if (count == 0) return;
    setState(() => _activeIndex = (_activeIndex + delta + count) % count);
  }

  Widget _buildPositionedCard({
    required ProjectModel project,
    required int index,
    required int total,
    required bool isArabic,
    required double cardWidth,
    required double cardHeight,
    required double left,
    required double top,
    required double rotation,
    required bool active,
    required VoidCallback onTap,
  }) =>
      _CarouselCardPosition(
        key: ValueKey(project.title),
        width: cardWidth,
        height: cardHeight,
        left: left,
        top: top,
        rotation: rotation,
        active: active,
        onTap: onTap,
        child: _FeaturedProjectCard(
          project: project,
          index: index,
          total: total,
          isArabic: isArabic,
          onOpen: onTap,
          compact: !active,
        ),
      );

  void _openProject(ProjectModel project) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProjectDetailsScreen(project: project),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;

    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        final projects = PortfolioData.projects;
        if (_activeIndex >= projects.length) _activeIndex = 0;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 20 : 16,
            vertical: isWide ? 64 : 44,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionPill(
                  text: isArabic ? 'أعمال مختارة' : 'Featured worked.'),
              const SizedBox(height: 22),
              Text.rich(
                TextSpan(
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: isWide ? 34 : 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: isWide ? 7 : 3,
                    height: 1.25,
                    shadows: const [
                      Shadow(
                        color: Color(0xAA00D4FF),
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  children: [
                    TextSpan(text: isArabic ? 'أعمال ' : 'Things I’ve '),
                    TextSpan(
                      text: isArabic ? 'أنجزتها.' : 'Built.',
                      style: const TextStyle(color: _aqua),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isArabic
                    ? 'مجموعة من الأفكار التي تحولت إلى منتجات رقمية حقيقية.'
                    : 'A collection of ideas turned into real digital products.',
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontSize: isWide ? 14 : 11,
                  letterSpacing: isWide ? 3.6 : 1.2,
                  height: 1.6,
                  shadows: const [
                    Shadow(
                      color: Color(0xAA00D4FF),
                      offset: Offset(1, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              if (projects.isNotEmpty)
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final cardWidth = width < 600
                        ? width * .92
                        : math.min(width * .59, 720.0);
                    final cardHeight = width < 600 ? 455.0 : 350.0;
                    final sideOffset = cardWidth * (width < 600 ? .88 : .91);
                    final sideWidth = cardWidth * .72;
                    final leftPeekOffset =
                        width < 600 ? sideOffset : width / 2 + sideWidth * .25;
                    final leftProject =
                        (_activeIndex - 1 + projects.length) % projects.length;
                    final rightProject = (_activeIndex + 1) % projects.length;
                    final cardWidgets = <Widget>[
                      if (projects.length > 1)
                        _buildPositionedCard(
                          project: projects[leftProject],
                          index: leftProject,
                          total: projects.length,
                          isArabic: isArabic,
                          cardWidth: sideWidth,
                          cardHeight: cardHeight * .86,
                          left: (width - sideWidth) / 2 - leftPeekOffset,
                          top: 28,
                          rotation: -.14,
                          active: false,
                          onTap: () => _move(-1, projects.length),
                        ),
                      if (projects.length > 2)
                        _buildPositionedCard(
                          project: projects[rightProject],
                          index: rightProject,
                          total: projects.length,
                          isArabic: isArabic,
                          cardWidth: sideWidth,
                          cardHeight: cardHeight * .86,
                          left: (width - sideWidth) / 2 + sideOffset,
                          top: 28,
                          rotation: .14,
                          active: false,
                          onTap: () => _move(1, projects.length),
                        ),
                      _buildPositionedCard(
                        project: projects[_activeIndex],
                        index: _activeIndex,
                        total: projects.length,
                        isArabic: isArabic,
                        cardWidth: cardWidth,
                        cardHeight: cardHeight,
                        left: (width - cardWidth) / 2,
                        top: 0,
                        rotation: 0,
                        active: true,
                        onTap: () => _openProject(projects[_activeIndex]),
                      ),
                    ];

                    return GestureDetector(
                      onHorizontalDragEnd: (details) {
                        final velocity = details.primaryVelocity ?? 0;
                        if (velocity.abs() > 100) {
                          _move(velocity < 0 ? 1 : -1, projects.length);
                        }
                      },
                      child: SizedBox(
                        width: width,
                        height: cardHeight + 48,
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.topCenter,
                          children: [
                            ...cardWidgets,
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    List.generate(projects.length, (index) {
                                  final selected = index == _activeIndex;
                                  return Semantics(
                                    button: true,
                                    label: isArabic
                                        ? 'المشروع ${index + 1}'
                                        : 'Project ${index + 1}',
                                    child: InkWell(
                                      onTap: () =>
                                          setState(() => _activeIndex = index),
                                      borderRadius: BorderRadius.circular(20),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 220),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        width: selected ? 18 : 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: selected
                                              ? _gold
                                              : _aqua.withValues(alpha: .85),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: isArabic ? 'السابق' : 'Previous project',
                    onPressed: () => _move(-1, projects.length),
                    icon: const Icon(Icons.arrow_back_rounded, color: _aqua),
                  ),
                  Text(
                    '${(_activeIndex + 1).toString().padLeft(2, '0')} / ${projects.length.toString().padLeft(2, '0')}',
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 11,
                      letterSpacing: 1.4,
                    ),
                  ),
                  IconButton(
                    tooltip: isArabic ? 'التالي' : 'Next project',
                    onPressed: () => _move(1, projects.length),
                    icon: const Icon(Icons.arrow_forward_rounded, color: _aqua),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionPill extends StatelessWidget {
  const _SectionPill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF073F45),
          border: Border.all(color: const Color(0xFF16818A)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.circle, size: 9, color: Color(0xFF69E4E6)),
            const SizedBox(width: 6),
            Text(text,
                style: GoogleFonts.inter(
                    color: const Color(0xFF69E4E6),
                    fontSize: 11,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      );
}

class _CarouselCardPosition extends StatelessWidget {
  const _CarouselCardPosition({
    super.key,
    required this.width,
    required this.height,
    required this.left,
    required this.top,
    required this.rotation,
    required this.active,
    required this.onTap,
    required this.child,
  });

  final double width;
  final double height;
  final double left;
  final double top;
  final double rotation;
  final bool active;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedPositioned(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        left: left,
        top: top,
        width: width,
        height: height,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, .0012)
            ..rotateY(rotation)
            ..scale(active ? 1.0 : .92),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(32),
              child: child,
            ),
          ),
        ),
      );
}

class _FeaturedProjectCard extends StatelessWidget {
  const _FeaturedProjectCard({
    required this.project,
    required this.index,
    required this.total,
    required this.isArabic,
    required this.onOpen,
    required this.compact,
  });

  final ProjectModel project;
  final int index;
  final int total;
  final bool isArabic;
  final VoidCallback onOpen;
  final bool compact;

  static const _aqua = Color(0xFF52D8DE);
  static const _gold = Color(0xFFFFC800);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wideCard = constraints.maxWidth > 480;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            border: Border.all(
              color: compact ? _aqua : _gold.withValues(alpha: .25),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(compact ? 24 : 30),
            boxShadow: [
              BoxShadow(
                color: (compact ? _aqua : _gold)
                    .withValues(alpha: compact ? .1 : .25),
                blurRadius: compact ? 22 : 34,
                spreadRadius: compact ? 1 : 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(compact ? 24 : 30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: ColoredBox(
                color: compact
                    ? const Color(0xFF71E5E6).withValues(alpha: .10)
                    : const Color(0xFFFFC800).withValues(alpha: .25),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(compact ? 18 : 26),
                      child: wideCard
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: _ProjectCardContent(
                                    project: project,
                                    index: index,
                                    total: total,
                                    isArabic: isArabic,
                                    compact: compact,
                                    onOpen: onOpen,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 5,
                                  child: _ProjectImagePlaceholder(
                                    project: project,
                                    compact: compact,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: compact ? 115 : 128,
                                  child: _ProjectImagePlaceholder(
                                    project: project,
                                    compact: compact,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: _ProjectCardContent(
                                    project: project,
                                    index: index,
                                    total: total,
                                    isArabic: isArabic,
                                    compact: compact,
                                    onOpen: onOpen,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProjectCardContent extends StatelessWidget {
  const _ProjectCardContent({
    required this.project,
    required this.index,
    required this.total,
    required this.isArabic,
    required this.compact,
    required this.onOpen,
  });

  final ProjectModel project;
  final int index;
  final int total;
  final bool isArabic;
  final bool compact;
  final VoidCallback onOpen;

  static const _aqua = Color(0xFF4EDDE3);
  static const _gold = Color(0xFFFFC900);

  @override
  Widget build(BuildContext context) {
    final captionColor = Colors.white.withValues(alpha: compact ? .72 : .82);
    final subtitle = project.subtitle ?? project.description;
    final details = project.detailedSections ?? const <ProjectDetailSection>[];
    final visibleTechnologies =
        compact ? project.technologies.take(2) : project.technologies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(_categoryIcon(project),
                color: compact ? _aqua : _gold, size: 14),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                project.category ?? _categoryName(project, isArabic),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: compact ? _aqua : _gold,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.3,
                ),
              ),
            ),
            Text(
              '${(index + 1).toString().padLeft(2, '0')} / ${total.toString().padLeft(2, '0')}',
              style: GoogleFonts.inter(color: captionColor, fontSize: 9),
            ),
          ],
        ),
        SizedBox(height: compact ? 12 : 18),
        Text(
          project.title,
          maxLines: compact ? 1 : 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: compact ? 15 : 21,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        SizedBox(height: compact ? 7 : 10),
        Expanded(
          child: Text(
            subtitle,
            maxLines: compact ? 2 : 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: captionColor,
              fontSize: compact ? 10 : 12,
              height: 1.45,
              letterSpacing: .5,
            ),
          ),
        ),
        if (!compact && details.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            isArabic
                ? '${details.length} تفاصيل للمشروع'
                : '${details.length} project details',
            maxLines: 1,
            style: GoogleFonts.inter(color: _aqua, fontSize: 9),
          ),
        ],
        SizedBox(height: compact ? 8 : 10),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            for (final technology in visibleTechnologies)
              _TechChip(technology, compact: compact),
          ],
        ),
        if (!compact) ...[
          const SizedBox(height: 11),
          InkWell(
            onTap: onOpen,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isArabic ? 'استكشف المشروع' : 'Explore the Project',
                    style: GoogleFonts.inter(
                      color: _gold,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_circle_right, color: _gold, size: 15),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  static String _categoryName(ProjectModel project, bool isArabic) {
    final technologies =
        project.technologies.map((e) => e.toLowerCase()).toList();
    if (technologies.any((e) => e.contains('clinic') || e.contains('health'))) {
      return isArabic ? 'تقنية صحية' : 'HealthTech';
    }
    if (technologies.any((e) => e.contains('ai') || e.contains('python'))) {
      return isArabic ? 'ذكاء اصطناعي' : 'AI & Automation';
    }
    if (technologies.any((e) => e.contains('erp') || e.contains('business'))) {
      return isArabic ? 'حلول أعمال' : 'Business';
    }
    if (technologies.any((e) => e.contains('figma') || e.contains('ui/ux'))) {
      return isArabic ? 'تصميم منتجات' : 'Product Design';
    }
    return isArabic ? 'منتج رقمي' : 'Digital Product';
  }

  static IconData _categoryIcon(ProjectModel project) {
    final category = project.category?.toLowerCase() ?? '';
    if (category.contains('health') ||
        project.emoji == '🏥' ||
        project.emoji == '💊') {
      return Icons.favorite_rounded;
    }
    if (category.contains('business') || project.emoji == '📦') {
      return Icons.business_center_rounded;
    }
    if (project.emoji == '🤖' || project.emoji == '🎙️') {
      return Icons.auto_awesome_rounded;
    }
    return Icons.widgets_rounded;
  }
}

class _ProjectImagePlaceholder extends StatelessWidget {
  const _ProjectImagePlaceholder(
      {required this.project, required this.compact});

  final ProjectModel project;
  final bool compact;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF062F35).withValues(alpha: .5),
          border: Border.all(color: Colors.white.withValues(alpha: .12)),
          borderRadius: BorderRadius.circular(compact ? 16 : 20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.blur_on_rounded,
              size: compact ? 76 : 130,
              color: const Color(0xFF4EDDE3).withValues(alpha: .13),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(project.emoji,
                    style: TextStyle(fontSize: compact ? 38 : 54)),
                const SizedBox(height: 8),
                Text(
                  'PROJECT VISUAL',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: .52),
                    fontSize: compact ? 7 : 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.8,
                  ),
                ),
                if (!compact) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Image coming soon',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: .4),
                      fontSize: 9,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      );
}

class _TechChip extends StatelessWidget {
  const _TechChip(this.label, {required this.compact});

  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 7 : 9,
          vertical: compact ? 4 : 5,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF4EDDE3).withValues(alpha: .1),
          border:
              Border.all(color: const Color(0xFF4EDDE3).withValues(alpha: .18)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TechnologyMark(label: label, compact: compact),
            const SizedBox(width: 5),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: const Color(0xFFC9FAFB),
                fontSize: compact ? 8 : 9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
}

class _TechnologyMark extends StatelessWidget {
  const _TechnologyMark({required this.label, required this.compact});

  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final normalized = label.toLowerCase();
    final asset = _assetFor(normalized);
    final size = compact ? 12.0 : 14.0;

    if (asset == null) {
      return Icon(
        _fallbackFor(normalized),
        size: size,
        color: const Color(0xFF69E4E6),
      );
    }

    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(
        _fallbackFor(normalized),
        size: size,
        color: const Color(0xFF69E4E6),
      ),
    );
  }

  String? _assetFor(String technology) {
    if (technology.contains('flutter') || technology == 'dart') {
      return 'assets/images/Flutter_logo.png';
    }
    if (technology.contains('figma')) return 'assets/images/figma_logo.png';
    if (technology.contains('supabase')) {
      return 'assets/images/supabase_logo.png';
    }
    if (technology.contains('firebase')) {
      return 'assets/images/firebase_logo.png';
    }
    if (technology.contains('python')) return 'assets/images/python_logo.png';
    if (technology.contains('postgres') || technology == 'sql') {
      return 'assets/images/postgresql_logo.png';
    }
    if (technology.contains('api') ||
        technology.contains('rest') ||
        technology.contains('webhook')) {
      return 'assets/images/API&Rest_API_logo.png';
    }
    if (technology == 'c#' || technology.contains('c sharp')) {
      return 'assets/images/C#_logo.png';
    }
    if (technology.contains('github') || technology == 'git') {
      return 'assets/images/Github_logo.png';
    }
    return null;
  }

  IconData _fallbackFor(String technology) {
    if (technology.contains('ai') || technology.contains('ollama')) {
      return Icons.auto_awesome_rounded;
    }
    if (technology.contains('map') || technology.contains('places')) {
      return Icons.map_rounded;
    }
    if (technology.contains('erp') || technology.contains('business')) {
      return Icons.business_center_rounded;
    }
    if (technology.contains('design') || technology.contains('ux')) {
      return Icons.design_services_rounded;
    }
    if (technology.contains('speech') || technology.contains('audio')) {
      return Icons.graphic_eq_rounded;
    }
    if (technology.contains('word') || technology.contains('documentation')) {
      return Icons.description_rounded;
    }
    return Icons.extension_rounded;
  }
}
