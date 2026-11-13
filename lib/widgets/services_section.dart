import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/locale_provider.dart';

const _bg = Color(0xFF032D32);
const _aqua = Color(0xFF52D8DE);
const _gold = Color(0xFFFFC900);
const _surface = Color(0xFF062F35);
const _border = Color(0xFF16818A);

class _ServiceData {
  const _ServiceData({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.tags,
    required this.image,
    required this.icon,
  });
  final String index;
  final String title;
  final String subtitle;
  final String description;
  final List<String> tags;
  final String image;
  final IconData icon;
}

const _en = [
  _ServiceData(
    index: '01',
    title: 'Custom Software',
    subtitle: 'Development',
    description:
        'End-to-end web and mobile applications built around your exact business requirements — from architecture and UI/UX design through to production deployment.',
    tags: ['Flutter', 'Web Apps', 'Mobile', 'UI/UX Design'],
    image: 'assets/images/Custom Software Development.png',
    icon: Icons.code_rounded,
  ),
  _ServiceData(
    index: '02',
    title: 'AI & Workflow',
    subtitle: 'Automation',
    description:
        'Connect your business tools, eliminate repetitive work, and unlock intelligent decision-making through API integrations and AI-powered pipelines.',
    tags: ['AI Integration', 'REST APIs', 'Automation', 'Python'],
    image: 'assets/images/AI & Workflow Automation.png',
    icon: Icons.auto_awesome_rounded,
  ),
  _ServiceData(
    index: '03',
    title: 'Business Website',
    subtitle: 'Development',
    description:
        'Modern, fast, and responsive websites crafted to establish credibility, communicate your brand, and convert visitors into real business enquiries.',
    tags: ['Web Design', 'Responsive', 'SEO-Ready', 'Lead Capture'],
    image: 'assets/images/Business Website Development.png',
    icon: Icons.language_rounded,
  ),
];

const _ar = [
  _ServiceData(
    index: '٠١',
    title: 'تطوير البرمجيات',
    subtitle: 'المخصصة',
    description:
        'تطبيقات ويب وهاتف متكاملة مبنية حول متطلبات عملك — من التصميم والهندسة إلى النشر الإنتاجي.',
    tags: ['Flutter', 'تطبيقات الويب', 'الهاتف', 'UI/UX'],
    image: 'assets/images/Custom Software Development.png',
    icon: Icons.code_rounded,
  ),
  _ServiceData(
    index: '٠٢',
    title: 'الذكاء الاصطناعي',
    subtitle: 'والأتمتة',
    description:
        'ربط أدوات الأعمال وأتمتة المهام المتكررة وتمكين القرارات الذكية عبر تكاملات API وخطوط أنابيب الذكاء الاصطناعي.',
    tags: ['تكامل AI', 'REST APIs', 'أتمتة', 'Python'],
    image: 'assets/images/AI & Workflow Automation.png',
    icon: Icons.auto_awesome_rounded,
  ),
  _ServiceData(
    index: '٠٣',
    title: 'تطوير مواقع',
    subtitle: 'الأعمال',
    description:
        'مواقع حديثة وسريعة ومتجاوبة لبناء المصداقية وإيصال هوية علامتك التجارية وتحويل الزوار إلى عملاء.',
    tags: ['تصميم', 'متجاوب', 'SEO', 'استقطاب العملاء'],
    image: 'assets/images/Business Website Development.png',
    icon: Icons.language_rounded,
  ),
];

