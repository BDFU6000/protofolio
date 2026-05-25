import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/project_model.dart';
import '../utils/locale_provider.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final gradientColors = project.gradientColors.map((c) => Color(c)).toList();
    final isArabic = LocaleProvider.isArabic.value;
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width > 600 ? 24.0 : 16.0;
    final overviewTitleFontSize = width > 600 ? 24.0 : 20.0;
    final overviewBodyFontSize = width > 600 ? 16.0 : 14.0;
    final techTitleFontSize = width > 600 ? 20.0 : 18.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1E),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, gradientColors),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        child: Text(
                          isArabic ? 'نظرة عامة' : 'Overview',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: overviewTitleFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        child: Text(
                          project.description,
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: overviewBodyFontSize,
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (project.detailedSections != null &&
                          project.detailedSections!.isNotEmpty)
                        ..._buildDetailedSections(context, isArabic),
                      const SizedBox(height: 32),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: Text(
                          isArabic ? 'التقنيات المستخدمة' : 'Technologies Used',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: techTitleFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeInUp(
                        delay: const Duration(milliseconds: 500),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: project.technologies
                              .map((tech) => _buildTechChip(tech, width > 600))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, List<Color> gradientColors) {
    final width = MediaQuery.of(context).size.width;
    final expandedHeight = width > 600 ? 300.0 : 200.0;
    final titleFontSize = width > 600 ? 36.0 : 24.0;
    final imageSize = width > 600 ? 120.0 : 80.0;
    final emojiSize = width > 600 ? 100.0 : 64.0;

    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      backgroundColor: const Color(0xFF0A0F1E),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Emoji or Logo
              Positioned.fill(
                child: Center(
                  child: project.imageUrl != null
                      ? Hero(
                          tag: project.title,
                          child: Image.asset(
                            project.imageUrl!,
                            height: imageSize,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Text(
                          project.emoji,
                          style: TextStyle(fontSize: emojiSize),
                        ),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFF0A0F1E).withOpacity(0.9),
                        const Color(0xFF0A0F1E),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Title at the bottom
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: FadeInUp(
                      child: Text(
                        project.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDetailedSections(BuildContext context, bool isArabic) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final headerFontSize = width > 600 ? 24.0 : 20.0;
    final sectionPadding = isMobile ? 16.0 : 24.0;
    final sectionTitleFontSize = width > 600 ? 18.0 : 16.0;
    final sectionContentFontSize = width > 600 ? 15.0 : 13.5;
    final iconContainerSize = isMobile ? 40.0 : 48.0;
    final emojiFontSize = isMobile ? 18.0 : 24.0;

    return [
      FadeInUp(
        delay: const Duration(milliseconds: 200),
        child: Text(
          isArabic ? 'بنية المشروع والمميزات' : 'Project Architecture & Features',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: headerFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(height: 20),
      ...List.generate(project.detailedSections!.length, (index) {
        final section = project.detailedSections![index];
        return FadeInUp(
          delay: Duration(milliseconds: 300 + (index * 50)),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(sectionPadding),
            decoration: BoxDecoration(
              color: const Color(0xFF131A2A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (section.iconEmoji != null)
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 16, top: 2),
                    width: iconContainerSize,
                    height: iconContainerSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D4FF).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        section.iconEmoji!,
                        style: TextStyle(fontSize: emojiFontSize),
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: sectionTitleFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        section.content,
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: sectionContentFontSize,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ];
  }

  Widget _buildTechChip(String label, bool isLarge) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isLarge ? 16.0 : 12.0, vertical: isLarge ? 8.0 : 6.0),
      decoration: BoxDecoration(
        color: const Color(0xFF00D4FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF00D4FF).withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: const Color(0xFF00D4FF),
          fontSize: isLarge ? 14.0 : 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
