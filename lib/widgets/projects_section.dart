import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/gestures.dart';
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
  static const _wheelThreshold = 28.0;
  static const _dragThreshold = 48.0;
  static const _navigationCooldown = Duration(milliseconds: 420);

  static double relativePosition(double index, double position, int count) {
    var relative = index - (position % count);
    if (relative > count / 2) relative -= count;
    if (relative < -count / 2) relative += count;
    return relative;
  }

  int _activeIndex = 0;
  double _position = 0;
  double _wheelDelta = 0;
  double _dragDelta = 0;
  bool _dragHandled = false;
  DateTime? _lastWheelNavigation;

  void _move(int delta, int count) {
    if (count == 0) return;
    setState(() {
      _position += delta;
      _activeIndex = (_activeIndex + delta + count) % count;
    });
  }

  void _goTo(int index, int count) {
    if (count == 0 || index == _activeIndex) return;
    var delta = index - _activeIndex;
    if (delta > count ~/ 2) delta -= count;
    if (delta < -(count ~/ 2)) delta += count;
    setState(() {
      _position += delta;
      _activeIndex = index;
    });
  }

  bool _canNavigate(bool next, int count) {
    if (count <= 1) return false;
    return next ? _activeIndex < count - 1 : _activeIndex > 0;
  }

  void _handleWheel(PointerScrollEvent event, int count) {
    final dx = event.scrollDelta.dx;
    final dy = event.scrollDelta.dy;
    if (dx.abs() <= dy.abs() || !_canNavigate(dx > 0, count)) return;
    GestureBinding.instance.pointerSignalResolver.register(event, (_) {
      if (_wheelDelta != 0 && (_wheelDelta > 0) != (dx > 0)) {
        _wheelDelta = 0;
      }
      _wheelDelta += dx;
      final now = DateTime.now();
      final last = _lastWheelNavigation;
      if (_wheelDelta.abs() < _wheelThreshold ||
          (last != null && now.difference(last) < _navigationCooldown)) {
        return;
      }
      _move(dx > 0 ? 1 : -1, count);
      _wheelDelta = 0;
      _lastWheelNavigation = now;
    });
  }

  void _startDrag() {
    _dragDelta = 0;
    _dragHandled = false;
    _wheelDelta = 0;
  }

  void _updateDrag(DragUpdateDetails details, int count) {
    _dragDelta -= details.delta.dx;
    if (_dragHandled || _dragDelta.abs() < _dragThreshold) return;
    _move(_dragDelta > 0 ? 1 : -1, count);
    _dragHandled = true;
  }

  Widget _buildCoverflowCard({
    required int index,
    required int count,
    required ProjectModel project,
    required bool isArabic,
    required double animatedPosition,
    required double stageWidth,
    required double cardWidth,
    required double cardHeight,
    required double top,
    required double step,
    required double depthStep,
    required double perspective,
  }) {
    final relative =
        relativePosition(index.toDouble(), animatedPosition, count);
    final active = index == _activeIndex;
    return Positioned(
      left: (stageWidth - cardWidth) / 2,
      top: top,
      width: cardWidth,
      height: cardHeight,
      child: Visibility(
        visible: relative.abs() <= 3.2,
        maintainState: true,
        child: _CoverflowCard(
          key: ValueKey('featured-card-$index'),
          relative: relative,
          step: step,
          depthStep: depthStep,
          perspective: perspective,
          onTap:
              active ? () => _openProject(project) : () => _goTo(index, count),
          child: _FeaturedProjectCard(
            project: project,
            isArabic: isArabic,
            onOpen: () => _openProject(project),
            compact: !active,
            active: active,
          ),
        ),
      ),
    );
  }

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
                      final step = cardWidth *
                          (isPhone ? 1.08 : (width < 600 ? 1.02 : 1.0));
                      final depthStep = isPhone ? 48.0 : 72.0;
                      final perspective = isPhone ? .0016 : .0012;
                      final reduceMotion =
                          MediaQuery.disableAnimationsOf(context);
                      final duration = Duration(
                        milliseconds: reduceMotion ? 0 : 720,
                      );
                      final dotDuration = Duration(
                        milliseconds: reduceMotion ? 0 : 300,
                      );
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

                      return Listener(
                        onPointerSignal: (event) {
                          if (event is PointerScrollEvent) {
                            _handleWheel(event, projects.length);
                          }
                        },
                        child: RawGestureDetector(
                          behavior: HitTestBehavior.opaque,
                          gestures: <Type,
                              GestureRecognizerFactory<GestureRecognizer>>{
                            HorizontalDragGestureRecognizer:
                                GestureRecognizerFactoryWithHandlers<
                                    HorizontalDragGestureRecognizer>(
                              () => HorizontalDragGestureRecognizer(),
                              (instance) {
                                instance.onStart = (_) => _startDrag();
                                instance.onUpdate = (details) =>
                                    _updateDrag(details, projects.length);
                                instance.onEnd = (details) {
                                  final velocity = details.primaryVelocity ?? 0;
                                  if (!_dragHandled && velocity.abs() > 100) {
                                    _move(
                                        velocity < 0 ? 1 : -1, projects.length);
                                  }
                                  _dragDelta = 0;
                                  _dragHandled = false;
                                };
                              },
                            ),
                          },
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: _position),
                            duration: duration,
                            curve: Curves.easeInOutCubic,
                            builder: (context, animatedPosition, _) {
                              final cardOrder = List<int>.generate(
                                  projects.length, (index) => index)
                                ..sort((a, b) {
                                  final aDepth = relativePosition(a.toDouble(),
                                          animatedPosition, projects.length)
                                      .abs();
                                  final bDepth = relativePosition(b.toDouble(),
                                          animatedPosition, projects.length)
                                      .abs();
                                  return bDepth.compareTo(aDepth);
                                });
                              final cards = cardOrder.map((index) {
                                return _buildCoverflowCard(
                                  index: index,
                                  count: projects.length,
                                  project: projects[index],
                                  isArabic: isArabic,
                                  animatedPosition: animatedPosition,
                                  stageWidth: width,
                                  cardWidth: cardWidth,
                                  cardHeight: cardHeight,
                                  top: topInset,
                                  step: step,
                                  depthStep: depthStep,
                                  perspective: perspective,
                                );
                              }).toList();

                              return ClipRect(
                                clipper: const _HorizontalViewportClipper(360),
                                child: SizedBox(
                                  key: const Key('featured-coverflow-stage'),
                                  width: width,
                                  height: topInset + cardHeight + bottomInset,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Positioned.fill(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            gradient: RadialGradient(
                                              center: Alignment.center,
                                              radius: isPhone ? .9 : .7,
                                              colors: [
                                                const Color(0x2338C9CE),
                                                const Color(0x0A06383D),
                                                Colors.transparent,
                                              ],
                                              stops: const [0, .55, 1],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: (width - cardWidth) / 2 - 24,
                                        top: topInset - 24,
                                        width: cardWidth + 48,
                                        height: cardHeight + 48,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: const Color(0x0AFFC800),
                                            borderRadius:
                                                BorderRadius.circular(42),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x2AFFC800),
                                                blurRadius: 54,
                                                spreadRadius: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ...cards,
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Center(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: List.generate(
                                                  projects.length, (index) {
                                                final selected =
                                                    index == _activeIndex;
                                                return Semantics(
                                                  button: true,
                                                  label: isArabic
                                                      ? '\u0627\u0644\u0645\u0634\u0631\u0648\u0639 ${index + 1}'
                                                      : 'Project ${index + 1}',
                                                  child: SizedBox(
                                                    width: AppLayout
                                                        .minTouchTarget,
                                                    height: AppLayout
                                                        .minTouchTarget,
                                                    child: InkWell(
                                                      onTap: () => _goTo(index,
                                                          projects.length),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                      child: Center(
                                                        child:
                                                            AnimatedContainer(
                                                          duration: dotDuration,
                                                          width: selected
                                                              ? 18
                                                              : 10,
                                                          height: 10,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: selected
                                                                ? const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    132,
                                                                    105,
                                                                    7)
                                                                : _aqua
                                                                    .withValues(
                                                                        alpha:
                                                                            .85),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                              );
                            },
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
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isPhone
                            ? Icons.swap_horiz_rounded
                            : Icons.keyboard_arrow_right_rounded,
                        size: 14,
                        color: _aqua.withValues(alpha: .7),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          isArabic
                              ? 'اسحب يمينًا أو يسارًا'
                              : 'Swipe sideways to explore',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: .42),
                            fontSize: 10,
                            letterSpacing: isArabic ? 0 : 1.2,
                          ),
                        ),
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

class _CoverflowCard extends StatelessWidget {
  const _CoverflowCard({
    super.key,
    required this.relative,
    required this.step,
    required this.depthStep,
    required this.perspective,
    required this.onTap,
    required this.child,
  });

  final double relative;
  final double step;
  final double depthStep;
  final double perspective;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final distance = relative.abs();
    final extra = math.max(0.0, distance - 1);
    final x = relative * step * (1 + extra * .16);
    final y = distance * 8;
    final z = distance * depthStep + extra * depthStep * .35;
    final rotationY = (-relative * .28).clamp(-.78, .78);
    final scale = 1 / (1 + distance * .16 + extra * .08);
    final matrix = Matrix4.identity()
      ..setEntry(3, 2, perspective)
      ..translate(x, y, z)
      ..rotateY(rotationY)
      ..scale(scale);

    return RepaintBoundary(
      child: Transform(
        transform: matrix,
        alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(30),
            child: child,
          ),
        ),
      ),
    );
  }
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
        final tallerMobileVisual = project.featuredVisual == 'desktop' ||
            project.featuredVisual == 'desktop-robot' ||
            project.featuredVisual == 'desktop-mobile' ||
            project.featuredVisual == 'responsive' ||
            project.featuredVisual == 'plain-image';
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
                                  isArabic: isArabic,
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
                              height: compact
                                  ? (tallerMobileVisual ? 155 : 115)
                                  : 128,
                              child: _ProjectVisual(
                                project: project,
                                isArabic: isArabic,
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
    required this.isArabic,
    required this.compact,
    required this.wide,
    required this.active,
  });

  final ProjectModel project;
  final bool isArabic;
  final bool compact;
  final bool wide;
  final bool active;

  @override
  Widget build(BuildContext context) {
    if (project.featuredVisual == 'pipeline') {
      return _PipelineCardVisual(compact: compact, isArabic: isArabic);
    }
    if (project.featuredVisual == 'voice-overflow') {
      final images = project.featuredImages;
      final asset = (images != null && images.isNotEmpty)
          ? images.first
          : project.imageUrl;
      if (asset != null) {
        return _VoiceOverflowVisual(
          assetName: asset,
          wide: wide,
          active: active,
        );
      }
    }
    if (project.featuredVisual == 'infographic') {
      final images = project.featuredImages;
      final asset = (images != null && images.isNotEmpty)
          ? images.first
          : project.imageUrl;
      if (asset != null) {
        return _ProjectImageVisual(
          assetName: asset,
          active: active,
        );
      }
    }
    if (project.featuredVisual == 'plain-image') {
      final images = project.featuredImages;
      final asset = (images != null && images.isNotEmpty)
          ? images.first
          : project.imageUrl;
      if (asset != null) {
        return _PlainProjectImage(
          assetName: asset,
          active: active,
        );
      }
    }
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

class _VoiceOverflowVisual extends StatelessWidget {
  const _VoiceOverflowVisual({
    required this.assetName,
    required this.wide,
    required this.active,
  });

  static const _aspect = 371 / 445;

  final String assetName;
  final bool wide;
  final bool active;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final targetWidth = math.min(
            width * (wide ? .98 : .91),
            height * (wide ? 1.38 : 2.28) * _aspect,
          );
          final targetHeight = targetWidth / _aspect;
          final left = width - targetWidth * (wide ? .84 : .98);
          final top = (height - targetHeight) * (wide ? .42 : .36);

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: left - targetWidth * .1,
                top: top + targetHeight * .12,
                child: Container(
                  width: targetWidth * 1.05,
                  height: targetWidth * 1.05,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0x4D52D8DE),
                        Color(0x1A52D8DE),
                        Color(0x0052D8DE),
                      ],
                      stops: [0, .45, 1],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: left,
                top: top,
                child: SizedBox(
                  width: targetWidth,
                  height: targetHeight,
                  child: OptimizedImage.asset(
                    assetName: assetName,
                    fit: BoxFit.contain,
                    priority:
                        active ? ImageLoadPriority.high : ImageLoadPriority.low,
                    lazy: false,
                    semanticLabel: 'Libyan dialect AI voice research visual',
                  ),
                ),
              ),
            ],
          );
        },
      );
}

