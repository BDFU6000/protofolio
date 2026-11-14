import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';
import '../utils/locale_provider.dart';

const _englishAboutCopy =
    '''My experience spans healthcare technology, business automation, ERP customization, and digital product development. I've contributed to projects including Smart Clinic, Sidaliti, Doctor Leandek, and Tamayoz Al-Da'em.

I approach development from a product perspective, combining business analysis, UI/UX design, frontend and backend development, API integration, and database management.

Beyond software development, I've explored AI automation, lead generation, and Libyan Arabic speech research, while gaining experience in team leadership, technical coordination, and project delivery.''';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.onContactTap});

  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 760;
    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        final paragraphs = (isArabic
                ? PortfolioData.bio.split('\n\n').first
                : _englishAboutCopy)
            .split('\n\n');

        return Padding(
          padding: EdgeInsets.fromLTRB(0, isWide ? 50 : 34, 0, 54),
          child: isWide
              ? _desktopLayout(context, paragraphs, isArabic)
              : _mobileLayout(context, paragraphs, isArabic),
        );
      },
    );
  }

  Widget _desktopLayout(
    BuildContext context,
    List<String> paragraphs,
    bool isArabic,
  ) {
    final width = MediaQuery.sizeOf(context).width;
    final contentWidth =
        (width > 1200 ? 600.0 : width * .52).clamp(450.0, 620.0);
    final portraitWidth =
        (width > 1200 ? 440.0 : width * .39).clamp(340.0, 470.0);

    return Column(
      children: [
        SizedBox(
          height: 610,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: portraitWidth,
                child: const _PortraitComposition(),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: contentWidth,
                child: _AboutContent(
                  paragraphs: paragraphs,
                  isArabic: isArabic,
                  onContactTap: onContactTap,
                  compact: false,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        _AboutStats(isArabic: isArabic),
      ],
    );
  }

  Widget _mobileLayout(
    BuildContext context,
    List<String> paragraphs,
    bool isArabic,
  ) =>
      Column(
        children: [
          const SizedBox(height: 300, child: _PortraitComposition()),
          const SizedBox(height: 24),
          _AboutContent(
            paragraphs: paragraphs,
            isArabic: isArabic,
            onContactTap: onContactTap,
            compact: true,
          ),
          const SizedBox(height: 22),
          _AboutStats(isArabic: isArabic),
        ],
      );
}

class _AboutContent extends StatelessWidget {
  const _AboutContent({
    required this.paragraphs,
    required this.isArabic,
    required this.onContactTap,
    required this.compact,
  });

  final List<String> paragraphs;
  final bool isArabic;
  final VoidCallback onContactTap;
  final bool compact;

  static const _cyan = Color(0xFF00D9F5);
  static const _gold = Color(0xFFFFC900);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: compact ? 0 : 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pill
              Container(
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
                    Text(
                      isArabic ? '٠١ — نبذة عني' : 'About Me.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF69E4E6),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: compact ? 18 : 20),
              _AboutHeadline(isArabic: isArabic, compact: compact),
              const SizedBox(height: 13),
              Container(
                width: 140,
                height: 3,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [_cyan, _gold]),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: compact ? 20 : 22),
        for (var index = 0; index < paragraphs.length; index++) ...[
          _AboutParagraph(
            text: paragraphs[index],
            icon: switch (index) {
              0 => Icons.school_rounded,
              1 => Icons.code_rounded,
              _ => Icons.memory_rounded,
            },
            isArabic: isArabic,
          ),
          if (index != paragraphs.length - 1) const SizedBox(height: 12),
        ],
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: onContactTap,
          style: FilledButton.styleFrom(
            backgroundColor: _gold,
            foregroundColor: const Color(0xFF032D35),
            elevation: 8,
            shadowColor: _gold.withValues(alpha: .5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          icon: const Icon(Icons.send_rounded, size: 17),
          label: Text(
            isArabic ? 'لنتواصل' : "Let's Connect",
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _AboutHeadline extends StatelessWidget {
  const _AboutHeadline({required this.isArabic, required this.compact});

  final bool isArabic;
  final bool compact;

  static const _gold = Color(0xFFFFC900);

  @override
  Widget build(BuildContext context) {
    final size = compact ? 28.0 : 34.0;
    final baseStyle = (isArabic ? GoogleFonts.cairo : GoogleFonts.orbitron)(
      fontSize: size,
      fontWeight: FontWeight.w800,
      height: 1.14,
      letterSpacing: compact ? 1 : .4,
      shadows: const [
        Shadow(color: Color(0x8855DDF4), offset: Offset(0, 3), blurRadius: 8),
      ],
    );

    if (isArabic) {
      return Text(
        'ما وراء الكود، هدفٌ واضح.',
        style: baseStyle.copyWith(color: Colors.white),
      );
    }

    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: const [
          TextSpan(
            text: 'Beyond the Code\n',
            style: TextStyle(color: Color(0xFFE9FCFF)),
          ),
          TextSpan(
            text: 'Driven by Purpose.',
            style: TextStyle(color: _gold),
          ),
        ],
      ),
    );
  }
}

class _AboutParagraph extends StatelessWidget {
  const _AboutParagraph({
    required this.text,
    required this.icon,
    required this.isArabic,
  });

  final String text;
  final IconData icon;
  final bool isArabic;

  static const _cyan = Color(0xFF00D9F5);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _cyan.withValues(alpha: .08),
              border: Border.all(color: _cyan.withValues(alpha: .8)),
              boxShadow: [
                BoxShadow(color: _cyan.withValues(alpha: .15), blurRadius: 8),
              ],
            ),
            child: Icon(icon, size: 19, color: _cyan),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: (isArabic ? GoogleFonts.cairo : GoogleFonts.inter)(
                color: const Color(0xFFE5F5F7),
                fontSize: 11,
                height: 1.42,
                letterSpacing: .05,
              ),
            ),
          ),
        ],
      );
}

