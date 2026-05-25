import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';
import '../models/project_model.dart';
import '../screens/project_details_screen.dart';
import '../utils/locale_provider.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        final width = MediaQuery.of(context).size.width;
        final crossAxisCount =
            width > 1100 ? 3 : width > 768 ? 2 : 1;

        final double childAspectRatio = crossAxisCount == 1 
            ? (width > 500 ? 1.25 : 1.0) 
            : 0.85;

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
                    isArabic ? 'معرض أعمالي' : 'PORTFOLIO',
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
                    isArabic ? 'أبرز المشاريع' : 'Featured Projects',
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
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: PortfolioData.projects.length,
                itemBuilder: (context, index) => FadeInUp(
                  delay: Duration(milliseconds: index * 100),
                  child: _ProjectCard(
                    project: PortfolioData.projects[index],
                    isArabic: isArabic,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard(
      {required this.project, required this.isArabic});
  final ProjectModel project;
  final bool isArabic;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  void _openDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ProjectDetailsScreen(project: widget.project),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors =
        widget.project.gradientColors.map((c) => Color(c)).toList();

    return GestureDetector(
      onTap: _openDetails,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform:
              Matrix4.translationValues(0, _hovered ? -8 : 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xFF131A2A),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered
                  ? const Color(0xFF00D4FF).withOpacity(0.5)
                  : Colors.white.withOpacity(0.05),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                        color: const Color(0xFF00D4FF).withOpacity(0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 10))
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20)),
                      child: AnimatedScale(
                        scale: _hovered ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        child: Stack(
                          children: [
                            if (widget.project.imageUrl != null)
                              Positioned.fill(
                                child: Hero(
                                  tag: widget.project.title,
                                  child: Image.asset(
                                      widget.project.imageUrl!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            else
                              Positioned.fill(
                                child: Center(
                                  child: Text(widget.project.emoji,
                                      style: TextStyle(
                                          fontSize: 80,
                                          color: Colors.white
                                              .withOpacity(0.2))),
                                ),
                              ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      const Color(0xFF131A2A)
                                          .withOpacity(0.8),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            if (_hovered)
                              Positioned.fill(
                                child: Container(
                                  color: const Color(0xFF0A0F1E)
                                      .withOpacity(0.6),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.isArabic
                                              ? 'عرض التفاصيل'
                                              : 'View Details',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight:
                                                  FontWeight.w600),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Colors.white,
                                            size: 18),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project.title,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            widget.project.description,
                            style: GoogleFonts.inter(
                                color: Colors.white60,
                                fontSize: 13,
                                height: 1.5),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: widget.project.technologies
                              .take(3)
                              .map((tech) => _TechChip(tech))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  const _TechChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF00D4FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: GoogleFonts.inter(
              color: const Color(0xFF00D4FF),
              fontSize: 10,
              fontWeight: FontWeight.w500)),
    );
  }
}
