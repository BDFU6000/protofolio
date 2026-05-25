import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';
import '../utils/locale_provider.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        final isWide = MediaQuery.of(context).size.width > 900;

        return _SectionWrapper(
          label: isArabic ? 'نبذة عني' : 'ABOUT ME',
          title: isArabic
              ? 'مطور شغوف،\nيصنع تجارب رقمية مميزة'
              : 'Passionate Developer,\nCrafting Digital Experiences',
          child: isWide
              ? Row(
                  key: const ValueKey('about_row_desktop'),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _BioCard(
                        key: const ValueKey('about_bio_desktop'),
                        isArabic: isArabic,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 4,
                      child: _StatsGrid(
                        key: const ValueKey('about_stats_desktop'),
                        isArabic: isArabic,
                      ),
                    ),
                  ],
                )
              : Column(
                  key: const ValueKey('about_column_mobile'),
                  children: [
                    _BioCard(
                      key: const ValueKey('about_bio_mobile'),
                      isArabic: isArabic,
                    ),
                    const SizedBox(height: 32),
                    _StatsGrid(
                      key: const ValueKey('about_stats_mobile'),
                      isArabic: isArabic,
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _BioCard extends StatelessWidget {
  const _BioCard({super.key, required this.isArabic});
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final tags = isArabic
        ? const [
            'مصمم واجهات (Figma)',
            'هندسة برمجية نظيفة',
            'قائد فريق',
            'مطور شامل مستقل',
          ]
        : const [
            'Figma Designer',
            'Clean Architecture',
            'Team Leader',
            'Solo Full-Stack',
          ];

    return FadeInLeft(
      duration: const Duration(milliseconds: 600),
      child: Container(
        padding: EdgeInsets.all(width > 600 ? 32.0 : 20.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF00D4FF).withOpacity(0.5),
                    const Color(0xFF7B2FFF).withOpacity(0.5),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.5),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/Moneeb.jpg',
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Text('👨🏻‍💻', style: TextStyle(fontSize: 40)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              PortfolioData.name,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF00D4FF), Color(0xFF7B2FFF)],
              ).createShader(bounds),
              child: Text(
                PortfolioData.tagline,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white10),
            const SizedBox(height: 20),
            Text(
              PortfolioData.bio,
              style: GoogleFonts.inter(
                color: Colors.white60,
                fontSize: 15,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map((t) => _Tag(t)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({super.key, required this.isArabic});
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 400 ? 2 : 1;
    final double childAspectRatio = width > 1200
        ? 1.15
        : (width > 900
            ? 0.95
            : (width > 600
                ? 1.05
                : (width > 400 ? 0.95 : 2.2)));

    final stats = [
      _StatData(
          value: PortfolioData.yearsOfExperience,
          suffix: '+',
          label: isArabic ? 'سنوات الخبرة' : 'Years of\nExperience',
          emoji: '📅'),
      _StatData(
          value: PortfolioData.projectsCompleted,
          suffix: '+',
          label: isArabic ? 'المشاريع المنجزة' : 'Projects\nCompleted',
          emoji: '🗂️'),
      _StatData(
          value: PortfolioData.satisfiedClients,
          suffix: '+',
          label: isArabic ? 'العملاء السعداء' : 'Satisfied\nClients',
          emoji: '🤝'),
      _StatData(
          value: PortfolioData.openSourceContributions,
          suffix: '+',
          label: isArabic
              ? 'المساهمات البرمجية'
              : 'Open Source\nContributions',
          emoji: '🌟'),
    ];

    return FadeInRight(
      duration: const Duration(milliseconds: 600),
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
        children: stats.map((s) => _StatCard(data: s)).toList(),
      ),
    );
  }
}

class _StatData {
  const _StatData(
      {required this.value,
      required this.suffix,
      required this.label,
      required this.emoji});
  final int value;
  final String suffix, label, emoji;
}

class _StatCard extends StatefulWidget {
  const _StatCard({required this.data});
  final _StatData data;

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        transform: Matrix4.identity()..scale(_hovered ? 1.05 : 1.0),
        decoration: BoxDecoration(
          color: _hovered
              ? const Color(0xFF00D4FF).withOpacity(0.08)
              : Colors.white.withOpacity(0.03),
          border: Border.all(
            color: _hovered
                ? const Color(0xFF00D4FF).withOpacity(0.4)
                : Colors.white.withOpacity(0.08),
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: _hovered
              ? [
                  const BoxShadow(
                      color: Color(0x2200D4FF), blurRadius: 20)
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.data.emoji,
                style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 10),
            TweenAnimationBuilder<int>(
              tween: IntTween(begin: 0, end: widget.data.value),
              duration: const Duration(seconds: 2),
              curve: Curves.easeOutQuint,
              builder: (context, value, _) => ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF00D4FF), Color(0xFF7B2FFF)],
                ).createShader(bounds),
                child: Text(
                  '$value${widget.data.suffix}',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.data.label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: Colors.white54, fontSize: 12, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF00D4FF).withOpacity(0.1),
        border: Border.all(color: const Color(0xFF00D4FF).withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style: GoogleFonts.inter(
              color: const Color(0xFF00D4FF), fontSize: 11)),
    );
  }
}

class _SectionWrapper extends StatelessWidget {
  const _SectionWrapper({
    required this.label,
    required this.title,
    required this.child,
  });
  final String label, title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width > 600 ? 40.0 : 16.0;
    final verticalPadding = width > 600 ? 80.0 : 48.0;
    final titleFontSize = width > 600 ? 36.0 : 26.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: Column(
        children: [
          FadeInDown(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF00D4FF).withOpacity(0.1),
                border: Border.all(
                    color: const Color(0xFF00D4FF).withOpacity(0.4)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(label,
                  style: GoogleFonts.inter(
                      color: const Color(0xFF00D4FF),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2)),
            ),
          ),
          const SizedBox(height: 16),
          FadeInDown(
            delay: const Duration(milliseconds: 100),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.white, Color(0xFFB0B8D0)],
              ).createShader(bounds),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w700,
                    height: 1.25),
              ),
            ),
          ),
          const SizedBox(height: 48),
          child,
        ],
      ),
    );
  }
}
