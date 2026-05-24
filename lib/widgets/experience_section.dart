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
        return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
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
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 56),
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
    final isWide = MediaQuery.of(context).size.width > 768;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF00D4FF).withOpacity(0.1),
                  border: Border.all(
                      color: const Color(0xFF00D4FF).withOpacity(0.5),
                      width: 2),
                ),
                child: Center(
                  child: Text(experience.emoji,
                      style: const TextStyle(fontSize: 20)),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                      width: 2,
                      color: const Color(0xFF00D4FF).withOpacity(0.2)),
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: _ExperienceCard(
                  experience: experience, isWide: isWide),
            ),
          ),
        ],
      ),
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
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
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
