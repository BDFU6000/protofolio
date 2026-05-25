import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';
import '../models/experience_model.dart';
import '../utils/locale_provider.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        final width = MediaQuery.of(context).size.width;
        final horizontalPadding = width > 600 ? 40.0 : 16.0;
        final verticalPadding = width > 600 ? 80.0 : 48.0;
        final titleFontSize = width > 600 ? 36.0 : 26.0;

        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          child: Column(
            children: [
              FadeInDown(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D4FF).withOpacity(0.1),
                    border: Border.all(
                        color: const Color(0xFF00D4FF).withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isArabic ? 'الخبرة المهنية' : 'EXPERIENCE',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF00D4FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2),
                  ),
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
                    isArabic
                        ? 'مسيرتي المهنية'
                        : 'My Professional Journey',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PortfolioData.experiences.length,
                itemBuilder: (context, index) {
                  final isLast =
                      index == PortfolioData.experiences.length - 1;
                  return FadeInUp(
                    delay: Duration(milliseconds: index * 150),
                    child: _TimelineItem(
                      experience: PortfolioData.experiences[index],
                      isLast: isLast,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem(
      {required this.experience, required this.isLast});
  final ExperienceModel experience;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 768;
    final isMobile = width <= 600;
    final indicatorSize = isMobile ? 36.0 : 48.0;
    final emojiSize = isMobile ? 16.0 : 20.0;
    final spacing = isMobile ? 12.0 : 24.0;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: indicatorSize + spacing,
            bottom: 32,
          ),
          child: _ExperienceCard(
              experience: experience, isWide: isWide),
        ),
        PositionedDirectional(
          start: 0,
          top: 0,
          bottom: 0,
          width: indicatorSize,
          child: Column(
            children: [
              Container(
                width: indicatorSize,
                height: indicatorSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF00D4FF).withOpacity(0.1),
                  border: Border.all(
                      color: const Color(0xFF00D4FF).withOpacity(0.5),
                      width: 2),
                ),
                child: Center(
                  child: Text(experience.emoji,
                      style: TextStyle(fontSize: emojiSize)),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Center(
                    child: Container(
                      width: 2,
                      color: const Color(0xFF00D4FF).withOpacity(0.2),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard(
      {required this.experience, required this.isWide});
  final ExperienceModel experience;
  final bool isWide;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardPadding = width > 600 ? 24.0 : 16.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: _hovered
              ? Colors.white.withOpacity(0.05)
              : Colors.white.withOpacity(0.02),
          border: Border.all(
            color: _hovered
                ? const Color(0xFF00D4FF).withOpacity(0.3)
                : Colors.white.withOpacity(0.05),
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                      color: const Color(0xFF00D4FF).withOpacity(0.05),
                      blurRadius: 20)
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isWide)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(widget.experience.role,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                  ),
                  _PeriodBadge(period: widget.experience.period),
                ],
              )
            else ...[
              Text(widget.experience.role,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _PeriodBadge(period: widget.experience.period),
            ],
            const SizedBox(height: 8),
            Text(widget.experience.company,
                style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 16),
            Text(widget.experience.description,
                style: GoogleFonts.inter(
                    color: Colors.white54,
                    fontSize: 14,
                    height: 1.6)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.experience.technologies
                  .map((tech) => _TechChip(tech))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodBadge extends StatelessWidget {
  const _PeriodBadge({required this.period});
  final String period;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF00D4FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(period,
          style: GoogleFonts.inter(
              color: const Color(0xFF00D4FF),
              fontSize: 12,
              fontWeight: FontWeight.w500)),
    );
  }
}

class _TechChip extends StatelessWidget {
  const _TechChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: GoogleFonts.inter(color: Colors.white70, fontSize: 11)),
    );
  }
}
