import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/project_specs.dart';
import '../models/project_model.dart';
import '../utils/locale_provider.dart';
import '../widgets/optimized_image.dart';
import '../widgets/website_comparison.dart';

const _gold = Color(0xFFFFC900);
const _aqua = Color(0xFF52D8DE);
const _deep = Color(0xFF032D32);
const _panel = Color(0xFF0B2E33);
const _panelDark = Color(0xFF0D1321);
const _ink = Color(0xFFD9E6E8);

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final isArabic = LocaleProvider.isArabic.value;
    final spec = ProjectSpecCatalog.forProject(project, isArabic);
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width > 900 ? 40.0 : 18.0;
    final heroStart = project.gradientColors.isEmpty
        ? _panel
        : Color(project.gradientColors.first);
    final heroEnd = project.gradientColors.length < 2
        ? heroStart
        : Color(project.gradientColors[1]);

    return Scaffold(
      backgroundColor: _deep,
      body: Stack(
        children: [
          const _AmbientBackground(),
          CustomScrollView(
            slivers: [
              _ProjectHero(
                project: project,
                spec: spec,
                isArabic: isArabic,
                heroStart: heroStart,
                heroEnd: heroEnd,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 30,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1180),
                      child: _DetailsBody(
                        project: project,
                        spec: spec,
                        isArabic: isArabic,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AmbientBackground extends StatelessWidget {
  const _AmbientBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_deep, Color(0xFF052A30), _deep],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              top: -140,
              right: -90,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(
                  width: 360,
                  height: 360,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _aqua.withValues(alpha: .10),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -180,
              left: -120,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: Container(
                  width: 420,
                  height: 420,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _gold.withValues(alpha: .07),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectHero extends StatelessWidget {
  const _ProjectHero({
    required this.project,
    required this.spec,
    required this.isArabic,
    required this.heroStart,
    required this.heroEnd,
  });

  final ProjectModel project;
  final ProjectDetailSpec spec;
  final bool isArabic;
  final Color heroStart;
  final Color heroEnd;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 900;
          final pad = wide ? 40.0 : 18.0;
          final heroHeight = wide ? 470.0 : 560.0;

          return Container(
            constraints: BoxConstraints(minHeight: heroHeight),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.lerp(heroStart, _deep, .24) ?? _panel,
                  Color.lerp(heroEnd, _deep, .42) ?? _panel,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -90,
                  right: -40,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
                    child: Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _aqua.withValues(alpha: .14),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          _deep.withValues(alpha: .55),
                          _deep,
                        ],
                        stops: const [.35, .78, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: pad),
                      child: Row(
                        children: [
                          Tooltip(
                            message: isArabic ? 'رجوع' : 'Back',
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.arrow_back_rounded,
                                  color: Colors.white),
                              style: IconButton.styleFrom(
                                backgroundColor:
                                    Colors.white.withValues(alpha: .08),
                                side: BorderSide(
                                  color: Colors.white.withValues(alpha: .14),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: _gold.withValues(alpha: .12),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: _gold.withValues(alpha: .38),
                              ),
                            ),
                            child: Text(
                              project.completionDate ??
                                  (isArabic ? 'مشروع' : 'Project'),
                              style: _bodyStyle(
                                isArabic: isArabic,
                                size: 11,
                                color: _gold,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    pad,
                    wide ? 96 : 104,
                    pad,
                    wide ? 42 : 26,
                  ),
                  child: wide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: _HeroCopy(
                                project: project,
                                spec: spec,
                                isArabic: isArabic,
                                compact: false,
                              ),
                            ),
                            const SizedBox(width: 36),
                            Expanded(
                              flex: 6,
                              child: SizedBox(
                                height: 320,
                                child: _HeroPreview(
                                  project: project,
                                  spec: spec,
                                  isArabic: isArabic,
                                  wide: true,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HeroCopy(
                              project: project,
                              spec: spec,
                              isArabic: isArabic,
                              compact: true,
                            ),
                            const SizedBox(height: 22),
                            SizedBox(
                              height: 220,
                              child: _HeroPreview(
                                project: project,
                                spec: spec,
                                isArabic: isArabic,
                                wide: false,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.project,
    required this.spec,
    required this.isArabic,
    required this.compact,
  });

  final ProjectModel project;
  final ProjectDetailSpec spec;
  final bool isArabic;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 2,
                decoration: const BoxDecoration(color: _gold),
              ),
              const SizedBox(width: 10),
              Text(
                spec.eyebrow.toUpperCase(),
                style: _bodyStyle(
                  isArabic: isArabic,
                  size: compact ? 9.5 : 10.5,
                  color: _gold,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            project.title,
            style: _displayStyle(
              isArabic: isArabic,
              size: compact ? 28 : 42,
              weight: FontWeight.w700,
              height: 1.12,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            spec.focus,
            style: _bodyStyle(
              isArabic: isArabic,
              size: compact ? 12.5 : 14.5,
              color: _ink.withValues(alpha: .84),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (project.category != null)
                _MetaChip(label: project.category!, color: _aqua),
              if (project.role != null)
                _MetaChip(label: project.role!, color: Colors.white70),
              if (project.status != null)
                _MetaChip(label: project.status!, color: _gold),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPreview extends StatelessWidget {
  const _HeroPreview({
    required this.project,
    required this.spec,
    required this.isArabic,
    required this.wide,
  });

  final ProjectModel project;
  final ProjectDetailSpec spec;
  final bool isArabic;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final images = <String>[];
    for (final image in project.featuredImages ?? const <String>[]) {
      images.add(image);
    }
    if (images.isEmpty && project.imageUrl != null) {
      images.add(project.imageUrl!);
    }
    if (images.isEmpty) {
      return _EmojiStage(project: project, spec: spec, isArabic: isArabic);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        switch (spec.kind) {
          case ProjectSpecKind.website:
            return _WebsiteStage(
              images: images,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            );
          case ProjectSpecKind.mobile:
          case ProjectSpecKind.product:
            return _PhoneStage(
              asset: images.first,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            );
          case ProjectSpecKind.platform:
          case ProjectSpecKind.ecosystem:
            return _SplitStage(
              images: images,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            );
          default:
            return _PanelStage(
              asset: images.first,
              project: project,
              spec: spec,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            );
        }
      },
    );
  }
}

class _WebsiteStage extends StatelessWidget {
  const _WebsiteStage({
    required this.images,
    required this.width,
    required this.height,
  });

  final List<String> images;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final browserHeight = math.min(height * .84, (width * .9) / 1.6 + 38);
    final browserWidth = (browserHeight - 38) * 1.6;
    final browserLeft = math.max(0.0, (width - browserWidth) / 2 + width * .05);
    final phoneHeight = browserHeight * .60;
    final phoneWidth = (phoneHeight - 10) * (345 / 723) + 10;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: browserLeft,
            top: math.max(0.0, (height - browserHeight) / 2),
            child: _BrowserPreview(
              asset: images.first,
              width: browserWidth,
              height: browserHeight,
            ),
          ),
          if (images.length > 1)
            Positioned(
              left: math.max(0.0, browserLeft - phoneWidth * .28),
              top: math.max(
                0.0,
                (height + browserHeight) / 2 - phoneHeight - 6,
              ),
              child: _PhonePreview(
                asset: images[1],
                width: phoneWidth,
                height: phoneHeight,
              ),
            ),
        ],
      ),
    );
  }
}

class _SplitStage extends StatelessWidget {
  const _SplitStage({
    required this.images,
    required this.width,
    required this.height,
  });

  final List<String> images;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final browserHeight = math.min(height * .82, (width * .86) / 1.6 + 38);
    final browserWidth = (browserHeight - 38) * 1.6;
    final browserLeft = math.max(0.0, (width - browserWidth) / 2 + width * .04);
    final phoneHeight = browserHeight * .62;
    final phoneWidth = phoneHeight * .45;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: browserLeft,
            top: math.max(0.0, (height - browserHeight) / 2),
            child: _BrowserPreview(
              asset: images.first,
              width: browserWidth,
              height: browserHeight,
            ),
          ),
          if (images.length > 1)
            Positioned(
              left: math.max(0.0, browserLeft + browserWidth * .6),
              top: math.max(0.0, (height + browserHeight) / 2 - phoneHeight),
              child: _PhonePreview(
                asset: images[1],
                width: phoneWidth,
                height: phoneHeight,
              ),
            ),
        ],
      ),
    );
  }
}

class _PhoneStage extends StatelessWidget {
  const _PhoneStage({
    required this.asset,
    required this.width,
    required this.height,
  });

  final String asset;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final phoneHeight = math.min(height * .94, 320.0);
    final phoneWidth = math.min(width * .52, phoneHeight * .47);
    return Center(
      child: _PhonePreview(
        asset: asset,
        width: phoneWidth,
        height: phoneHeight,
      ),
    );
  }
}

class _PanelStage extends StatelessWidget {
  const _PanelStage({
    required this.asset,
    required this.project,
    required this.spec,
    required this.width,
    required this.height,
  });

  final String asset;
  final ProjectModel project;
  final ProjectDetailSpec spec;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final panelWidth = math.min(width * .82, 420.0);
    final panelHeight = math.min(height * .88, 260.0);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: panelWidth,
          height: panelHeight,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _panelDark.withValues(alpha: .72),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: .12)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 28,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: OptimizedImage.asset(
              assetName: asset,
              fit: BoxFit.contain,
              priority: ImageLoadPriority.high,
              lazy: false,
              placeholderIcon: Icons.image_outlined,
              errorIcon: Icons.image_not_supported_outlined,
            ),
          ),
        ),
        Positioned(
          right: math.max(0.0, width * .06),
          bottom: 6,
          child: _OrbBadge(emoji: project.emoji, color: _gold),
        ),
      ],
    );
  }
}

