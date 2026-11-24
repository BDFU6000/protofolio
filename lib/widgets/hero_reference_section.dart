import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';
import '../utils/cv_generator.dart';
import '../utils/locale_provider.dart';
import '../utils/responsive_helper.dart';
import '../widgets/optimized_image.dart';

class HeroReferenceSection extends StatelessWidget {
  const HeroReferenceSection({
    super.key,
    required this.toolsKey,
    required this.onViewWork,
  });

  final GlobalKey toolsKey;
  final VoidCallback onViewWork;

  @override
  Widget build(BuildContext context) {
    final viewportWidth = MediaQuery.sizeOf(context).width;
    final contentWidth = (viewportWidth -
            (viewportWidth > 1200 ? 72 : (viewportWidth > 700 ? 56 : 32)))
        .clamp(0.0, 1280.0);
    final isWide = contentWidth > 760;
    final isPhone = context.isPhone;
    final heroHeight = MediaQuery.sizeOf(context).height.clamp(740.0, 900.0);
    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) => SizedBox(
        width: double.infinity,
        height: isWide ? heroHeight : null,
        child: Stack(
          children: [
            Positioned.fill(
                child: CustomPaint(painter: _HeroBackdropPainter())),
            if (isWide) ...[
              Positioned(
                left: 90,
                top: 205,
                width: contentWidth * .57,
                child: _HeroCopy(isArabic: isArabic, onViewWork: onViewWork),
              ),
              Positioned(
                right: 40,
                top: 105,
                bottom: 150,
                width: contentWidth * .40,
                child: const _Portrait(),
              ),
              Positioned(
                left: 74,
                right: 74,
                bottom: 54,
                child: _ToolsPanel(key: toolsKey, isArabic: isArabic),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 12,
                child: _ScrollHint(isArabic: isArabic),
              ),
            ] else ...[
              Padding(
                padding: EdgeInsets.fromLTRB(
                    AppLayout.mobileGutter, 96, AppLayout.mobileGutter, 36),
                child: Column(
                  children: [
                    SizedBox(height: isPhone ? 220 : 300, child: _Portrait()),
                    const SizedBox(height: 18),
                    _HeroCopy(isArabic: isArabic, onViewWork: onViewWork),
                    const SizedBox(height: 30),
                    _ToolsPanel(key: toolsKey, isArabic: isArabic),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HeroBackdropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final goldPaint = Paint()..color = const Color(0xFFFFC900);
    canvas.drawCircle(Offset(-size.width * .06, -size.height * .10),
        size.width * .19, goldPaint);
    canvas.drawCircle(Offset(size.width * .88, size.height * .38),
        size.width * .22, goldPaint);
    canvas.drawCircle(Offset(-size.width * .08, size.height * .73),
        size.width * .19, goldPaint);
  }

  @override
  bool shouldRepaint(covariant _HeroBackdropPainter oldDelegate) => false;
}

class _Portrait extends StatelessWidget {
  const _Portrait();

  @override
  Widget build(BuildContext context) => OptimizedImage.asset(
        assetName: 'assets/images/Moneeb.png',
        alignment: Alignment.bottomCenter,
        fit: BoxFit.contain,
        priority: ImageLoadPriority.high,
        lazy: false,
        placeholderIcon: Icons.person,
        errorIcon: Icons.person,
      );
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.isArabic, required this.onViewWork});

  final bool isArabic;
  final VoidCallback onViewWork;

  static const _gold = Color(0xFFFFC900);
  static const _aqua = Color(0xFF4EDDE3);

  @override
  Widget build(BuildContext context) {
    final isWide = context.screenWidth > 760;
    final isPhone = context.isPhone;
    final headlineSize = isWide ? 27.0 : (isPhone ? 22.0 : 25.0);
    return Column(
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            style: (isArabic ? GoogleFonts.cairo : GoogleFonts.orbitron)(
              fontSize: headlineSize,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: headlineSize * (isPhone ? .06 : .2),
              shadows: const [
                Shadow(
                    color: Color(0xAA00D4FF),
                    offset: Offset(2, 2),
                    blurRadius: 2)
              ],
            ),
            children: [
              TextSpan(
                  text: isArabic ? 'أصمم وأبني ' : 'Design & Build ',
                  style: const TextStyle(color: Colors.white)),
              if (isArabic)
                const TextSpan(
                  text: 'منتجات رقمية ذكية',
                  style: TextStyle(color: _aqua),
                )
              else ...[
                const TextSpan(
                  text: 'Intelligent\n',
                  style: TextStyle(color: _gold),
                ),
                const TextSpan(
                  text: 'Digital Products',
                  style: TextStyle(color: _aqua),
                ),
              ],
            ],
          ),
          textAlign: isWide ? TextAlign.left : TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text.rich(
          TextSpan(
            style: (isArabic ? GoogleFonts.cairo : GoogleFonts.inter)(
                fontSize: isWide ? 16 : 14, letterSpacing: 1.2),
            children: [
              TextSpan(
                  text: isArabic ? 'الاسم: ' : 'Eng: ',
                  style: const TextStyle(color: _gold)),
              TextSpan(
                  text: PortfolioData.name,
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          textAlign: isWide ? TextAlign.left : TextAlign.center,
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            isArabic
                ? 'خريج علوم حاسوب من جامعة الرفاق، أعمل على تطوير البرمجيات وتطبيقات Flutter والويب، وتصميم UI/UX، وأتمتة الأعمال.'
                : 'I am a Computer Science graduate from Refak University at date February 2026 with hands-on experience across full-stack software development, Flutter and mobile app development, web development, UI/UX design, AI-powered automation, and business workflow analysis.',
            textAlign: isWide ? TextAlign.left : TextAlign.center,
            style: (isArabic ? GoogleFonts.cairo : GoogleFonts.inter)(
              color: Colors.white.withValues(alpha: .88),
              fontSize: isWide ? 13 : 14,
              height: 1.6,
              letterSpacing: isWide ? 1.0 : .2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        if (isPhone)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroButton(
                  label: isArabic ? 'شاهد أعمالي' : 'View My Work',
                  filled: true,
                  onTap: onViewWork),
              const SizedBox(height: 12),
              _HeroButton(
                  label: isArabic ? 'تحميل السيرة الذاتية' : 'Download CV',
                  filled: false,
                  onTap: () => _showCvLanguageDialog(context)),
            ],
          )
        else
          Wrap(
            alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              _HeroButton(
                  label: isArabic ? 'شاهد أعمالي' : 'View My Work',
                  filled: true,
                  onTap: onViewWork),
              _HeroButton(
                  label: isArabic ? 'تحميل السيرة الذاتية' : 'Download CV',
                  filled: false,
                  onTap: () => _showCvLanguageDialog(context)),
            ],
          ),
      ],
    );
  }

  Future<void> _showCvLanguageDialog(BuildContext context) async {
    final bool? language;
    if (context.isPhone) {
      language = await showModalBottomSheet<bool>(
        context: context,
        backgroundColor: const Color(0xFF06454A),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        builder: (sheetContext) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                child: Text(
                  isArabic ? 'اختر لغة السيرة الذاتية' : 'Select CV language',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language, color: Color(0xFF69E4E6)),
                title: const Text('English',
                    style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(sheetContext, false),
              ),
              ListTile(
                leading: const Icon(Icons.language, color: Color(0xFF69E4E6)),
                title: const Text('العربية',
                    style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(sheetContext, true),
              ),
            ],
          ),
        ),
      );
    } else {
      language = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: const Color(0xFF06454A),
          title: Text(
              isArabic ? 'اختر لغة السيرة الذاتية' : 'Select CV language',
              style: const TextStyle(color: Colors.white)),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('English')),
            TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('العربية')),
          ],
        ),
      );
    }
    if (language == null || !context.mounted) return;
    await _downloadCv(context, language);
  }

  Future<void> _downloadCv(BuildContext context, bool arabic) async {
    try {
      await CVGenerator.generateAndDownload(isArabic: arabic);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isArabic ? 'تم تحميل السيرة الذاتية' : 'CV downloaded'),
        ),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isArabic
              ? 'تعذر تحميل السيرة الذاتية.'
              : 'Could not download the CV.'),
        ),
      );
    }
  }
}

