import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';
import '../models/project_model.dart';
import '../screens/project_details_screen.dart';
import '../utils/locale_provider.dart';
import '../utils/responsive_helper.dart';
import '../widgets/optimized_image.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  static const _aqua = Color(0xFF52D8DE);
  int _activeIndex = 0;

  void _move(int delta, int count) {
    if (count == 0) return;
    setState(() => _activeIndex = (_activeIndex + delta + count) % count);
  }

  Widget _buildPositionedCard({
    required ProjectModel project,
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
          isArabic: isArabic,
          onOpen: onTap,
          compact: !active,
          active: active,
        ),
      );

  void _openProject(ProjectModel project) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProjectDetailsScreen(project: project),
      ),
    );
  }

  void _showAllProjects(List<ProjectModel> projects, bool isArabic) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF062F35),
      isScrollControlled: true,
      builder: (sheetContext) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(sheetContext).height * .72,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      isArabic ? 'كل المشاريع' : 'All Projects',
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    icon: const Icon(Icons.close, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: projects.length,
                separatorBuilder: (_, __) => const Divider(
                  color: Color(0x1FFFFFFF),
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return ListTile(
                    leading: Text(project.emoji,
                        style: const TextStyle(fontSize: 22)),
                    title: Text(
                      project.title,
                      style:
                          GoogleFonts.inter(color: Colors.white, fontSize: 13),
                    ),
                    subtitle: Text(
                      project.technologies.take(3).join(' • '),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          color: Colors.white60, fontSize: 10),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _openProject(project);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = context.screenWidth > 760;
    final isPhone = context.isPhone;

    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        final projects = PortfolioData.projects;
        if (_activeIndex >= projects.length) _activeIndex = 0;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isWide ? 64 : 44,
                horizontal: isWide ? 28 : 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionPill(
                                text: isArabic
                                    ? '\u0623\u0639\u0645\u0627\u0644 \u0645\u062e\u062a\u0627\u0631\u0629'
                                    : 'Featured worked.'),
                            const SizedBox(height: 22),
                            Text.rich(
                              TextSpan(
                                style: GoogleFonts.orbitron(
                                  color: Colors.white,
                                  fontSize: isWide ? 34 : (isPhone ? 26 : 24),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing:
                                      isWide ? 7 : (isPhone ? 1.5 : 3),
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
                                  TextSpan(
                                      text: isArabic
                                          ? '\u0623\u0639\u0645\u0627\u0644 '
                                          : 'Things I\u2019ve '),
                                  TextSpan(
                                    text: isArabic
                                        ? '\u0623\u0646\u062c\u0632\u062a\u0647\u0627.'
                                        : 'Built.',
                                    style: const TextStyle(color: _aqua),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              isArabic
                                  ? '\u0645\u062c\u0645\u0648\u0639\u0629 \u0645\u0646 \u0627\u0644\u0623\u0641\u0643\u0627\u0631 \u0627\u0644\u062a\u064a \u062a\u062d\u0648\u0644\u062a \u0625\u0644\u0649 \u0645\u0646\u062a\u062c\u0627\u062a \u0631\u0642\u0645\u064a\u0629 \u062d\u0642\u064a\u0642\u064a\u0629.'
                                  : 'A collection of ideas turned into real digital products.',
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontSize: isWide ? 14 : (isPhone ? 12 : 11),
                                letterSpacing:
                                    isWide ? 3.6 : (isPhone ? 0.4 : 1.2),
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: isWide ? 44 : 34),
                        child: _SeeAllLink(
                          isArabic: isArabic,
                          compact: !isWide,
                          onTap: () => _showAllProjects(projects, isArabic),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isPhone ? 30 : 46),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final cardWidth = isPhone
                          ? width * .96
                          : (width < 600
                              ? width * .92
                              : math.min(width * .59, 720.0));
                      final cardHeight =
                          isPhone ? 470.0 : (width < 600 ? 455.0 : 350.0);
                      final topInset = 64.0;
                      final bottomInset = 52.0;
                      final sideOffset = cardWidth * (width < 600 ? .88 : .91);
                      final sideWidth = cardWidth * .72;
                      if (projects.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 48),
                          child: Column(
                            children: [
                              Icon(Icons.work_off_outlined,
                                  size: 48, color: _aqua),
                              const SizedBox(height: 12),
                              Text(
                                isArabic
                                    ? 'لا توجد مشاريع لعرضها بعد.'
                                    : 'No projects to show yet.',
                                style: GoogleFonts.inter(
                                    color: Colors.white70, fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      }
                      final leftProject = (_activeIndex - 1 + projects.length) %
                          projects.length;
                      final rightProject = (_activeIndex + 1) % projects.length;
                      final cardWidgets = <Widget>[
                        if (!isPhone && projects.length > 1)
                          _buildPositionedCard(
                            project: projects[leftProject],
                            isArabic: isArabic,
                            cardWidth: sideWidth,
                            cardHeight: cardHeight * .86,
                            left: (width - sideWidth) / 2 - sideOffset,
                            top: topInset + 18,
                            rotation: -.14,
                            active: false,
                            onTap: () => _move(-1, projects.length),
                          ),
                        if (!isPhone && projects.length > 2)
                          _buildPositionedCard(
                            project: projects[rightProject],
                            isArabic: isArabic,
                            cardWidth: sideWidth,
                            cardHeight: cardHeight * .86,
                            left: (width - sideWidth) / 2 + sideOffset,
                            top: topInset + 18,
                            rotation: .14,
                            active: false,
                            onTap: () => _move(1, projects.length),
                          ),
                        _buildPositionedCard(
                          project: projects[_activeIndex],
                          isArabic: isArabic,
                          cardWidth: cardWidth,
                          cardHeight: cardHeight,
                          left: (width - cardWidth) / 2,
                          top: topInset,
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
                        child: ClipRect(
                          clipper: const _HorizontalViewportClipper(360),
                          child: SizedBox(
                            width: width,
                            height: topInset + cardHeight + bottomInset,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                ...cardWidgets,
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(projects.length,
                                            (index) {
                                          final selected =
                                              index == _activeIndex;
                                          return Semantics(
                                            button: true,
                                            label: isArabic
                                                ? '\u0627\u0644\u0645\u0634\u0631\u0648\u0639 ${index + 1}'
                                                : 'Project ${index + 1}',
                                            child: SizedBox(
                                              width: AppLayout.minTouchTarget,
                                              height: AppLayout.minTouchTarget,
                                              child: InkWell(
                                                onTap: () => setState(
                                                    () => _activeIndex = index),
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                child: Center(
                                                  child: AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    width: selected ? 18 : 10,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: selected
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 132, 105, 7)
                                                          : _aqua.withValues(
                                                              alpha: .85),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        tooltip: isArabic
                            ? '\u0627\u0644\u0633\u0627\u0628\u0642'
                            : 'Previous project',
                        onPressed: () => _move(-1, projects.length),
                        icon: const Icon(Icons.arrow_back_ios, color: _aqua),
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
                        tooltip: isArabic
                            ? '\u0627\u0644\u062a\u0627\u0644\u064a'
                            : 'Next project',
                        onPressed: () => _move(1, projects.length),
                        icon: const Icon(Icons.arrow_forward_ios, color: _aqua),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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

class _SeeAllLink extends StatelessWidget {
  const _SeeAllLink({
    required this.isArabic,
    required this.compact,
    required this.onTap,
  });

  final bool isArabic;
  final bool compact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isArabic ? 'عرض الكل' : 'See All',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFFC800),
                  fontSize: compact ? 10 : 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_outward,
                  color: Color(0xFFFFC800), size: 14),
            ],
          ),
        ),
      );
}

class _HorizontalViewportClipper extends CustomClipper<Rect> {
  const _HorizontalViewportClipper(this.verticalExtent);

  final double verticalExtent;

  @override
  Rect getClip(Size size) => Rect.fromLTRB(
        0,
        -verticalExtent,
        size.width,
        size.height + verticalExtent,
      );

  @override
  bool shouldReclip(covariant _HorizontalViewportClipper oldClipper) =>
      oldClipper.verticalExtent != verticalExtent;
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
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
        left: left,
        top: top,
        width: width,
        height: height,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeInOutCubic,
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
    required this.isArabic,
    required this.onOpen,
    required this.compact,
    required this.active,
  });

  final ProjectModel project;
  final bool isArabic;
  final VoidCallback onOpen;
  final bool compact;
  final bool active;

  static const _aqua = Color(0xFF52D8DE);
  static const _gold = Color(0xFFFFC800);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wideCard = constraints.maxWidth > 480;
        final radius = compact ? 24.0 : 30.0;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            border: Border.all(
              color: compact ? _aqua : _gold,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(radius),
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
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: ColoredBox(
                      color: compact
                          ? const Color(0xFF71E5E6).withValues(alpha: .10)
                          : const Color(0xFFFFC800).withValues(alpha: .08),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(compact ? 18 : 26),
                child: wideCard
                    ? Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: _ProjectCardContent(
                              project: project,
                              isArabic: isArabic,
                              compact: compact,
                              onOpen: onOpen,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 5,
                            child: Transform.translate(
                              offset: Offset(0, compact ? -24 : -58),
                              child: SizedBox.expand(
                                child: _ProjectVisual(
                                  project: project,
                                  compact: compact,
                                  wide: wideCard,
                                  active: active,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -34),
                            child: SizedBox(
                              height: compact ? 115 : 128,
                              child: _ProjectVisual(
                                project: project,
                                compact: compact,
                                wide: wideCard,
                                active: active,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: _ProjectCardContent(
                              project: project,
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
        );
      },
    );
  }
}

class _ProjectCardContent extends StatelessWidget {
  const _ProjectCardContent({
    required this.project,
    required this.isArabic,
    required this.compact,
    required this.onOpen,
  });

  final ProjectModel project;
  final bool isArabic;
  final bool compact;
  final VoidCallback onOpen;

  static const _aqua = Color(0xFF4EDDE3);
  static const _gold = Color(0xFFFFC900);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dense = compact || constraints.maxWidth < 300;
        final captionColor = Colors.white.withValues(alpha: dense ? .72 : .82);
        final subtitle = project.subtitle ?? project.description;
        final details = dense
            ? const <ProjectDetailSection>[]
            : project.detailedSections ?? const <ProjectDetailSection>[];
        final visibleTechnologies =
            dense ? project.technologies.take(2) : project.technologies;

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
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: dense ? 10 : 14),
            Text(
              project.title,
              maxLines: dense ? 1 : 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: compact ? 15 : (dense ? 18 : 22),
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            SizedBox(height: dense ? 6 : 8),
            Flexible(
              child: Text(
                subtitle,
                maxLines: dense ? 2 : 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: captionColor,
                  fontSize: compact ? 10 : (dense ? 11 : 13),
                  height: 1.45,
                  letterSpacing: .5,
                ),
              ),
            ),
            if (details.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                isArabic
                    ? '${details.length} \u062a\u0641\u0627\u0635\u064a\u0644 \u0644\u0644\u0645\u0634\u0631\u0648\u0639'
                    : '${details.length} project details',
                maxLines: 1,
                style: GoogleFonts.inter(color: _aqua, fontSize: 10),
              ),
            ],
            SizedBox(height: dense ? 6 : 8),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                for (final technology in visibleTechnologies)
                  _TechChip(technology, compact: dense),
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!compact)
                  Flexible(
                    child: project.websiteComparison != null
                        ? InkWell(
                            onTap: onOpen,
                            borderRadius: BorderRadius.circular(22),
                            child: _WebsiteExploreLink(
                              isArabic: isArabic,
                              dense: dense,
                            ),
                          )
                        : InkWell(
                            onTap: onOpen,
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      isArabic
                                          ? '\u0627\u0633\u062a\u0643\u0634\u0641 \u0627\u0644\u0645\u0634\u0631\u0648\u0639'
                                          : 'Explore the Project',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        color: _gold,
                                        fontSize: dense ? 11 : 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.4,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_circle_right,
                                      color: _gold, size: 15),
                                ],
                              ),
                            ),
                          ),
                  ),
                const Spacer(),
                if (project.completionDate != null)
                  Text(
                    project.completionDate!,
                    style: GoogleFonts.inter(
                      color: captionColor,
                      fontSize: dense ? 9 : 11,
                      letterSpacing: 1.2,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  static String _categoryName(ProjectModel project, bool isArabic) {
    final technologies =
        project.technologies.map((e) => e.toLowerCase()).toList();
    if (technologies.any((e) => e.contains('clinic') || e.contains('health'))) {
      return isArabic
          ? '\u062a\u0642\u0646\u064a\u0629 \u0635\u062d\u064a\u0629'
          : 'HealthTech';
    }
    if (technologies.any((e) => e.contains('ai') || e.contains('python'))) {
      return isArabic
          ? '\u0630\u0643\u0627\u0621 \u0627\u0635\u0637\u0646\u0627\u0639\u064a'
          : 'AI & Automation';
    }
    if (technologies.any((e) => e.contains('erp') || e.contains('business'))) {
      return isArabic
          ? '\u062d\u0644\u0648\u0644 \u0623\u0639\u0645\u0627\u0644'
          : 'Business';
    }
    if (technologies.any((e) => e.contains('figma') || e.contains('ui/ux'))) {
      return isArabic
          ? '\u062a\u0635\u0645\u064a\u0645 \u0645\u0646\u062a\u062c\u0627\u062a'
          : 'Product Design';
    }
    return isArabic
        ? '\u0645\u0646\u062a\u062c \u0631\u0642\u0645\u064a'
        : 'Digital Product';
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

class _ProjectVisual extends StatelessWidget {
  const _ProjectVisual({
    required this.project,
    required this.compact,
    required this.wide,
    required this.active,
  });

  final ProjectModel project;
  final bool compact;
  final bool wide;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final images = project.featuredImages;
    if (images == null || images.isEmpty) {
      return _ProjectImagePlaceholder(project: project, compact: compact);
    }
    if (project.featuredVisual == 'mobile') {
      return _PhoneCluster(images: images, wide: wide, active: active);
    }
    if (project.featuredVisual == 'responsive') {
      return _ResponsiveCluster(images: images, wide: wide, active: active);
    }
    if (project.featuredVisual == 'desktop-mobile') {
      return _DesktopMobileCluster(images: images, wide: wide, active: active);
    }
    if (project.featuredVisual == 'desktop') {
      return _DesktopCluster(images: images, wide: wide, active: active);
    }
    if (project.featuredVisual == 'desktop-robot') {
      return _DesktopRobotCluster(images: images, wide: wide, active: active);
    }
    return _ProjectImagePlaceholder(project: project, compact: compact);
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
              ],
            ),
          ],
        ),
      );
}

class _PhoneCluster extends StatelessWidget {
  const _PhoneCluster({
    required this.images,
    required this.wide,
    required this.active,
  });

  static const _screenAspects = <String, double>{
    'assets/images/Login Page.png': 430 / 932,
    'assets/images/Main Page.png': 428 / 913,
    'assets/images/doctor_leandek_login.png': 400 / 862,
    'assets/images/doctor_leandek_main.png': 387 / 852,
    'assets/images/Shopping Page.png': 321 / 685,
    'assets/images/Products detiaes Page.png': 428 / 913,
    'assets/images/Cart Page.png': 428 / 913,
    'assets/images/Order tracking Page.png': 428 / 913,
    'assets/images/Account Page.png': 428 / 913,
    'assets/images/Profile page.png': 428 / 913,
  };

  static double _screenAspect(String asset) => _screenAspects[asset] ?? .4688;

  final List<String> images;
  final bool wide;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final tall = wide && height > 180;
        final frameHeight = tall
            ? math.min(height * 1.02, 302.0)
            : math.min(height * 1.5, 190.0);
        final backAspect = _screenAspect(images.first);
        final frontAspect =
            images.length > 1 ? _screenAspect(images[1]) : backAspect;
        final backWidth = (frameHeight - 10) * backAspect + 10;
        final frontWidth = (frameHeight - 10) * frontAspect + 10;
        final overlap = ((backWidth + frontWidth) / 2) * (tall ? .32 : .28);
        final totalWidth = backWidth + frontWidth - overlap;
        final left = math.max(0.0, (width - totalWidth) / 2);
        final top = tall ? -height * .12 : -frameHeight + height * .95;
        final backTop = top + frameHeight * .09;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: images.length == 1 ? (width - backWidth) / 2 : left,
              top: images.length == 1 ? top : backTop,
              child: _PhoneFrame(
                asset: images.first,
                width: backWidth,
                height: frameHeight,
                angle: images.length == 1 ? 0 : -.10,
                screenAspect: backAspect,
                active: active,
              ),
            ),
            if (images.length > 1)
              Positioned(
                left: left + backWidth - overlap,
                top: top,
                child: _PhoneFrame(
                  asset: images[1],
                  width: frontWidth,
                  height: frameHeight,
                  angle: .09,
                  screenAspect: frontAspect,
                  active: active,
                  secondary: true,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ResponsiveCluster extends StatelessWidget {
  const _ResponsiveCluster({
    required this.images,
    required this.wide,
    required this.active,
  });

  final List<String> images;
  final bool wide;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final tall = wide && height > 180;
        final browserHeight = tall
            ? math.min(height * .86, 258.0)
            : math.min(height * 1.6, 195.0);
        final browserWidth = math.min(width * 1.04, browserHeight * 1.7);
        final top = tall ? -height * .10 : -browserHeight + height * .92;
        final phoneHeight = browserHeight * .82;
        final phoneWidth = phoneHeight * .53;
        final phoneLeft = math.max(width - phoneWidth - 2.0, width * .6);
        final phoneTop = top + browserHeight * .16;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              top: top,
              child: _BrowserFrame(
                asset: images.first,
                width: browserWidth,
                height: browserHeight,
                angle: -.03,
                active: active,
              ),
            ),
            if (images.length > 1)
              Positioned(
                left: phoneLeft,
                top: phoneTop,
                child: _PhoneFrame(
                  asset: images[1],
                  width: phoneWidth,
                  height: phoneHeight,
                  angle: .08,
                  active: active,
                  secondary: true,
                ),
              ),
            if (images.length > 2)
              Positioned(
                right: 0,
                top: phoneTop + phoneHeight * .42,
                child: _PhoneFrame(
                  asset: images[2],
                  width: phoneWidth * .82,
                  height: phoneHeight * .76,
                  angle: -.05,
                  active: active,
                  secondary: true,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _DesktopCluster extends StatelessWidget {
  const _DesktopCluster({
    required this.images,
    required this.wide,
    required this.active,
  });

  static const _desktopAspect = 1.6;

  final List<String> images;
  final bool wide;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final pcWidth = math.min(
          width * (wide ? .98 : .92),
          (height - 16) * _desktopAspect + 12,
        );
        final screenHeight = (pcWidth - 12) / _desktopAspect;
        final pcHeight = screenHeight + 34;
        final left = (width - pcWidth) / 2;
        final top = (height - pcHeight) / 2;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: left,
              top: top,
              child: _PcFrame(
                asset: images.first,
                width: pcWidth,
                screenHeight: screenHeight,
                angle: -.01,
                active: active,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DesktopRobotCluster extends StatelessWidget {
  const _DesktopRobotCluster({
    required this.images,
    required this.wide,
    required this.active,
  });

  static const _desktopAspect = 1.6;

  final List<String> images;
  final bool wide;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final pcWidth = math.min(
          width * (wide ? .84 : .86),
          (height - 12) * _desktopAspect + 12,
        );
        final screenHeight = (pcWidth - 12) / _desktopAspect;
        final pcHeight = screenHeight + 34;
        final pcLeft = width * (wide ? .2 : .24);
        final pcTop = (height - pcHeight) / 2;
        final robotSize = math.min(
          math.min(width * .37, height * .74),
          pcHeight * .86,
        );
        final robotLeft = math.max(
          -robotSize * .38,
          pcLeft - robotSize * 1.08,
        );
        final robotTop = pcTop + (pcHeight - robotSize) * .88;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            if (images.length > 1)
              Positioned(
                left: robotLeft,
                top: robotTop,
                child: Transform.rotate(
                  angle: -.06,
                  child: OptimizedImage.asset(
                    assetName: images[1],
                    width: robotSize,
                    height: robotSize,
                    fit: BoxFit.contain,
                    priority: ImageLoadPriority.low,
                    lazy: false,
                    placeholderIcon: Icons.image_outlined,
                    errorIcon: Icons.image_not_supported_outlined,
                  ),
                ),
              ),
            Positioned(
              left: pcLeft,
              top: pcTop,
              child: _PcFrame(
                asset: images.first,
                width: pcWidth,
                screenHeight: screenHeight,
                angle: -.01,
                active: active,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DesktopMobileCluster extends StatelessWidget {
  const _DesktopMobileCluster({
    required this.images,
    required this.wide,
    required this.active,
  });

  static const _desktopAspect = 1.6;
  static const _mobileAspect = 345 / 723;

  final List<String> images;
  final bool wide;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final tall = wide && height > 180;
        final baseMonitorWidth = math.min(
          width * .84,
          (height * (tall ? .62 : .58)) * _desktopAspect + 12,
        );
        final baseMonitorHeight = (baseMonitorWidth - 12) / _desktopAspect + 34;
        final monitorWidth = baseMonitorWidth * (wide ? 1.3 : 1.0);
        final screenHeight = (monitorWidth - 12) / _desktopAspect;
        final monitorHeight = screenHeight + 34;
        final phoneTargetHeight = baseMonitorHeight * (tall ? .66 : .62);
        final basePhoneWidth = math.min(
          math.max(
            baseMonitorWidth * .22,
            (phoneTargetHeight - 10) * _mobileAspect + 10,
          ),
          baseMonitorWidth * .28,
        );
        final phoneWidth = basePhoneWidth * (tall ? 1.6 : 1.0);
        final phoneHeight = (phoneWidth - 10) / _mobileAspect + 10;
        final monitorLeft =
            (width - monitorWidth) / 2 + width * (tall ? .03 : .08);
        final monitorTop = (height - monitorHeight) * (tall ? .42 : .5);
        final phoneLeft = tall
            ? math.max(0.0, monitorLeft - phoneWidth * .28)
            : monitorLeft - phoneWidth * .35;
        final phoneTop = tall
            ? math.max(0.0, height - phoneHeight - 10)
            : monitorTop + monitorHeight * .32;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: monitorLeft,
              top: monitorTop,
              child: _PcFrame(
                asset: images.first,
                width: monitorWidth,
                screenHeight: screenHeight,
                angle: -.015,
                active: active,
              ),
            ),
            if (images.length > 1)
              Positioned(
                left: phoneLeft,
                top: phoneTop,
                child: _PhoneFrame(
                  asset: images[1],
                  width: phoneWidth,
                  height: phoneHeight,
                  angle: 0,
                  active: active,
                  secondary: true,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _PcFrame extends StatelessWidget {
  const _PcFrame({
    required this.asset,
    required this.width,
    required this.screenHeight,
    required this.angle,
    required this.active,
  });

  final String asset;
  final double width;
  final double screenHeight;
  final double angle;
  final bool active;

  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: angle,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              height: screenHeight + 12,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B242B), Color(0xFF05080C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: const Color(0x668DA3A8), width: 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x99000000),
                    blurRadius: 22,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: ColoredBox(
                  color: const Color(0xFF0D2B31),
                  child: OptimizedImage.asset(
                    assetName: asset,
                    fit: BoxFit.contain,
                    priority:
                        active ? ImageLoadPriority.high : ImageLoadPriority.low,
                    lazy: false,
                    placeholderIcon: Icons.image_outlined,
                    errorIcon: Icons.image_not_supported_outlined,
                  ),
                ),
              ),
            ),
            Container(
              width: width * .11,
              height: 13,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE6FBFB), Color(0xFF7C9DA3)],
                ),
              ),
            ),
            Container(
              width: width * .38,
              height: 6,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFD9F1F3), Color(0xFF78979D)],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ],
        ),
      );
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({
    required this.asset,
    required this.width,
    required this.height,
    required this.angle,
    this.screenAspect,
    required this.active,
    this.secondary = false,
  });

  final String asset;
  final double width;
  final double height;
  final double angle;
  final double? screenAspect;
  final bool active;
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    Widget screen = OptimizedImage.asset(
      assetName: asset,
      fit: BoxFit.contain,
      priority:
          !active || secondary ? ImageLoadPriority.low : ImageLoadPriority.high,
      lazy: false,
      placeholderIcon: Icons.image_outlined,
      errorIcon: Icons.image_not_supported_outlined,
    );
    if (screenAspect != null) {
      screen = Center(
        child: AspectRatio(
          aspectRatio: screenAspect!,
          child: screen,
        ),
      );
    }

    return Transform.rotate(
      angle: angle,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE6FBFB), Color(0xFF74B6BC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(26),
          boxShadow: const [
            BoxShadow(
              color: Color(0x99000000),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: const Color(0xFF0D2B31),
                  child: screen,
                ),
              ),
              Positioned(
                left: width * .28,
                top: 6,
                child: Container(
                  width: width * .44,
                  height: 9,
                  decoration: BoxDecoration(
                    color: const Color(0xCC02181C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrowserFrame extends StatelessWidget {
  const _BrowserFrame({
    required this.asset,
    required this.width,
    required this.height,
    required this.angle,
    required this.active,
  });

  final String asset;
  final double width;
  final double height;
  final double angle;
  final bool active;

  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: angle,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x99000000),
                blurRadius: 24,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 26,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color(0xFFD8E7E9),
                  child: Row(
                    children: const [
                      CircleAvatar(
                          radius: 4, backgroundColor: Color(0xFF9CB4B8)),
                      SizedBox(width: 6),
                      CircleAvatar(
                          radius: 4, backgroundColor: Color(0xFF9CB4B8)),
                      SizedBox(width: 6),
                      CircleAvatar(
                          radius: 4, backgroundColor: Color(0xFF9CB4B8)),
                    ],
                  ),
                ),
                Expanded(
                  child: ColoredBox(
                    color: const Color(0xFF0D2B31),
                    child: OptimizedImage.asset(
                      assetName: asset,
                      fit: BoxFit.contain,
                      priority: active
                          ? ImageLoadPriority.high
                          : ImageLoadPriority.low,
                      lazy: false,
                      placeholderIcon: Icons.image_outlined,
                      errorIcon: Icons.image_not_supported_outlined,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _WebsiteExploreLink extends StatelessWidget {
  const _WebsiteExploreLink({required this.isArabic, required this.dense});

  final bool isArabic;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFFFC900);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 8 : 11,
        vertical: dense ? 6 : 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gold.withValues(alpha: .18),
            gold.withValues(alpha: .05),
          ],
        ),
        border: Border.all(color: gold.withValues(alpha: .48)),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(color: gold.withValues(alpha: .08), blurRadius: 14),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BrowserGlyph(color: gold),
          SizedBox(width: dense ? 6 : 9),
          Flexible(
            child: Text(
              isArabic
                  ? '\u0627\u0633\u062a\u0643\u0634\u0641 \u0627\u0644\u0645\u0648\u0642\u0639'
                  : 'Explore Website',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: gold,
                fontSize: dense ? 10 : 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: dense ? .6 : 1.1,
              ),
            ),
          ),
          SizedBox(width: dense ? 4 : 7),
          Icon(
            Icons.open_in_new_rounded,
            color: gold,
            size: dense ? 10 : 12,
          ),
        ],
      ),
    );
  }
}

class _BrowserGlyph extends StatelessWidget {
  const _BrowserGlyph({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 13,
      padding: const EdgeInsets.fromLTRB(2, 2, 2, 1.5),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: .8), width: 1),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        children: [
          Row(
            children: [
              for (var i = 0; i < 3; i++)
                Container(
                  width: 2.2,
                  height: 2.2,
                  margin: EdgeInsets.only(right: i == 2 ? 0 : 1.6),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 1.4),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color.withValues(alpha: .18),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: const Color(0xFFC9FAFB),
                  fontSize: compact ? 8 : 9,
                  fontWeight: FontWeight.w500,
                ),
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

    return OptimizedImage.asset(
      assetName: asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      priority: ImageLoadPriority.low,
      lazy: false,
      placeholderIcon: Icons.image_outlined,
      errorIcon: _fallbackFor(normalized),
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