class _ProjectImageVisual extends StatelessWidget {
  const _ProjectImageVisual({
    required this.assetName,
    required this.active,
  });

  final String assetName;
  final bool active;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Transform.scale(
              scale: 1.26,
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: OptimizedImage.asset(
                  assetName: assetName,
                  fit: BoxFit.contain,
                  priority:
                      active ? ImageLoadPriority.high : ImageLoadPriority.low,
                  semanticLabel: 'Seven-stage lead generation pipeline',
                ),
              ),
            ),
          );
        },
      );
}

class _PlainProjectImage extends StatelessWidget {
  const _PlainProjectImage({
    required this.assetName,
    required this.active,
  });

  final String assetName;
  final bool active;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: OptimizedImage.asset(
              assetName: assetName,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              fit: BoxFit.contain,
              priority: active ? ImageLoadPriority.high : ImageLoadPriority.low,
              semanticLabel: 'Project visual',
            ),
          );
        },
      );
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

class _PipelineCardVisual extends StatelessWidget {
  const _PipelineCardVisual({required this.compact, required this.isArabic});

  static const _aqua = Color(0xFF52D8DE);
  static const _gold = Color(0xFFFFC800);
  static const _stagesEn = [
    'Public Listings',
    'Raw Fields',
    'Clean Records',
    'Qualified Leads',
    'Prepare Text',
    'Outreach Drafts',
    'Live Reporting',
  ];
  static const _stagesAr = [
    'جمع القوائم',
    'استخراج الحقول',
    'تنظيف السجلات',
    'تأهيل العملاء',
    'تحضير النصوص',
    'صياغة التواصل',
    'التقرير الحي',
  ];