class _HeroButton extends StatelessWidget {
  const _HeroButton(
      {required this.label, required this.filled, required this.onTap});

  final String label;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: filled ? const Color(0xFF12383A) : Colors.white,
        side: filled
            ? BorderSide.none
            : const BorderSide(color: Color(0xFF62DADD)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        minimumSize: const Size(0, AppLayout.minTouchTarget),
        shadowColor: Color(0xFF62DADD).withOpacity(0.25),
      ),
      child: Text(
        label,
        style: (LocaleProvider.isArabic.value
            ? GoogleFonts.cairo
            : GoogleFonts.inter)(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (!filled) return button;
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFC800), Color(0xFF997800)],
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: button,
    );
  }
}

class _ScrollHint extends StatelessWidget {
  const _ScrollHint({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isArabic ? 'تابع للأسفل للاستكشاف' : 'Scroll to explore',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: .58),
              fontSize: 9,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF4EDDE3), size: 15),
        ],
      );
}

class _ToolsPanel extends StatelessWidget {
  const _ToolsPanel({super.key, required this.isArabic});

  final bool isArabic;

  static const _tools = <(String, String)>[
    ('Flutter\nDart', 'assets/images/Flutter_logo.png'),
    ('Figma', 'assets/images/figma_logo.png'),
    ('Supabase', 'assets/images/supabase_logo.png'),
    ('Firebase', 'assets/images/firebase_logo.png'),
    ('Python', 'assets/images/python_logo.png'),
    ('PostgreSQL', 'assets/images/postgresql_logo.png'),
    ('APIs & REST\nAPI', 'assets/images/API&Rest_API_logo.png'),
    ('C#', 'assets/images/C#_logo.png'),
    ('GitHub', 'assets/images/Github_logo.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = context.screenWidth > 760;
    final isPhone = context.isPhone;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF124B50).withValues(alpha: .88),
        border: Border.all(color: const Color(0xFF178D93)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
              color: Color(0xAA4EDDE3), blurRadius: 4, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF0B555B),
              border: Border.all(color: const Color(0xFF167C82)),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              isArabic ? 'الأدوات والتقنيات' : 'Tools & Technologies',
              style: (isArabic ? GoogleFonts.cairo : GoogleFonts.inter)(
                  color: const Color(0xFF69E4E6), fontSize: 11),
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = wide ? 9 : (isPhone ? 2 : 4);
              final width =
                  (constraints.maxWidth - (columns - 1) * 12) / columns;
              return Wrap(
                spacing: 12,
                runSpacing: 10,
                children: [
                  for (final (label, logoPath) in _tools)
                    SizedBox(
                      width: width,
                      height: isPhone ? 84 : 90,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A4046),
                          border: Border.all(color: const Color(0xFF176B72)),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: isPhone ? 36 : 40,
                              height: isPhone ? 36 : 40,
                              child: OptimizedImage.asset(
                                assetName: logoPath,
                                fit: BoxFit.contain,
                                priority: ImageLoadPriority.normal,
                                lazy: false,
                                placeholderIcon: Icons.image_outlined,
                                errorIcon: Icons.broken_image_outlined,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(label,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: isPhone ? 11 : 9,
                                    height: 1.15)),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