class _EmojiStage extends StatelessWidget {
  const _EmojiStage({
    required this.project,
    required this.spec,
    required this.isArabic,
  });

  final ProjectModel project;
  final ProjectDetailSpec spec;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 230,
          height: 230,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _aqua.withValues(alpha: .20)),
          ),
        ),
        Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _gold.withValues(alpha: .28)),
          ),
        ),
        _OrbBadge(emoji: project.emoji, color: _gold, size: 118),
        Positioned(
          bottom: 0,
          child: Text(
            spec.eyebrow,
            textAlign: TextAlign.center,
            style: _bodyStyle(
              isArabic: isArabic,
              size: 10,
              color: Colors.white.withValues(alpha: .55),
              weight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _OrbBadge extends StatelessWidget {
  const _OrbBadge({
    required this.emoji,
    required this.color,
    this.size = 58,
  });

  final String emoji;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: .32),
            color.withValues(alpha: .06),
          ],
        ),
        border: Border.all(color: color.withValues(alpha: .45)),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: .18), blurRadius: 26),
        ],
      ),
      child: Text(emoji, style: TextStyle(fontSize: size * .44)),
    );
  }
}

class _BrowserPreview extends StatelessWidget {
  const _BrowserPreview({
    required this.asset,
    required this.width,
    required this.height,
  });