// ── Section ───────────────────────────────────────────────────────────────────
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 860;
    final hPad = width > 1200 ? 74.0 : width > 700 ? 40.0 : 20.0;

    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        final services = isArabic ? _ar : _en;

        return Container(
          width: double.infinity,
          color: _bg,
          child: Stack(
            children: [
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(painter: _GlowPainter()),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(hPad, 80, hPad, 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(isArabic: isArabic, isWide: isWide),
                    SizedBox(height: isWide ? 64 : 44),
                    for (var i = 0; i < services.length; i++) ...[
                      if (i > 0)
                        Divider(
                          color: _aqua.withValues(alpha: .12),
                          height: 32,
                        ),
                      _ServiceRow(
                        service: services[i],
                        isWide: isWide,
                        imageRight: i.isEven,
                        isArabic: isArabic,
                      ),
                    ],
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

// ── Glow painter ──────────────────────────────────────────────────────────────
class _GlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    void blob(Offset c, double r, Color color) => canvas.drawCircle(
          c,
          r,
          Paint()
            ..color = color
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120),
        );
    blob(Offset(size.width * .08, size.height * .15), size.width * .18,
        const Color(0xFF00D4FF).withValues(alpha: .07));
    blob(Offset(size.width * .92, size.height * .5), size.width * .22,
        const Color(0xFFFFC900).withValues(alpha: .06));
    blob(Offset(size.width * .5, size.height * .88), size.width * .2,
        const Color(0xFF52D8DE).withValues(alpha: .05));
  }

  @override
  bool shouldRepaint(covariant _GlowPainter old) => false;
}

// ── Section header ────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.isArabic, required this.isWide});
  final bool isArabic;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF073F45),
            border: Border.all(color: _border),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, size: 9, color: Color(0xFF69E4E6)),
              const SizedBox(width: 6),
              Text(
                isArabic ? 'ماذا أقدم' : 'What I Do.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF69E4E6),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Text.rich(
          TextSpan(
            style: (isArabic ? GoogleFonts.cairo : GoogleFonts.orbitron)(
              color: Colors.white,
              fontSize: isWide ? 36 : 26,
              fontWeight: FontWeight.w700,
              letterSpacing: isWide ? 4 : 1.5,
              height: 1.2,
              shadows: const [
                Shadow(
                    color: Color(0xAA00D4FF),
                    offset: Offset(2, 2),
                    blurRadius: 3),
              ],
            ),
            children: [
              TextSpan(text: isArabic ? 'خدمات ' : 'Services '),
              TextSpan(
                text: isArabic ? 'أقدمها.' : 'I Deliver.',
                style: const TextStyle(color: _gold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            isArabic
                ? 'من البرمجيات المخصصة إلى الأتمتة الذكية ومواقع الأعمال — أحوّل الأفكار إلى منتجات رقمية حقيقية.'
                : 'From custom software to intelligent automation and business websites — I turn ideas into real digital products.',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: .7),
              fontSize: 13,
              height: 1.75,
              letterSpacing: .6,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Service row ───────────────────────────────────────────────────────────────
class _ServiceRow extends StatefulWidget {
  const _ServiceRow({
    required this.service,
    required this.isWide,
    required this.imageRight,
    required this.isArabic,
  });
  final _ServiceData service;
  final bool isWide;
  final bool imageRight;
  final bool isArabic;

  @override
  State<_ServiceRow> createState() => _ServiceRowState();
}

class _ServiceRowState extends State<_ServiceRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.service;

    if (!widget.isWide) {
      return _MobileCard(service: s, isArabic: widget.isArabic);
    }

    final content = _RowContent(
        service: s, hovered: _hovered, isArabic: widget.isArabic);
    final image = _RowImage(service: s, hovered: _hovered);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _hovered ? _gold.withValues(alpha: .04) : Colors.transparent,
          border: Border.all(
            color:
                _hovered ? _gold.withValues(alpha: .25) : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.imageRight
              ? [content, const SizedBox(width: 48), image]
              : [image, const SizedBox(width: 48), content],
        ),
      ),
    );
  }
}

// ── Row content ───────────────────────────────────────────────────────────────
class _RowContent extends StatelessWidget {
  const _RowContent({
    required this.service,
    required this.hovered,
    required this.isArabic,
  });
  final _ServiceData service;
  final bool hovered;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service.index,
            style: GoogleFonts.orbitron(
              color: hovered ? _gold : _aqua.withValues(alpha: .45),
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                height: 1.15,
              ),
              children: [
                TextSpan(text: '${service.title}\n'),
                TextSpan(
                  text: service.subtitle,
                  style: TextStyle(color: hovered ? _gold : _aqua),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            width: hovered ? 160 : 80,
            height: 2,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_aqua, _gold]),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            service.description,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: .72),
              fontSize: 13,
              height: 1.7,
              letterSpacing: .3,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final tag in service.tags)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _aqua.withValues(alpha: .08),
                    border: Border.all(color: _aqua.withValues(alpha: .2)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFC9FAFB),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
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

// ── Row image ─────────────────────────────────────────────────────────────────
class _RowImage extends StatelessWidget {
  const _RowImage({required this.service, required this.hovered});
  final _ServiceData service;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      width: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: hovered
              ? _gold.withValues(alpha: .35)
              : _aqua.withValues(alpha: .12),
        ),
        boxShadow: hovered
            ? [
                BoxShadow(
                  color: _gold.withValues(alpha: .12),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          service.image,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Padding(
            padding: const EdgeInsets.all(48),
            child:
                Icon(service.icon, color: _aqua.withValues(alpha: .3), size: 56),
          ),
        ),
      ),
    );
  }
}

// ── Mobile card ───────────────────────────────────────────────────────────────
class _MobileCard extends StatelessWidget {
  const _MobileCard({required this.service, required this.isArabic});
  final _ServiceData service;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: .6),
        border: Border.all(color: _aqua.withValues(alpha: .18)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image — free, no fixed height, shows fully
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(
                  service.image,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Padding(
                    padding: const EdgeInsets.all(32),
                    child: Icon(service.icon,
                        color: _aqua.withValues(alpha: .3), size: 48),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.index,
                      style: GoogleFonts.orbitron(
                        color: _gold,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        children: [
                          TextSpan(text: '${service.title} '),
                          TextSpan(
                            text: service.subtitle,
                            style: const TextStyle(color: _aqua),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 60,
                      height: 2,
                      decoration: BoxDecoration(
                        gradient:
                            const LinearGradient(colors: [_aqua, _gold]),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      service.description,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: .72),
                        fontSize: 12,
                        height: 1.65,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (final tag in service.tags)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(
                              color: _aqua.withValues(alpha: .08),
                              border: Border.all(
                                  color: _aqua.withValues(alpha: .2)),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              tag,
                              style: GoogleFonts.inter(
                                color: const Color(0xFFC9FAFB),
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