class _PortraitComposition extends StatelessWidget {
  const _PortraitComposition();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final portraitSize = math.min(
              constraints.maxHeight * 1.08, constraints.maxWidth * 1.04);
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(child: CustomPaint(painter: _TechOrbitPainter())),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: portraitSize,
                child: Image.asset(
                  'assets/images/moneeb2.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.person,
                    size: 180,
                    color: Color(0xFFDAF8FA),
                  ),
                ),
              ),
              const Positioned(top: 45, left: 12, child: _FloatingCodeIcon()),
              const Positioned(top: 115, right: 4, child: _LaptopBadge()),
              const Positioned(right: 0, top: 230, child: _ProcessBadge()),
            ],
          );
        },
      );
}

class _FloatingCodeIcon extends StatelessWidget {
  const _FloatingCodeIcon();

  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: -.08,
        child: Container(
          width: 84,
          height: 82,
          decoration: BoxDecoration(
            color: const Color(0xFF064B58).withValues(alpha: .78),
            border: Border.all(color: const Color(0xFF00D9F5)),
            borderRadius: BorderRadius.circular(13),
            boxShadow: const [
              BoxShadow(color: Color(0x7700D9F5), blurRadius: 18),
            ],
          ),
          child: const Icon(Icons.code_rounded,
              color: Color(0xFF72F0FF), size: 42),
        ),
      );
}

class _LaptopBadge extends StatelessWidget {
  const _LaptopBadge();

  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: .13,
        child: Container(
          width: 82,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF063E49),
            border: Border.all(color: const Color(0xFF00D9F5), width: 3),
            borderRadius: BorderRadius.circular(7),
            boxShadow: const [
              BoxShadow(color: Color(0x6600D9F5), blurRadius: 16)
            ],
          ),
          child: const Icon(Icons.code_rounded,
              color: Color(0xFF53E8F4), size: 30),
        ),
      );
}