  final String asset;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _panelDark.withValues(alpha: .92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: .14)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x77000000),
            blurRadius: 30,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .05),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                for (final dot in [_gold, _aqua, Colors.white38])
                  Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dot,
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: .28),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: OptimizedImage.asset(
                  assetName: asset,
                  fit: BoxFit.contain,
                  priority: ImageLoadPriority.high,
                  lazy: false,
                  placeholderIcon: Icons.image_outlined,
                  errorIcon: Icons.image_not_supported_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhonePreview extends StatelessWidget {
  const _PhonePreview({
    required this.asset,
    required this.width,
    required this.height,
  });

  final String asset;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE6FBFB), Color(0xFF74B6BC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x88000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: OptimizedImage.asset(
          assetName: asset,
          fit: BoxFit.contain,
          priority: ImageLoadPriority.high,
          lazy: false,
          placeholderIcon: Icons.image_outlined,
          errorIcon: Icons.image_not_supported_outlined,
        ),
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  const _DetailsBody({
    required this.project,
    required this.spec,
    required this.isArabic,
  });

  final ProjectModel project;
  final ProjectDetailSpec spec;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 900;
    final main = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _buildMainSections(),
    );
    final rail = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _buildRailSections(),
    );

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 7, child: main),
          const SizedBox(width: 28),
          Expanded(flex: 4, child: rail),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ..._buildMainSections().take(2),
        const SizedBox(height: 24),
        rail,
        const SizedBox(height: 24),
        ..._buildMainSections().skip(2),
      ],
    );
  }

  List<Widget> _buildMainSections() {
    final sections = <Widget>[];

    sections.add(
      _SectionHeading(
        number: '01',
        eyebrow: isArabic ? 'الفكرة' : 'The idea',
        title: isArabic ? 'نظرة عامة' : 'Overview',
      ),
    );
    sections.add(const SizedBox(height: 14));
    sections.add(
      _GlassCard(
        child: Text(
          project.overview ?? project.description,
          style: _bodyStyle(
            isArabic: isArabic,
            size: 15,
            color: _ink.withValues(alpha: .88),
            height: 1.75,
          ),
        ),
      ),
    );
    sections.add(const SizedBox(height: 30));

    sections.add(
      _SectionHeading(
        number: '02',
        eyebrow: isArabic ? 'طريقة التفكير' : 'How it was shaped',
        title: isArabic ? 'مسار المشروع' : 'Project workflow',
      ),
    );
    sections.add(const SizedBox(height: 14));
    sections.add(
      spec.kind == ProjectSpecKind.automation
          ? _PipelineFlow(steps: spec.steps, isArabic: isArabic)
          : _SpecSteps(steps: spec.steps, isArabic: isArabic),
    );
    sections.add(const SizedBox(height: 30));

    final narrative = _narrativeBlocks;
    if (narrative.isNotEmpty) {
      sections.add(
        _SectionHeading(
          number: '03',
          eyebrow: isArabic ? 'تفاصيل إضافية' : 'Additional notes',
          title: isArabic ? 'ما وراء التنفيذ' : 'Behind the build',
        ),
      );
      sections.add(const SizedBox(height: 14));
      sections.addAll(
        narrative.expand(
          (block) => <Widget>[
            _NarrativeCard(block: block, isArabic: isArabic),
            const SizedBox(height: 12),
          ],
        ),
      );
      sections.add(const SizedBox(height: 18));
    }

    if (project.detailedSections?.isNotEmpty ?? false) {
      sections.add(
        _SectionHeading(
          number: '04',
          eyebrow: isArabic ? 'غوص أعمق' : 'Deep dive',
          title: isArabic ? 'الهيكل التفصيلي' : 'Project structure',
        ),
      );
      sections.add(const SizedBox(height: 14));
      sections.addAll(
        project.detailedSections!.expand(
          (section) => <Widget>[
            _DetailSectionCard(section: section, isArabic: isArabic),
            const SizedBox(height: 12),
          ],
        ),
      );
      sections.add(const SizedBox(height: 30));
    }

    if (project.websiteComparison != null) {
      sections.add(
        _SectionHeading(
          number: '05',
          eyebrow: isArabic ? 'مقارنة مباشرة' : 'Side by side',
          title: isArabic ? 'مقارنة الموقع' : 'Website comparison',
        ),
      );
      sections.add(const SizedBox(height: 14));
      sections.add(
        FadeInUp(
          child: WebsiteComparisonCard(
            comparison: project.websiteComparison!,
            isArabic: isArabic,
          ),
        ),
      );
      sections.add(const SizedBox(height: 30));
    }

    sections.add(
      _SectionHeading(
        number: '06',
        eyebrow: isArabic ? 'الشاشات' : 'Screens',
        title: spec.galleryLabel,
      ),
    );
    sections.add(const SizedBox(height: 14));
    sections.add(_GallerySection(spec: spec, project: project));
    sections.add(const SizedBox(height: 30));

    sections.add(
      _SectionHeading(
        number: '07',
        eyebrow: isArabic ? 'النتيجة' : 'Closing note',
        title: isArabic ? 'الحالة والوصول' : 'Status & access',
      ),
    );
    sections.add(const SizedBox(height: 14));
    sections.add(_OutcomePanel(project: project, isArabic: isArabic));

    return sections;
  }

  List<Widget> _buildRailSections() {
    return [
      _SpecRail(spec: spec, project: project, isArabic: isArabic),
      const SizedBox(height: 20),
      _TechPanel(project: project, isArabic: isArabic),
      if (project.relatedProjects?.isNotEmpty ?? false) ...[
        const SizedBox(height: 20),
        _RelatedPanel(projects: project.relatedProjects!, isArabic: isArabic),
      ],
    ];
  }

  List<_NarrativeBlock> get _narrativeBlocks {
    final blocks = <_NarrativeBlock>[];
    void add(String? body, String arTitle, String enTitle, String icon) {
      if (body == null || body.trim().isEmpty) return;
      blocks.add(
        _NarrativeBlock(
          title: isArabic ? arTitle : enTitle,
          body: body,
          icon: icon,
        ),
      );
    }

    void addList(
        List<String>? items, String arTitle, String enTitle, String icon) {
      if (items == null || items.isEmpty) return;
      add(items.map((item) => '• $item').join('\n'), arTitle, enTitle, icon);
    }

    add(project.challenge, 'التحدي', 'The challenge', '🎯');
    addList(project.objectives, 'الأهداف', 'Objectives', '🧭');
    add(project.approach, 'المنهج', 'My approach', '🛠️');
    add(project.designAndUx, 'التصميم وتجربة المستخدم', 'Design & UX', '🎨');
    add(project.development, 'التنفيذ', 'Development', '⚙️');
    addList(project.keyFeatures, 'المميزات الأساسية', 'Key features', '✨');
    addList(project.responsibilities, 'مسؤولياتي', 'Responsibilities', '🙋');

    if (project.challenges != null) {
      final body = project.challenges!
          .map(
            (item) =>
                '${isArabic ? 'التحدي' : 'Challenge'}: ${item.challenge}\n'
                '${isArabic ? 'الحل' : 'Solution'}: ${item.solution}',
          )
          .join('\n\n');
      add(body, 'التحديات والحلول', 'Challenges & solutions', '🧩');
    }

    return blocks;
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.number,
    required this.eyebrow,
    required this.title,
  });

  final String number;
  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isArabic = LocaleProvider.isArabic.value;
    return FadeInUp(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 4,
            height: 42,
            decoration: BoxDecoration(
              color: _gold,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow.toUpperCase(),
                  style: _bodyStyle(
                    isArabic: isArabic,
                    size: 10,
                    color: _gold,
                    weight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  style: _displayStyle(
                    isArabic: isArabic,
                    size: 22,
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Text(
            number,
            style: _bodyStyle(
              isArabic: isArabic,
              size: 12,
              color: _aqua.withValues(alpha: .7),
              weight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child, this.padding = 22});

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _panel.withValues(alpha: .82),
              _panelDark.withValues(alpha: .92),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: _aqua.withValues(alpha: .14)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .24),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class _PipelineFlow extends StatelessWidget {
  const _PipelineFlow({required this.steps, required this.isArabic});

  final List<ProjectSpecStep> steps;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _panel.withValues(alpha: .82),
              _panelDark.withValues(alpha: .5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: _aqua.withValues(alpha: .16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.account_tree_outlined, color: _gold, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isArabic
                        ? 'تدفق الخط من المصدر إلى التسليم'
                        : 'Source-to-delivery pipeline',
                    style: _displayStyle(
                      isArabic: isArabic,
                      size: 14,
                      weight: FontWeight.w700,
                      color: _aqua,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            for (var i = 0; i < steps.length; i++) ...[
              _PipelineNode(
                step: steps[i],
                index: i + 1,
                isArabic: isArabic,
              ),
              if (i != steps.length - 1) const _PipelineConnector(),
            ],
          ],
        ),
      ),
    );
  }
}

class _PipelineConnector extends StatelessWidget {
  const _PipelineConnector();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: [
          Container(width: 2, height: 18, color: _aqua.withValues(alpha: .32)),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16,
            color: _gold.withValues(alpha: .85),
          ),
        ],
      ),
    );
  }
}

