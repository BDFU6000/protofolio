import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';
import '../models/skill_model.dart';
import '../utils/locale_provider.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        final width = MediaQuery.of(context).size.width;
        final crossAxisCount = width > 1200
            ? 4
            : width > 800
                ? 3
                : width > 500
                    ? 2
                    : 1;

        final double childAspectRatio = crossAxisCount == 1
            ? (width > 400 ? 4.5 : 3.5)
            : (crossAxisCount == 2 ? 2.0 : 1.6);

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
                    isArabic ? 'المهارات البرمجية' : 'TECH STACK',
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
                        ? 'المهارات والتقنيات'
                        : 'Skills & Technologies',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: PortfolioData.skills.length,
                itemBuilder: (context, index) => FadeInUp(
                  delay: Duration(milliseconds: index * 80),
                  child: _SkillCard(skill: PortfolioData.skills[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SkillCard extends StatefulWidget {
  const _SkillCard({required this.skill});
  final SkillModel skill;

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressAnimation = Tween<double>(begin: 0, end: widget.skill.level)
        .animate(CurvedAnimation(
            parent: _progressController, curve: Curves.easeOutCubic));
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _progressController.forward();
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  Color get _accentColor =>
      Color(int.parse('FF${widget.skill.color}', radix: 16));

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _hovered
              ? _accentColor.withOpacity(0.08)
              : Colors.white.withOpacity(0.03),
          border: Border.all(
            color: _hovered
                ? _accentColor.withOpacity(0.5)
                : Colors.white.withOpacity(0.08),
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: _hovered
              ? [BoxShadow(color: _accentColor.withOpacity(0.2), blurRadius: 20)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(widget.skill.emoji,
                    style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.skill.name,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${(widget.skill.level * 100).toInt()}%',
                  style: GoogleFonts.inter(
                      color: _accentColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (_, __) => ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _progressAnimation.value,
                  backgroundColor: Colors.white.withOpacity(0.06),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(_accentColor),
                  minHeight: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
