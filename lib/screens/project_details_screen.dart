import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final horizontalPadding = width > 600 ? 28.0 : 16.0;

    final sections = <Widget>[];
    if (project.overview != null || project.description.isNotEmpty) {
      sections.add(
          _buildSectionHeader(context, isArabic ? 'نظرة عامة' : 'Overview'));
      sections.add(const SizedBox(height: 12));
      sections.add(
        _buildTextBlock(
          project.overview ?? project.description,
        ),
      );
      sections.add(const SizedBox(height: 28));
    }

    if (project.challenge != null) {
      sections.add(
          _buildSectionHeader(context, isArabic ? 'التحدي' : 'The Challenge'));
      sections.add(const SizedBox(height: 12));
      sections.add(_buildTextBlock(project.challenge!));
      sections.add(const SizedBox(height: 28));
    }

    if (project.objectives != null && project.objectives!.isNotEmpty) {
      sections.add(
          _buildSectionHeader(context, isArabic ? 'الأهداف' : 'Objectives'));
      sections.add(const SizedBox(height: 12));
      sections.add(_buildBulletList(project.objectives!));
      sections.add(const SizedBox(height: 28));
    }

    if (project.approach != null) {
      sections.add(
          _buildSectionHeader(context, isArabic ? 'تجهيزي' : 'My Approach'));
      sections.add(const SizedBox(height: 12));
      sections.add(_buildTextBlock(project.approach!));
      sections.add(const SizedBox(height: 28));
    }

    if (project.designAndUx != null) {
      sections.add(_buildSectionHeader(
          context, isArabic ? 'التصميم وتجربة المستخدم' : 'Design & UX'));
      sections.add(const SizedBox(height: 12));
      sections.add(_buildTextBlock(project.designAndUx!));
      sections.add(const SizedBox(height: 28));
    }

    if (project.development != null) {
      sections.add(_buildSectionHeader(
          context, isArabic ? 'التنفيذ' : 'Development & Implementation'));
      sections.add(const SizedBox(height: 12));
      sections.add(_buildTextBlock(project.development!));
      sections.add(const SizedBox(height: 28));
    }

    if (project.keyFeatures != null && project.keyFeatures!.isNotEmpty) {
      sections.add(_buildSectionHeader(
          context, isArabic ? 'المميزات الأساسية' : 'Key Features'));
      sections.add(const SizedBox(height: 12));
      sections.add(_buildBulletList(project.keyFeatures!));
      sections.add(const SizedBox(height: 28));
    }

    if (project.techStack != null && project.techStack!.isNotEmpty) {
      sections.add(_buildSectionHeader(
          context, isArabic ? 'التقنيات' : 'Technical Stack'));
      sections.add(const SizedBox(height: 12));
      sections.add(
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: project.techStack!
              .map(
                (item) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D4FF).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color(0xFF00D4FF).withOpacity(0.3)),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: '${item.name}  ',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: item.role,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFFB8C4D9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
      sections.add(const SizedBox(height: 28));
    }

    if (project.responsibilities != null &&
        project.responsibilities!.isNotEmpty) {
      sections.add(_buildSectionHeader(context,
          isArabic ? 'مسؤولياتي' : 'Responsibilities & Accomplishments'));
      sections.add(const SizedBox(height: 12));
      sections.add(_buildBulletList(project.responsibilities!));
      sections.add(const SizedBox(height: 28));
    }

    if (project.challenges != null && project.challenges!.isNotEmpty) {
      sections.add(_buildSectionHeader(
          context, isArabic ? 'التحديات والحلول' : 'Challenges & Solutions'));
      sections.add(const SizedBox(height: 12));
      for (final item in project.challenges!) {
        sections.add(_buildChallengeCard(item));
        sections.add(const SizedBox(height: 12));
      }
      sections.add(const SizedBox(height: 28));
    }

    final galleryItems = project.gallery ??
        [
          if (project.imageUrl != null)
            ProjectGalleryItem(
                title: project.title,
                imageUrl: project.imageUrl!,
                caption: project.subtitle),
        ];

    if (galleryItems.isNotEmpty) {
      sections.add(_buildSectionHeader(
          context, isArabic ? 'معرض المشروع' : 'Project Gallery'));
      sections.add(const SizedBox(height: 12));
      sections.add(
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: galleryItems
              .map(
                (item) => SizedBox(
                  width: width > 700 ? 360 : width - 32,
                  child: _buildGalleryCard(item),
                ),
              )
              .toList(),
        ),
      );
      sections.add(const SizedBox(height: 28));
    }

    if (project.status != null ||
        project.liveUrl != null ||
        project.githubUrl != null) {
      sections.add(_buildSectionHeader(
          context, isArabic ? 'الحالة والنتيجة' : 'Outcome & Status'));
      sections.add(const SizedBox(height: 12));
      if (project.status != null) {
        sections.add(
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF131A2A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Text(
              project.status!,
              style: GoogleFonts.inter(
                color: const Color(0xFF00D4FF),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
        sections.add(const SizedBox(height: 16));
      }
      sections.add(
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (project.liveUrl != null)
              _buildActionChip(
                context,
                label: isArabic ? 'عرض المشروع' : 'View project',
                url: project.liveUrl!,
              ),
            if (project.githubUrl != null)
              _buildActionChip(
                context,
                label: isArabic ? 'المصدر' : 'Source',
                url: project.githubUrl!,
              ),
          ],
        ),
      );
      sections.add(const SizedBox(height: 28));
    }

    if (project.relatedProjects != null &&
        project.relatedProjects!.isNotEmpty) {
      sections.add(_buildSectionHeader(
          context, isArabic ? 'مشاريع ذات صلة' : 'Related Projects'));
      sections.add(const SizedBox(height: 12));
      sections.add(
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.relatedProjects!
              .map(
                (item) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: Text(
                    item,
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    }

    if ((project.detailedSections != null &&
            project.detailedSections!.isNotEmpty) &&
        (project.overview == null &&
            project.challenge == null &&
            project.approach == null)) {
      sections.add(const SizedBox(height: 24));
      sections.add(_buildSectionHeader(
          context, isArabic ? 'الهيكل التفصيلي' : 'Project Structure'));
      sections.add(const SizedBox(height: 12));
      for (final section in project.detailedSections!) {
        sections.add(
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF131A2A),
              borderRadius: BorderRadius.circular(16),
            ),
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
                const SizedBox(height: 8),
                Text(
                  section.content,
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1E),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, gradientColors),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sections,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return FadeInUp(
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.width > 600 ? 24 : 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextBlock(String text) {
    return FadeInUp(
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white70,
          fontSize: 15,
          height: 1.7,
        ),
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, right: 10),
                      child:
                          Icon(Icons.circle, size: 8, color: Color(0xFF00D4FF)),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          height: 1.7,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildChallengeCard(ProjectChallengeSolution item) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF131A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Challenge',
            style: GoogleFonts.poppins(
              color: const Color(0xFF00D4FF),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.challenge,
            style: GoogleFonts.inter(
              height: 1.6,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Solution',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.solution,
            style: GoogleFonts.inter(
              height: 1.6,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryCard(ProjectGalleryItem item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131A2A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.asset(
              item.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 220,
              errorBuilder: (_, __, ___) => Container(
                height: 220,
                color: const Color(0xFF0D1321),
                child: const Center(
                  child: Icon(Icons.image_not_supported_rounded,
                      color: Colors.white38),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              item.caption ?? item.title,
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(BuildContext context,
      {required String label, required String url}) {
    return InkWell(
      onTap: () =>
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF00D4FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF00D4FF).withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF00D4FF),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, List<Color> gradientColors) {
    final width = MediaQuery.of(context).size.width;
    final expandedHeight = width > 600 ? 320.0 : 240.0;
    final titleFontSize = width > 600 ? 36.0 : 24.0;
    final imageSize = width > 600 ? 120.0 : 80.0;

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
                          style: TextStyle(fontSize: width > 600 ? 100 : 64),
                        ),
                ),
              ),
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
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  children: [
                    if (project.subtitle != null)
                      Text(
                        project.subtitle!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      project.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                      ),
                    ),
                    if (project.category != null ||
                        project.role != null ||
                        project.status != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (project.category != null)
                              _metaChip(project.category!),
                            if (project.role != null) _metaChip(project.role!),
                            if (project.status != null)
                              _metaChip(project.status!),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _metaChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
