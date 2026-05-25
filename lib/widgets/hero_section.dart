import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../utils/cv_generator.dart';
import '../utils/locale_provider.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late AnimationController _roleController;
  int _roleIndex = 0;
  Offset _mouseOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _roleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _startRoleCycle();
  }

  void _startRoleCycle() {
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      _roleController.forward(from: 0).then((_) {
        if (!mounted) return;
        setState(() {
          _roleIndex = (_roleIndex + 1) % PortfolioData.roles.length;
        });
        _roleController.reverse().then((_) => _startRoleCycle());
      });
    });
  }

  @override
  void dispose() {
    _bgController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _updateMouseOffset(PointerEvent details) {
    if (!mounted) return;
    final size = MediaQuery.of(context).size;
    setState(() {
      _mouseOffset = Offset(
        (details.position.dx - size.width / 2) / (size.width / 2),
        (details.position.dy - size.height / 2) / (size.height / 2),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        return MouseRegion(
          onHover: _updateMouseOffset,
          child: Container(
            width: double.infinity,
            height: null,
            constraints: BoxConstraints(minHeight: isWide ? size.height : 700),
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    transform: Matrix4.translationValues(
                      _mouseOffset.dx * -30,
                      _mouseOffset.dy * -30,
                      0,
                    ),
                    child: _AnimatedBackground(controller: _bgController),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isWide ? 40 : 20,
                        vertical: isWide ? 100 : 80),
                    child: isWide
                        ? Row(
                            key: const ValueKey('hero_row_desktop'),
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _HeroText(
                                  key: const ValueKey('hero_text_desktop'),
                                  roleIndex: _roleIndex,
                                  roleController: _roleController,
                                  onLaunch: _launch,
                                  isArabic: isArabic,
                                  isWide: isWide,
                                ),
                              ),
                              const SizedBox(width: 60),
                              AnimatedContainer(
                                key: const ValueKey(
                                    'hero_avatar_desktop_container'),
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                transform: Matrix4.translationValues(
                                  _mouseOffset.dx * 20,
                                  _mouseOffset.dy * 20,
                                  0,
                                ),
                                child: _HeroAvatar(
                                  key: const ValueKey('hero_avatar_desktop'),
                                  isArabic: isArabic,
                                  isWide: isWide,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            key: const ValueKey('hero_column_mobile'),
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40), // spacer for top nav
                              _HeroAvatar(
                                key: const ValueKey('hero_avatar_mobile'),
                                isArabic: isArabic,
                                isWide: isWide,
                              ),
                              const SizedBox(height: 40),
                              _HeroText(
                                key: const ValueKey('hero_text_mobile'),
                                roleIndex: _roleIndex,
                                roleController: _roleController,
                                onLaunch: _launch,
                                isArabic: isArabic,
                                isWide: isWide,
                              ),
                            ],
                          ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: _ScrollIndicator(isArabic: isArabic),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Animated background ───────────────────────────────────────────────────────

class _AnimatedBackground extends StatelessWidget {
  const _AnimatedBackground({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => CustomPaint(
        painter: _OrbPainter(controller.value),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _OrbPainter extends CustomPainter {
  _OrbPainter(this.progress);
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final angle = progress * 2 * math.pi;
    final cx = size.width / 2;
    final cy = size.height / 2;

    void drawOrb(Offset center, double radius, Color color) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [color.withOpacity(0.35), Colors.transparent],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    drawOrb(
      Offset(cx + math.cos(angle) * cx * 0.5, cy - math.sin(angle) * cy * 0.4),
      size.width * 0.35,
      const Color(0xFF00D4FF),
    );
    drawOrb(
      Offset(cx - math.cos(angle) * cx * 0.4, cy + math.sin(angle) * cy * 0.35),
      size.width * 0.28,
      const Color(0xFF7B2FFF),
    );
  }

  @override
  bool shouldRepaint(_OrbPainter old) => old.progress != progress;
}

// ── Hero text ─────────────────────────────────────────────────────────────────

class _HeroText extends StatelessWidget {
  const _HeroText({
    super.key,
    required this.roleIndex,
    required this.roleController,
    required this.onLaunch,
    required this.isArabic,
    required this.isWide,
  });

  final int roleIndex;
  final AnimationController roleController;
  final Future<void> Function(String) onLaunch;
  final bool isArabic;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final nameFontSize = isWide ? 56.0 : (size.width > 500 ? 44.0 : 30.0);
    final roleFontSize = isWide ? 28.0 : (size.width > 500 ? 24.0 : 19.0);

    return Column(
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting chip
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color(0xFF00D4FF).withOpacity(0.5)),
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF00D4FF).withOpacity(0.08),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('👋', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(
                  isArabic ? 'أهلاً بكم في عالمي!' : 'Hello, World!',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF00D4FF),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Name
        FadeInDown(
          delay: const Duration(milliseconds: 200),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, Color(0xFF00D4FF)],
              stops: [0.5, 1.0],
            ).createShader(bounds),
            child: Text(
              isArabic
                  ? 'أنا ${PortfolioData.name}'
                  : "I'm ${PortfolioData.name}",
              textAlign: isWide ? TextAlign.start : TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: nameFontSize,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Animated role
        FadeInDown(
          delay: const Duration(milliseconds: 400),
          child: AnimatedBuilder(
            animation: roleController,
            builder: (_, __) => Opacity(
              opacity: (1 - roleController.value).clamp(0.0, 1.0),
              child: Row(
                mainAxisAlignment:
                    isWide ? MainAxisAlignment.start : MainAxisAlignment.center,
                children: [
                  Container(
                    width: 4,
                    height: 32,
                    margin: const EdgeInsetsDirectional.only(end: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00D4FF), Color(0xFF7B2FFF)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Text(
                    PortfolioData.roles[roleIndex],
                    style: GoogleFonts.poppins(
                      fontSize: roleFontSize,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00D4FF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Tagline
        FadeInDown(
          delay: const Duration(milliseconds: 600),
          child: Text(
            PortfolioData.tagline,
            textAlign: isWide ? TextAlign.start : TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.white54,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 40),

        // CTA Buttons
        FadeInUp(
          delay: const Duration(milliseconds: 800),
          child: Wrap(
            alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              _GradientButton(
                label: isArabic ? 'شاهد أعمالي' : 'View My Work',
                icon: Icons.arrow_forward_rounded,
                onTap: () {},
              ),
              _OutlineButton(
                label: isArabic ? 'تحميل السيرة الذاتية' : 'Download CV',
                icon: Icons.download_rounded,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => Center(
                      child: Container(
                        width: 320,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A).withOpacity(0.95),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            )
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                isArabic ? 'اختر لغة السيرة الذاتية' : 'Select CV Language',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                isArabic
                                    ? 'اختر اللغة المفضلة لتنزيل السيرة الذاتية الخاصة بك.'
                                    : 'Choose your preferred language to download the CV.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: Colors.white54,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00D4FF).withOpacity(0.1),
                                  foregroundColor: const Color(0xFF00D4FF),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: const BorderSide(color: Color(0xFF00D4FF), width: 1),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'English Version',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.of(ctx).pop();
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => const _LoadingDialog(isArabic: false),
                                  );
                                  try {
                                    await CVGenerator.generateAndDownload(isArabic: false);
                                  } catch (_) {
                                  } finally {
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7B2FFF).withOpacity(0.1),
                                  foregroundColor: const Color(0xFF7B2FFF),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: const BorderSide(color: Color(0xFF7B2FFF), width: 1),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'النسخة العربية',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.of(ctx).pop();
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => const _LoadingDialog(isArabic: true),
                                  );
                                  try {
                                    await CVGenerator.generateAndDownload(isArabic: true);
                                  } catch (_) {
                                  } finally {
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),

        // Social links
        FadeInUp(
          delay: const Duration(milliseconds: 1000),
          child: Wrap(
            alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              Text(
                isArabic ? 'جدني على:' : 'Find me on:',
                style: GoogleFonts.inter(color: Colors.white38, fontSize: 13),
              ),
              const SizedBox(width: 8),
              _SocialChip(
                  label: 'GitHub',
                  emoji: '🐙',
                  url: PortfolioData.githubUrl,
                  onLaunch: onLaunch),
              _SocialChip(
                  label: 'LinkedIn',
                  emoji: '💼',
                  url: PortfolioData.linkedinUrl,
                  onLaunch: onLaunch),
              _SocialChip(
                  label: 'Twitter',
                  emoji: '🐦',
                  url: PortfolioData.twitterUrl,
                  onLaunch: onLaunch),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────────

class _HeroAvatar extends StatefulWidget {
  const _HeroAvatar({super.key, required this.isArabic, required this.isWide});
  final bool isArabic;
  final bool isWide;

  @override
  State<_HeroAvatar> createState() => _HeroAvatarState();
}

class _HeroAvatarState extends State<_HeroAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Scale avatar radius down gracefully on small devices to prevent overflow.
    final double avatarSize =
        widget.isWide ? 320.0 : (screenWidth - 80).clamp(180.0, 320.0);
    final double imageSize = avatarSize - 20.0;

    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: AnimatedBuilder(
        animation: _floatController,
        builder: (_, child) => Transform.translate(
          offset: Offset(0, _floatController.value * -12),
          child: child,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    const Color(0xFF00D4FF).withOpacity(0.6),
                    const Color(0xFF7B2FFF).withOpacity(0.6),
                    const Color(0xFF00D4FF).withOpacity(0.6),
                  ],
                ),
              ),
            ),
            ClipOval(
              child: Image.asset(
                'assets/images/Moneeb.jpg',
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: imageSize,
                  height: imageSize,
                  color: const Color(0xFF131A2A),
                  child: Center(
                    child: Text('👨🏻‍💻',
                        style: TextStyle(fontSize: avatarSize * 0.25)),
                  ),
                ),
              ),
            ),
            Positioned(
              top: avatarSize * 0.06,
              right: avatarSize * 0.03,
              child: _FloatingBadge(
                  emoji: '📱', label: widget.isArabic ? 'فلاتر' : 'Flutter'),
            ),
            Positioned(
              bottom: avatarSize * 0.06,
              left: avatarSize * 0.03,
              child: _FloatingBadge(
                  emoji: '🎨', label: widget.isArabic ? 'فيجما' : 'Figma'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  const _FloatingBadge({required this.emoji, required this.label});
  final String emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a2e),
        border: Border.all(color: const Color(0xFF00D4FF).withOpacity(0.4)),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(label,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// ── Buttons ───────────────────────────────────────────────────────────────────

class _GradientButton extends StatefulWidget {
  const _GradientButton(
      {required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00D4FF), Color(0xFF7B2FFF)],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: _hovered
                ? [
                    const BoxShadow(
                        color: Color(0x8000D4FF),
                        blurRadius: 24,
                        spreadRadius: 2)
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15)),
              const SizedBox(width: 8),
              Icon(widget.icon, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  const _OutlineButton(
      {required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF00D4FF).withOpacity(0.1)
                : Colors.transparent,
            border: Border.all(
              color: _hovered
                  ? const Color(0xFF00D4FF)
                  : const Color(0xFF00D4FF).withOpacity(0.5),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15)),
              const SizedBox(width: 8),
              Icon(widget.icon, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Social chip ───────────────────────────────────────────────────────────────

class _SocialChip extends StatefulWidget {
  const _SocialChip(
      {required this.label,
      required this.emoji,
      required this.url,
      required this.onLaunch});
  final String label, emoji, url;
  final Future<void> Function(String) onLaunch;

  @override
  State<_SocialChip> createState() => _SocialChipState();
}

class _SocialChipState extends State<_SocialChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onLaunch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF00D4FF).withOpacity(0.15)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: Colors.white.withOpacity(_hovered ? 0.3 : 0.1)),
          ),
          child: Row(
            children: [
              Text(widget.emoji, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text(widget.label,
                  style:
                      GoogleFonts.inter(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Scroll indicator ──────────────────────────────────────────────────────────

class _ScrollIndicator extends StatefulWidget {
  const _ScrollIndicator({required this.isArabic});
  final bool isArabic;

  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 8)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, _animation.value),
        child: Column(
          children: [
            Text(
              widget.isArabic ? 'انزل لأسفل' : 'Scroll down',
              style: GoogleFonts.inter(color: Colors.white24, fontSize: 12),
            ),
            const SizedBox(height: 6),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF00D4FF), size: 28),
          ],
        ),
      ),
    );
  }
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog({required this.isArabic});
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: FadeIn(
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: 280,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A).withOpacity(0.92),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF00D4FF).withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D4FF).withOpacity(0.15),
                  blurRadius: 30,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF00D4FF),
                          ),
                          backgroundColor: const Color(0xFF00D4FF).withOpacity(0.1),
                        ),
                      ),
                      const Icon(
                        Icons.picture_as_pdf_rounded,
                        color: Color(0xFF00D4FF),
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF00D4FF), Color(0xFF7B2FFF)],
                    ).createShader(bounds),
                    child: Text(
                      isArabic ? 'جاري تجهيز السيرة الذاتية' : 'Generating CV...',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isArabic ? 'يرجى الانتظار قليلاً...' : 'Please wait a moment...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