  final bool compact;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final stages = isArabic ? _stagesAr : _stagesEn;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final dense = height < 180;
        final left = math.max(18.0, width * .07);
        final right = width - left;
        final topY = height * (dense ? .34 : .32);
        final bottomY = height * (dense ? .73 : .74);
        final hoseWidth = dense ? 16.0 : (compact ? 21.0 : 25.0);
        final nodeSize = dense ? 15.0 : (compact ? 21.0 : 25.0);
        final arrowSize = dense ? 8.0 : 11.0;
        final labelHeight = dense ? 12.0 : 16.0;
        final fontSize = dense ? 7.0 : (compact ? 8.0 : 9.5);
        final gap = dense ? 1.0 : 3.0;
        final topLabelTop = math.max(
          0.0,
          topY - nodeSize / 2 - arrowSize - gap - labelHeight,
        );
        final bottomLabelTop = math.min(
          height - labelHeight,
          bottomY + nodeSize / 2 + arrowSize + gap,
        );
        final topCell = math.min(width * .30, 100.0);
        final bottomCell = math.min(width * .36, 120.0);
        final topXs = [
          for (var i = 0; i < 4; i++) left + (right - left) * i / 3,
        ];
        final bottomXs = [
          for (var i = 0; i < 3; i++) right - (right - left) * i / 2,
        ];

