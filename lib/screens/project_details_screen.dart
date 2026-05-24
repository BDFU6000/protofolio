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

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1E),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, gradientColors),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
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
                            fontSize: 24,
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
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (project.detailedSections != null &&
                          project.detailedSections!.isNotEmpty)
                        ..._buildDetailedSections(isArabic),
                      const SizedBox(height: 40),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: Text(
                          isArabic ? 'التقنيات المستخدمة' : 'Technologies Used',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeInUp(
                        delay: const Duration(milliseconds: 500),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: project.technologies
                              .map((tech) => _buildTechChip(tech))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 80),
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
    return SliverAppBar(
      expandedHeight: 300,
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
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Text(
                          project.emoji,
                          style: const TextStyle(fontSize: 100),
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
                bottom: 30,
                left: 24,
                right: 24,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: FadeInUp(
                      child: Text(
                        project.title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 36,
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

  List<Widget> _buildDetailedSections(bool isArabic) {
    return [
      FadeInUp(
        delay: const Duration(milliseconds: 200),
        child: Text(
          isArabic ? 'بنية المشروع والمميزات' : 'Project Architecture & Features',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(height: 24),
      ...List.generate(project.detailedSections!.length, (index) {
        final section = project.detailedSections![index];
        return FadeInUp(
          delay: Duration(milliseconds: 300 + (index * 50)),
          child: Container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.all(24),
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
                    margin: const EdgeInsetsDirectional.only(end: 20, top: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D4FF).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      section.iconEmoji!,
                      style: const TextStyle(fontSize: 24),
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
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        section.content,
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 15,
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

  Widget _buildTechChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF00D4FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF00D4FF).withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: const Color(0xFF00D4FF),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