class _ProcessBadge extends StatelessWidget {
  const _ProcessBadge();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF053C47).withValues(alpha: .9),
          border: Border.all(color: const Color(0xFF00D9F5)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Color(0x5500D9F5), blurRadius: 16)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final label in const ['Analyze', 'Develop', 'Deploy'])
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_box_outlined,
                        color: Color(0xFF00D9F5), size: 15),
                    const SizedBox(width: 5),
                    Text(label,
                        style: GoogleFonts.inter(
                            color: const Color(0xFFBFEFF3), fontSize: 10)),
                  ],
                ),
              ),
          ],
        ),
      );
}

class _TechOrbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * .52, size.height * .52);
    final radius = size.shortestSide * .42;
    final cyan = Paint()
      ..color = const Color(0xFF00D9F5).withValues(alpha: .48)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final gold = Paint()
      ..color = const Color(0xFFFFC900).withValues(alpha: .9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius), -.8, 2.4, false, cyan);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 18), 1.1,
        2.5, false, gold);

    final dotPaint = Paint()
      ..color = const Color(0xFF00D9F5).withValues(alpha: .36);
    for (var row = 0; row < 5; row++) {
      for (var column = 0; column < 5; column++) {
        canvas.drawCircle(
            Offset(20 + column * 14, 12 + row * 14), 1.4, dotPaint);
        canvas.drawCircle(
            Offset(size.width - 22 - column * 14, size.height - 70 + row * 14),
            1.4,
            dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TechOrbitPainter oldDelegate) => false;
}

class _AboutStats extends StatelessWidget {
  const _AboutStats({required this.isArabic});

  final bool isArabic;

  static const _cyan = Color(0xFF00D9F5);

  @override
  Widget build(BuildContext context) {
    final stats = isArabic
        ? [
            _StatData(Icons.work_outline_rounded, '8+', 'أشهر من الخبرة'),
            _StatData(Icons.rocket_launch_rounded, '10+', 'مشاريع منجزة'),
            _StatData(Icons.school_outlined, 'علوم الحاسوب', 'جامعة الرفاق'),
            _StatData(Icons.star_border_rounded, 'تعلم دائم', 'ابتكار مستمر'),
          ]
        : [
            _StatData(Icons.work_outline_rounded, '8+', 'Months Experience'),
            _StatData(Icons.rocket_launch_rounded, '10+', 'Projects Delivered'),
            _StatData(
                Icons.school_outlined, 'Computer Science', 'Refak University'),
            _StatData(Icons.star_border_rounded, 'Always Learning',
                'Always Innovating'),
          ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF03323D).withValues(alpha: .82),
        border: Border.all(color: _cyan.withValues(alpha: .8)),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: _cyan.withValues(alpha: .12), blurRadius: 20),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth > 680 ? 4 : 2;
          return Wrap(
            children: [
              for (var index = 0; index < stats.length; index++)
                SizedBox(
                  width: constraints.maxWidth / columns,
                  child: _StatItem(
                    data: stats[index],
                    showDivider: index % columns != columns - 1 &&
                        index != stats.length - 1,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _StatData {
  const _StatData(this.icon, this.value, this.label);

  final IconData icon;
  final String value;
  final String label;
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.data, required this.showDivider});

  final _StatData data;
  final bool showDivider;

  @override
  Widget build(BuildContext context) => Container(
        constraints: const BoxConstraints(minHeight: 62),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(right: BorderSide(color: Color(0x4443DDEC)))
              : null,
        ),
        child: Row(
          children: [
            Icon(data.icon, color: const Color(0xFF00D9F5), size: 32),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          color: const Color(0xFFFFC900),
                          fontWeight: FontWeight.w800,
                          fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(data.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          color: const Color(0xFF58E3EE), fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      );
}