        double clampedLeft(double x, double cell) =>
            math.max(0.0, math.min(width - cell, x - cell / 2));

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF062F35).withValues(alpha: .72),
              border: Border.all(
                color: _aqua.withValues(alpha: compact ? .42 : .7),
              ),
              borderRadius: BorderRadius.circular(compact ? 16 : 20),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _PipelineHosePainter(
                      left: left,
                      right: right,
                      topY: topY,
                      bottomY: bottomY,
                      thickness: hoseWidth,
                    ),
                  ),
                ),
                for (var i = 0; i < topXs.length; i++)
                  _station(
                    index: i,
                    x: topXs[i],
                    y: topY,
                    label: stages[i],
                    above: true,
                    nodeSize: nodeSize,
                    arrowSize: arrowSize,
                    fontSize: fontSize,
                    labelHeight: labelHeight,
                    labelTop: topLabelTop,
                    cellWidth: topCell,
                    clampedLeft: clampedLeft,
                  ),
                for (var i = 0; i < bottomXs.length; i++)
                  _station(
                    index: i + 4,
                    x: bottomXs[i],
                    y: bottomY,
                    label: stages[i + 4],
                    above: false,
                    nodeSize: nodeSize,
                    arrowSize: arrowSize,
                    fontSize: fontSize,
                    labelHeight: labelHeight,
                    labelTop: bottomLabelTop,
                    cellWidth: bottomCell,
                    clampedLeft: clampedLeft,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _station({
    required int index,
    required double x,
    required double y,
    required String label,
    required bool above,
    required double nodeSize,
    required double arrowSize,
    required double fontSize,
    required double labelHeight,
    required double labelTop,
    required double cellWidth,
    required double Function(double, double) clampedLeft,
  }) =>
      Stack(
        children: [
          Positioned(
            left: x - nodeSize / 2,
            top: y - nodeSize / 2,
            child: Container(
              width: nodeSize,
              height: nodeSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  center: Alignment(-.35, -.45),
                  radius: .95,
                  colors: [
                    Color(0xFF2FAEB5),
                    Color(0xFF0B5A61),
                    Color(0xFF062E33),
                    Color(0xFF021B1F),
                  ],
                  stops: [0, .34, .72, 1],
                ),
                border: Border.all(color: _gold, width: 1.4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .42),
                    offset: Offset(0, nodeSize > 18 ? 3 : 2),
                    blurRadius: nodeSize > 18 ? 7 : 4,
                  ),
                  BoxShadow(
                    color: _gold.withValues(alpha: .28),
                    blurRadius: nodeSize > 18 ? 10 : 5,
                  ),
                ],
              ),
              child: Text(
                '${index + 1}',
                style: GoogleFonts.orbitron(
                  color: _gold,
                  fontSize: nodeSize > 18 ? 8 : 6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            left: x - arrowSize / 2,
            top: above ? labelTop + labelHeight : y + nodeSize / 2 + 1,
            child: Icon(
              above ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
              size: arrowSize,
              color: _aqua.withValues(alpha: .95),
            ),
          ),
          Positioned(
            left: clampedLeft(x, cellWidth),
            top: labelTop,
            width: cellWidth,
            height: labelHeight,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: (isArabic ? GoogleFonts.cairo() : GoogleFonts.inter())
                  .copyWith(
                color: Colors.white.withValues(alpha: .9),
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
}

class _PipelineHosePainter extends CustomPainter {
  const _PipelineHosePainter({
    required this.left,
    required this.right,
    required this.topY,
    required this.bottomY,
    required this.thickness,
  });

  final double left;
  final double right;
  final double topY;
  final double bottomY;
  final double thickness;

  @override
  void paint(Canvas canvas, Size size) {
    final turn = math.min((right - left) * .10, 28.0);
    final radius = (bottomY - topY) / 2;
    final path = Path()
      ..moveTo(left, topY)
      ..lineTo(right - turn, topY)
      ..quadraticBezierTo(right, topY, right, topY + radius)
      ..quadraticBezierTo(right, bottomY, right - turn, bottomY)
      ..lineTo(left, bottomY);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.save();
    canvas.translate(0, math.max(3.0, thickness * .24));
    paint
      ..shader = null
      ..color = Colors.black.withValues(alpha: .38)
      ..strokeWidth = thickness + 9;
    canvas.drawPath(path, paint);
    canvas.restore();

    paint
      ..color = const Color(0xFF021B1F)
      ..strokeWidth = thickness + 6;
    canvas.drawPath(path, paint);

    final bodyShader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF02262B),
        const Color(0xFF0B6B72),
        const Color(0xFF4EDCE2),
        const Color(0xFF0A6D75),
        const Color(0xFF022125),
      ],
      stops: [0, .20, .38, .68, 1],
    ).createShader(
      Rect.fromLTWH(
        0,
        topY - thickness,
        size.width,
        bottomY - topY + thickness * 2,
      ),
    );
    paint
      ..shader = bodyShader
      ..strokeWidth = thickness + 2;
    canvas.drawPath(path, paint);

    paint
      ..shader = null
      ..color = Colors.black.withValues(alpha: .24)
      ..strokeWidth = math.max(2.5, thickness * .32);
    canvas.save();
    canvas.translate(0, thickness * .24);
    canvas.drawPath(path, paint);
    canvas.restore();

    paint
      ..color = Colors.white.withValues(alpha: .38)
      ..strokeWidth = math.max(2.0, thickness * .16);
    canvas.save();
    canvas.translate(0, -thickness * .24);
    canvas.drawPath(path, paint);
    canvas.restore();

    _drawCap(canvas, left, topY);
    _drawCap(canvas, left, bottomY);
  }

  void _drawCap(Canvas canvas, double x, double y) {
    final rect = Rect.fromLTWH(
      x - thickness * .32,
      y - thickness * .58,
      thickness * .64,
      thickness * 1.16,
    );
    canvas.drawOval(
      rect,
      Paint()
        ..color = const Color(0xFF021B1F)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawOval(
      rect.deflate(2),
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-.4, -.5),
          radius: .9,
          colors: [
            Color(0xFF52D8DE),
            Color(0xFF0A626A),
            Color(0xFF022125),
          ],
          stops: [0, .48, 1],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _PipelineHosePainter oldDelegate) =>
      oldDelegate.left != left ||
      oldDelegate.right != right ||
      oldDelegate.topY != topY ||
      oldDelegate.bottomY != bottomY ||
      oldDelegate.thickness != thickness;
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

  static const _desktopAspect = 1805 / 947;
  static const _mobileAspect = 387 / 860;
  static const _frameHorizontalInset = 14.0;
  static const _frameVerticalInset = 2.0;

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
          width * (tall ? .84 : .98),
          (height * (tall ? .62 : 1.08)) * _desktopAspect + 12,
        );
        final baseMonitorHeight =
            (baseMonitorWidth - _frameHorizontalInset) / _desktopAspect +
                _frameVerticalInset +
                31;
        final monitorWidth = baseMonitorWidth * (wide ? 1.3 : 1.0);
        final screenHeight =
            (monitorWidth - _frameHorizontalInset) / _desktopAspect +
                _frameVerticalInset;
        final monitorHeight = screenHeight + 31;
        final phoneTargetHeight = baseMonitorHeight * (tall ? .66 : .62);
        final basePhoneWidth = math.min(
          math.max(
            baseMonitorWidth * .22,
            (phoneTargetHeight - 10) * _mobileAspect + 10,
          ),
          baseMonitorWidth * .28,
        );
        final phoneWidth = basePhoneWidth * (tall ? 1.6 : 1.15);
        final phoneHeight = (phoneWidth - 10) / _mobileAspect + 10;
        final monitorLeft =
            (width - monitorWidth) / 2 + width * (tall ? .03 : .04);
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
