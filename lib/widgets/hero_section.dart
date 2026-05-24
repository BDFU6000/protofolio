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
            height: isWide ? size.height : null,
            constraints:
                BoxConstraints(minHeight: isWide ? size.height : 700),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  transform: Matrix4.translationValues(
                    _mouseOffset.dx * -30,
                    _mouseOffset.dy * -30,
                    0,
                  ),
                  child: _AnimatedBackground(controller: _bgController),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 100),
                    child: isWide
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _HeroText(
                                  roleIndex: _roleIndex,
                                  roleController: _roleController,
                                  onLaunch: _launch,
                                  isArabic: isArabic,
                                ),
                              ),
                              const SizedBox(width: 60),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                transform: Matrix4.translationValues(
                                  _mouseOffset.dx * 20,
                                  _mouseOffset.dy * 20,
                                  0,
                                ),
                                child: _HeroAvatar(isArabic: isArabic),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _HeroAvatar(isArabic: isArabic),
                              const SizedBox(height: 40),
                              _HeroText(
                                roleIndex: _roleIndex,
                                roleController: _roleController,
                                onLaunch: _launch,
                                isArabic: isArabic,
                              ),
                            ],
                          ),
                  ),
                ),
                Positioned(
                  bottom: 32,
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
      Offset(cx + math.cos(angle) * cx * 0.5,
          cy - math.sin(angle) * cy * 0.4),
      size.width * 0.35,
      const Color(0xFF00D4FF),
    );
    drawOrb(
      Offset(cx - math.cos(angle) * cx * 0.4,
          cy + math.sin(angle) * cy * 0.35),
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
    required this.roleIndex,
    required this.roleController,
    required this.onLaunch,
    required this.isArabic,
  });

  final int roleIndex;
  final AnimationController roleController;
  final Future<void> Function(String) onLaunch;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting chip
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color(0xFF00D4FF).withOpacity(0.5)),
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
              style: GoogleFonts.poppins(
                fontSize: 56,
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
                      fontSize: 28,
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
            spacing: 16,
            runSpacing: 12,
            children: [
              _GradientButton(
                label: isArabic ? 'شاهد أعمالي' : 'View My Work',
                icon: Icons.arrow_forward_rounded,
                onTap: () {},
              ),
              _OutlineButton(
                label: isArabic
                    ? 'تحميل السيرة الذاتية'
                    : 'Download CV',
                icon: Icons.download_rounded,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(isArabic
                          ? 'اختر لغة السيرة الذاتية'
                          : 'Select CV Language'),
                      content: Text(isArabic
                          ? 'هل تريد السيرة الذاتية باللغة الإنجليزية أم العربية؟'
                          : 'Do you want the CV in English or Arabic?'),
                      actions: [
                        TextButton(
                          child: Text(
                              isArabic ? 'الإنجليزية (English)' : 'English'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            CVGenerator.generateAndDownload(isArabic: false);
                          },
                        ),
                        TextButton(
                          child: Text(isArabic
                              ? 'العربية (Arabic)'
                              : 'عربي (Arabic)'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            CVGenerator.generateAndDownload(isArabic: true);
                          },
                        ),
                      ],
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
          child: Row(
            children: [
              Text(
                isArabic ? 'جدني على:' : 'Find me on:',
                style:
                    GoogleFonts.inter(color: Colors.white38, fontSize: 13),
              ),
              const SizedBox(width: 16),
              _SocialChip(
                  label: 'GitHub',
                  emoji: '🐙',
                  url: PortfolioData.githubUrl,
                  onLaunch: onLaunch),
              const SizedBox(width: 8),
              _SocialChip(
                  label: 'LinkedIn',
                  emoji: '💼',
                  url: PortfolioData.linkedinUrl,
                  onLaunch: onLaunch),
              const SizedBox(width: 8),
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
  const _HeroAvatar({required this.isArabic});
  final bool isArabic;

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
              width: 320,
              height: 320,
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
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 20,
              right: 10,
              child: _FloatingBadge(
                  emoji: '📱',
                  label: widget.isArabic ? 'فلاتر' : 'Flutter'),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              child: _FloatingBadge(
                  emoji: '🎨',
                  label: widget.isArabic ? 'فيجما' : 'Figma'),
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
        border:
            Border.all(color: const Color(0xFF00D4FF).withOpacity(0.4)),
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
          padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
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
          padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
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
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              Text(widget.emoji,
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text(widget.label,
                  style: GoogleFonts.inter(
                      color: Colors.white70, fontSize: 12)),
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
              style:
                  GoogleFonts.inter(color: Colors.white24, fontSize: 12),
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