class _PipelineNode extends StatelessWidget {
  const _PipelineNode({
    required this.step,
    required this.index,
    required this.isArabic,
  });

  final ProjectSpecStep step;
  final int index;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: index * 35),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .035),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: .07)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OrbBadge(
              emoji: step.icon,
              color: index == 1 ? _gold : _aqua,
              size: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isArabic
                            ? 'المرحلة ${index.toString().padLeft(2, '0')}'
                            : 'STAGE ${index.toString().padLeft(2, '0')}',
                        style: _bodyStyle(
                          isArabic: isArabic,
                          size: 10,
                          color: _gold.withValues(alpha: .85),
                          weight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      if (step.tool != null)
                        Flexible(
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: _PipelineToolChip(label: step.tool!),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    step.title,
                    style: _displayStyle(
                      isArabic: isArabic,
                      size: 14,
                      weight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step.body,
                    style: _bodyStyle(
                      isArabic: isArabic,
                      size: 12,
                      color: _ink.withValues(alpha: .72),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PipelineToolChip extends StatelessWidget {
  const _PipelineToolChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _aqua.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _aqua.withValues(alpha: .22)),
      ),
      child: Text(
        label,
        style: _bodyStyle(
          isArabic: false,
          size: 9.5,
          color: _aqua,
          weight: FontWeight.w700,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _SpecSteps extends StatelessWidget {
  const _SpecSteps({required this.steps, required this.isArabic});

  final List<ProjectSpecStep> steps;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          _StepCard(
            step: steps[i],
            index: i + 1,
            isArabic: isArabic,
          ),
          if (i != steps.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.step,
    required this.index,
    required this.isArabic,
  });

  final ProjectSpecStep step;
  final int index;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _panel.withValues(alpha: .66),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: .07)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OrbBadge(emoji: step.icon, color: _aqua, size: 44),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: _displayStyle(
                      isArabic: isArabic,
                      size: 15,
                      weight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step.body,
                    style: _bodyStyle(
                      isArabic: isArabic,
                      size: 12.5,
                      color: _ink.withValues(alpha: .72),
                      height: 1.65,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              index.toString().padLeft(2, '0'),
              style: _bodyStyle(
                isArabic: isArabic,
                size: 11,
                color: _gold.withValues(alpha: .8),
                weight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NarrativeCard extends StatelessWidget {
  const _NarrativeCard({required this.block, required this.isArabic});

  final _NarrativeBlock block;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      padding: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(block.icon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              Text(
                block.title,
                style: _displayStyle(
                  isArabic: isArabic,
                  size: 16,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            block.body,
            style: _bodyStyle(
              isArabic: isArabic,
              size: 13,
              color: _ink.withValues(alpha: .76),
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailSectionCard extends StatelessWidget {
  const _DetailSectionCard({required this.section, required this.isArabic});

  final ProjectDetailSection section;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      padding: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _gold.withValues(alpha: .10),
                  border: Border.all(color: _gold.withValues(alpha: .28)),
                ),
                child: Text(section.iconEmoji ?? '✦',
                    style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  section.title,
                  style: _displayStyle(
                    isArabic: isArabic,
                    size: 17,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            section.content,
            style: _bodyStyle(
              isArabic: isArabic,
              size: 13.5,
              color: _ink.withValues(alpha: .78),
              height: 1.75,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecRail extends StatelessWidget {
  const _SpecRail({
    required this.spec,
    required this.project,
    required this.isArabic,
  });

  final ProjectDetailSpec spec;
  final ProjectModel project;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 10) / 2;
        return _GlassCard(
          padding: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isArabic ? 'مواصفات المشروع' : 'Project specification',
                style: _displayStyle(
                  isArabic: isArabic,
                  size: 17,
                  weight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final stat in spec.stats)
                    SizedBox(
                      width: cardWidth,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _panelDark.withValues(alpha: .72),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _aqua.withValues(alpha: .14),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stat.value,
                              style: _displayStyle(
                                isArabic: isArabic,
                                size: 17,
                                color: _gold,
                                weight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              stat.label,
                              style: _bodyStyle(
                                isArabic: isArabic,
                                size: 10.5,
                                color: _ink.withValues(alpha: .62),
                                weight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              const Divider(color: Color(0x22FFFFFF), height: 1),
              const SizedBox(height: 16),
              _FactRow(
                icon: Icons.category_outlined,
                label: isArabic ? 'التصنيف' : 'Category',
                value: project.category ??
                    (isArabic ? 'مشروع تصميم وتطوير' : 'Design & build'),
                isArabic: isArabic,
              ),
              if (project.role != null)
                _FactRow(
                  icon: Icons.person_outline,
                  label: isArabic ? 'الدور' : 'Role',
                  value: project.role!,
                  isArabic: isArabic,
                ),
              if (project.completionDate != null)
                _FactRow(
                  icon: Icons.calendar_month_outlined,
                  label: isArabic ? 'السنة' : 'Year',
                  value: project.completionDate!,
                  isArabic: isArabic,
                ),
              if (project.status != null)
                _FactRow(
                  icon: Icons.flag_outlined,
                  label: isArabic ? 'الحالة' : 'Status',
                  value: project.status!,
                  isArabic: isArabic,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isArabic,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: _aqua),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: _bodyStyle(
                    isArabic: isArabic,
                    size: 9,
                    color: Colors.white.withValues(alpha: .42),
                    weight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: _bodyStyle(
                    isArabic: isArabic,
                    size: 12,
                    color: _ink.withValues(alpha: .85),
                    weight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechPanel extends StatelessWidget {
  const _TechPanel({required this.project, required this.isArabic});

  final ProjectModel project;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final items = project.techStack ??
        project.technologies
            .map((name) => ProjectTechStackItem(name: name, role: ''))
            .toList();

    return _GlassCard(
      padding: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'التقنيات' : 'Technical stack',
            style: _displayStyle(
              isArabic: isArabic,
              size: 17,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in items)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _aqua.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _aqua.withValues(alpha: .22)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: _bodyStyle(
                          isArabic: isArabic,
                          size: 11.5,
                          color: Colors.white,
                          weight: FontWeight.w700,
                        ),
                      ),
                      if (item.role.isNotEmpty)
                        Text(
                          item.role,
                          style: _bodyStyle(
                            isArabic: isArabic,
                            size: 9.5,
                            color: _ink.withValues(alpha: .52),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RelatedPanel extends StatelessWidget {
  const _RelatedPanel({
    required this.projects,
    required this.isArabic,
  });

  final List<String> projects;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      padding: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'ذات صلة' : 'Related',
            style: _displayStyle(
              isArabic: isArabic,
              size: 17,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in projects)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .04),
                    borderRadius: BorderRadius.circular(999),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: .08)),
                  ),
                  child: Text(
                    item,
                    style: _bodyStyle(
                      isArabic: isArabic,
                      size: 11,
                      color: _ink.withValues(alpha: .72),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GallerySection extends StatelessWidget {
  const _GallerySection({
    required this.spec,
    required this.project,
  });

  final ProjectDetailSpec spec;
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final isArabic = LocaleProvider.isArabic.value;
    final items = <ProjectGalleryItem>[];
    final seen = <String>{};

    void add(ProjectGalleryItem item) {
      if (seen.add(item.imageUrl)) items.add(item);
    }

    final featuredItems = (project.featuredImages ?? const <String>[])
        .map(
          (asset) => ProjectGalleryItem(
            title: project.title,
            imageUrl: asset,
          ),
        )
        .toList();
    final galleryItems = project.gallery ?? const <ProjectGalleryItem>[];
    final phoneShowcaseProject = project.featuredVisual == 'mobile';
    final desktopShowcaseProject = project.featuredVisual == 'desktop' ||
        project.featuredVisual == 'desktop-robot';

    if (phoneShowcaseProject || desktopShowcaseProject) {
      for (final item in galleryItems) {
        add(item);
      }
    }
    for (final item in featuredItems) {
      add(item);
    }
    if (!phoneShowcaseProject && !desktopShowcaseProject) {
      for (final item in galleryItems) {
        add(item);
      }
    }
    if (items.isEmpty && project.imageUrl != null) {
      add(
        ProjectGalleryItem(
          title: project.title,
          imageUrl: project.imageUrl!,
          caption: project.subtitle,
        ),
      );
    }

    if (items.isEmpty) {
      return _GlassCard(
        child: Text(
          isArabic
              ? 'لا توجد شاشات متاحة لهذا المشروع.'
              : 'No screens available for this project.',
          style: _bodyStyle(
            isArabic: isArabic,
            size: 13,
            color: _ink.withValues(alpha: .6),
          ),
        ),
      );
    }

    final phoneShowcase = phoneShowcaseProject && items.length > 1;
    final desktopShowcase = desktopShowcaseProject && items.isNotEmpty;

    return LayoutBuilder(
      builder: (context, constraints) {
        final mobileLike = spec.kind == ProjectSpecKind.mobile ||
            spec.kind == ProjectSpecKind.product;
        final websiteLike = spec.kind == ProjectSpecKind.website;
        final maxCard = mobileLike ? 230.0 : (websiteLike ? 520.0 : 360.0);
        final cardWidth = math.min(
          maxCard,
          constraints.maxWidth > 720
              ? (constraints.maxWidth - 16) / 2
              : constraints.maxWidth,
        );
        final imageHeight = mobileLike ? 310.0 : (websiteLike ? 210.0 : 230.0);
        final remaining =
            phoneShowcase || desktopShowcase ? items.skip(2).toList() : items;
        final cards = <Widget>[
          for (final item in remaining)
            SizedBox(
              width: cardWidth,
              child: _GalleryCard(
                item: item,
                imageHeight: imageHeight,
                isArabic: isArabic,
              ),
            ),
        ];

        if (desktopShowcase) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DesktopShowcaseCard(
                items: items.take(2).toList(),
                withRobot: project.featuredVisual == 'desktop-robot',
                isArabic: isArabic,
              ),
              if (cards.isNotEmpty) ...[
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: cards,
                ),
              ],
            ],
          );
        }

        if (phoneShowcase) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PhoneShowcaseCard(
                items: items.take(2).toList(),
                isArabic: isArabic,
              ),
              if (cards.isNotEmpty) ...[
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: cards,
                ),
              ],
            ],
          );
        }

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: cards,
        );
      },
    );
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({
    required this.item,
    required this.imageHeight,
    required this.isArabic,
  });

  final ProjectGalleryItem item;
  final double imageHeight;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        decoration: BoxDecoration(
          color: _panelDark.withValues(alpha: .78),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: .08)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: imageHeight,
              width: double.infinity,
              color: const Color(0x66081418),
              padding: const EdgeInsets.all(12),
              child: OptimizedImage.asset(
                assetName: item.imageUrl,
                fit: BoxFit.contain,
                priority: ImageLoadPriority.normal,
                lazy: true,
                placeholderIcon: Icons.image_outlined,
                errorIcon: Icons.image_not_supported_outlined,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: _displayStyle(
                      isArabic: isArabic,
                      size: 13,
                      weight: FontWeight.w700,
                    ),
                  ),
                  if (item.caption != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      item.caption!,
                      style: _bodyStyle(
                        isArabic: isArabic,
                        size: 11,
                        color: _ink.withValues(alpha: .58),
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopShowcaseCard extends StatelessWidget {
  const _DesktopShowcaseCard({
    required this.items,
    required this.withRobot,
    required this.isArabic,
  });

  final List<ProjectGalleryItem> items;
  final bool withRobot;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: LayoutBuilder(
        builder: (context, constraints) {
          const aspect = 1.6;
          final width = constraints.maxWidth;
          final stageHeight = width > 720 ? 260.0 : 215.0;
          final pcWidth = math.min(
            width * (withRobot ? .72 : .9),
            (stageHeight - 8) * aspect + 12,
          );
          final screenHeight = (pcWidth - 12) / aspect;
          final pcHeight = screenHeight + 34;
          final pcLeft = withRobot ? width * .25 : (width - pcWidth) / 2;
          final pcTop = (stageHeight - pcHeight) / 2;
          final robotSize = math.min(
            math.min(width * .28, stageHeight * .7),
            pcHeight * .85,
          );
          final robotLeft = math.max(
            -robotSize * .38,
            pcLeft - robotSize * 1.08,
          );
          final robotTop = pcTop + (pcHeight - robotSize) * .88;
          final first = items.first;
          final second = withRobot && items.length > 1 ? items[1] : null;

          return Container(
            decoration: BoxDecoration(
              color: _panelDark.withValues(alpha: .78),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: .08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: stageHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (second != null)
                        Positioned(
                          left: robotLeft,
                          top: robotTop,
                          child: Container(
                            width: robotSize,
                            height: robotSize,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: _aqua.withValues(alpha: .22),
                                  blurRadius: 30,
                                ),
                              ],
                            ),
                            child: OptimizedImage.asset(
                              assetName: second.imageUrl,
                              fit: BoxFit.contain,
                              priority: ImageLoadPriority.low,
                              lazy: true,
                              placeholderIcon: Icons.image_outlined,
                              errorIcon: Icons.image_not_supported_outlined,
                            ),
                          ),
                        ),
                      Positioned(
                        left: pcLeft,
                        top: pcTop,
                        child: _DetailPcFrame(
                          asset: first.imageUrl,
                          width: pcWidth,
                          screenHeight: screenHeight,
                          priority: ImageLoadPriority.high,
                          lazy: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        first.title,
                        style: _displayStyle(
                          isArabic: isArabic,
                          size: 14,
                          weight: FontWeight.w700,
                        ),
                      ),
                      if (first.caption != null) ...[
                        const SizedBox(height: 5),
                        Text(
                          first.caption!,
                          style: _bodyStyle(
                            isArabic: isArabic,
                            size: 11,
                            color: _ink.withValues(alpha: .58),
                            height: 1.5,
                          ),
                        ),
                      ],
                      if (second != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          second.title,
                          style: _displayStyle(
                            isArabic: isArabic,
                            size: 12,
                            weight: FontWeight.w600,
                            color: _aqua,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DetailPcFrame extends StatelessWidget {
  const _DetailPcFrame({
    required this.asset,
    required this.width,
    required this.screenHeight,
    this.priority = ImageLoadPriority.normal,
    this.lazy = true,
  });

  final String asset;
  final double width;
  final double screenHeight;
  final ImageLoadPriority priority;
  final bool lazy;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width,
            height: screenHeight + 10,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1B242B), Color(0xFF05080C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: const Color(0x668DA3A8), width: 1),
              borderRadius: BorderRadius.circular(9),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x99000000),
                  blurRadius: 22,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ColoredBox(
                color: const Color(0xFF0D2B31),
                child: OptimizedImage.asset(
                  assetName: asset,
                  fit: BoxFit.contain,
                  priority: priority,
                  lazy: lazy,
                  placeholderIcon: Icons.image_outlined,
                  errorIcon: Icons.image_not_supported_outlined,
                ),
              ),
            ),
          ),
          Container(
            width: width * .3,
            height: 11,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE6FBFB), Color(0xFF7C9DA3)],
              ),
            ),
          ),
          Container(
            width: width * .1,
            height: 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE6FBFB), Color(0xFF7C9DA3)],
              ),
            ),
          ),
        ],
      );
}

class _PhoneShowcaseCard extends StatelessWidget {
  const _PhoneShowcaseCard({
    required this.items,
    required this.isArabic,
  });

  final List<ProjectGalleryItem> items;
  final bool isArabic;

  static const _screenAspects = <String, double>{
    'assets/images/Login Page.png': 430 / 932,
    'assets/images/Main Page.png': 428 / 913,
    'assets/images/doctor_leandek_login.png': 400 / 862,
    'assets/images/doctor_leandek_main.png': 387 / 852,
  };

  double _aspect(String asset) => _screenAspects[asset] ?? .4688;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 620;
        final frameHeight = compact ? 230.0 : 300.0;
        final captionWidth = compact ? 132.0 : 168.0;
        final children = <Widget>[];

        for (var index = 0; index < items.length && index < 2; index++) {
          final item = items[index];
          children.add(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DetailPhoneFrame(
                  asset: item.imageUrl,
                  height: frameHeight,
                  aspectRatio: _aspect(item.imageUrl),
                  angle: index == 0 ? -.07 : .07,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: captionWidth,
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: _displayStyle(
                      isArabic: isArabic,
                      size: compact ? 11 : 13,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),
                if (item.caption != null) ...[
                  const SizedBox(height: 4),
                  SizedBox(
                    width: captionWidth,
                    child: Text(
                      item.caption!,
                      textAlign: TextAlign.center,
                      style: _bodyStyle(
                        isArabic: isArabic,
                        size: compact ? 9 : 10,
                        color: _ink.withValues(alpha: .6),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
          if (index == 0) children.add(const SizedBox(width: 18));
        }

        return FadeInUp(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(compact ? 14 : 22),
            decoration: BoxDecoration(
              color: _panelDark.withValues(alpha: .78),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white.withValues(alpha: .08)),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DetailPhoneFrame extends StatelessWidget {
  const _DetailPhoneFrame({
    required this.asset,
    required this.height,
    required this.aspectRatio,
    required this.angle,
  });

  final String asset;
  final double height;
  final double aspectRatio;
  final double angle;

  @override
  Widget build(BuildContext context) {
    final width = (height - 10) * aspectRatio + 10;
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
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x99000000),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: const Color(0xFF0D2B31),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: OptimizedImage.asset(
                        assetName: asset,
                        fit: BoxFit.contain,
                        priority: ImageLoadPriority.normal,
                        lazy: true,
                        placeholderIcon: Icons.image_outlined,
                        errorIcon: Icons.image_not_supported_outlined,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: width * .28,
                top: 6,
                child: Container(
                  width: width * .44,
                  height: 8,
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

class _OutcomePanel extends StatelessWidget {
  const _OutcomePanel({required this.project, required this.isArabic});

  final ProjectModel project;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (project.status != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.verified_rounded, color: _gold, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    project.status!,
                    style: _bodyStyle(
                      isArabic: isArabic,
                      size: 13,
                      color: _gold,
                      weight: FontWeight.w700,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          if (project.status != null &&
              (project.liveUrl != null || project.githubUrl != null))
            const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              if (project.liveUrl != null)
                _ActionLink(
                  label: isArabic ? 'فتح المشروع' : 'Open project',
                  url: project.liveUrl!,
                  icon: Icons.language_rounded,
                  primary: true,
                  isArabic: isArabic,
                ),
              if (project.githubUrl != null)
                _ActionLink(
                  label: isArabic ? 'المصدر' : 'Source code',
                  url: project.githubUrl!,
                  icon: Icons.code_rounded,
                  primary: false,
                  isArabic: isArabic,
                ),
              if (project.liveUrl == null && project.githubUrl == null)
                Text(
                  isArabic
                      ? 'هذا المشروع معروض كدراسة تصميم وتنفيذ ضمن الملف الشخصي.'
                      : 'This project is presented as a design and implementation case study.',
                  style: _bodyStyle(
                    isArabic: isArabic,
                    size: 12.5,
                    color: _ink.withValues(alpha: .62),
                    height: 1.6,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionLink extends StatelessWidget {
  const _ActionLink({
    required this.label,
    required this.url,
    required this.icon,
    required this.primary,
    required this.isArabic,
  });

  final String label;
  final String url;
  final IconData icon;
  final bool primary;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          color: primary ? _gold : _gold.withValues(alpha: .06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _gold.withValues(alpha: primary ? 1 : .38),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: primary ? _deep : _gold,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: _bodyStyle(
                isArabic: isArabic,
                size: 12,
                color: primary ? _deep : _gold,
                weight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isArabic = LocaleProvider.isArabic.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: .12)),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: _bodyStyle(
          isArabic: isArabic,
          size: 10.5,
          color: color,
          weight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _NarrativeBlock {
  const _NarrativeBlock({
    required this.title,
    required this.body,
    required this.icon,
  });

  final String title;
  final String body;
  final String icon;
}

TextStyle _displayStyle({
  required bool isArabic,
  required double size,
  Color color = Colors.white,
  FontWeight weight = FontWeight.w600,
  double height = 1.25,
}) {
  final font = isArabic ? GoogleFonts.cairo : GoogleFonts.poppins;
  return font(
    color: color,
    fontSize: size,
    fontWeight: weight,
    height: height,
  );
}

TextStyle _bodyStyle({
  required bool isArabic,
  required double size,
  Color color = _ink,
  FontWeight weight = FontWeight.w400,
  double height = 1.55,
}) {
  final font = isArabic ? GoogleFonts.cairo : GoogleFonts.inter;
  return font(
    color: color,
    fontSize: size,
    fontWeight: weight,
    height: height,
  );
}
