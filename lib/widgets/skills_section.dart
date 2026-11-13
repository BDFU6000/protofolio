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
            ? 6
            : width > 800
                ? 4
                : width > 500
                    ? 3
                    : 2;

        final double childAspectRatio = crossAxisCount >= 4 ? 1.35 : 1.5;

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D4FF).withOpacity(0.1),
                    border: Border.all(
                        color: const Color(0xFF00D4FF).withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isArabic ? 'الأدوات والتقنيات' : 'TOOLS & TECHNOLOGIES',
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
                    isArabic ? 'المهارات والتقنيات' : 'Tools & Technologies',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: PortfolioData.skills.length,
                itemBuilder: (context, index) => FadeInUp(
                  delay: Duration(milliseconds: index * 80),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () =>
                        _showDetailSheet(context, PortfolioData.skills[index]),
                    child: _SkillCard(skill: PortfolioData.skills[index]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDetailSheet(BuildContext context, SkillModel skill) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0D1321),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.68,
        minChildSize: 0.5,
        maxChildSize: 0.85,
        builder: (_, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(skill.emoji, style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      skill.name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              if (skill.category != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: Text(
                    skill.category!,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF00D4FF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                skill.description ??
                    'This skill was used across product design, implementation, problem-solving, and system integration in real portfolio work.',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  height: 1.7,
                ),
              ),
              if (skill.applications != null &&
                  skill.applications!.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  'Applied in',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                ...skill.applications!.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8, right: 8),
                          child: Icon(Icons.circle,
                              size: 8, color: Color(0xFF00D4FF)),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (skill.relatedProjects != null &&
                  skill.relatedProjects!.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  'Related projects',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: skill.relatedProjects!
                      .map(
                        (item) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.08)),
                          ),
                          child: Text(
                            item,
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _hovered
              ? _accentColor.withOpacity(0.08)
              : const Color(0xFF0A4A50).withOpacity(0.72),
          border: Border.all(
            color: _hovered ? const Color(0xFFFFC900) : const Color(0xFF167C82),
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                      color: _accentColor.withOpacity(0.2), blurRadius: 20)
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.skill.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text(
              widget.skill.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (_, __) => ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _progressAnimation.value,
                  backgroundColor: Colors.white.withOpacity(0.06),
                  valueColor: AlwaysStoppedAnimation<Color>(_accentColor),
                  minHeight: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
