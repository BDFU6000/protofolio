/// Model representing a single portfolio project.
///
/// All instances are created from [PortfolioData] and passed
/// down to [ProjectsSection] for rendering.
class ProjectModel {
  /// The display title of the project.
  final String title;

  /// A short description of what the project does.
  final String description;

  /// List of technology/tool names used in the project.
  final List<String> technologies;

  /// Optional: URL to the live demo / deployed version.
  final String? liveUrl;

  /// Optional: URL to the source code repository.
  final String? githubUrl;

  /// Emoji or icon label that visually represents the project category.
  final String emoji;

  /// Gradient colors used as the project card's background.
  final List<int> gradientColors;

  /// Optional: Path to the project's logo image.
  final String? imageUrl;

  /// Optional summary text used in the project hero / detail view.
  final String? subtitle;

  /// Category such as "Concept", "Corporate Website", "SaaS".
  final String? category;

  /// Personal role in the project.
  final String? role;

  /// Public status, such as "Independent Redesign Concept" or "Deployed".
  final String? status;

  /// A fuller overview section for case-study pages.
  final String? overview;

  /// What problem or opportunity motivated the project.
  final String? challenge;

  /// Primary goals to achieve.
  final List<String>? objectives;

  /// How the solution was approached.
  final String? approach;

  /// UI/UX rationale and design decisions.
  final String? designAndUx;

  /// Development and implementation notes.
  final String? development;

  /// Exposed feature list for the project.
  final List<String>? keyFeatures;

  /// Structured technical stack with role labels.
  final List<ProjectTechStackItem>? techStack;

  /// Personal responsibilities and accomplishment areas.
  final List<String>? responsibilities;

  /// Technical and design challenges with their solutions.
  final List<ProjectChallengeSolution>? challenges;

  /// Gallery images used in the project detail screen.
  final List<ProjectGalleryItem>? gallery;

  /// Related project names or keywords for navigation.
  final List<String>? relatedProjects;

  /// Optional: Detailed step-by-step sections for the project page.
  final List<ProjectDetailSection>? detailedSections;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.technologies,
    required this.emoji,
    required this.gradientColors,
    this.liveUrl,
    this.githubUrl,
    this.imageUrl,
    this.subtitle,
    this.category,
    this.role,
    this.status,
    this.overview,
    this.challenge,
    this.objectives,
    this.approach,
    this.designAndUx,
    this.development,
    this.keyFeatures,
    this.techStack,
    this.responsibilities,
    this.challenges,
    this.gallery,
    this.relatedProjects,
    this.detailedSections,
  });
}

class ProjectTechStackItem {
  final String name;
  final String role;

  const ProjectTechStackItem({
    required this.name,
    required this.role,
  });
}

class ProjectChallengeSolution {
  final String challenge;
  final String solution;

  const ProjectChallengeSolution({
    required this.challenge,
    required this.solution,
  });
}

class ProjectGalleryItem {
  final String title;
  final String imageUrl;
  final String? caption;

  const ProjectGalleryItem({
    required this.title,
    required this.imageUrl,
    this.caption,
  });
}

/// Represents a single step or section in the project details screen.
class ProjectDetailSection {
  final String title;
  final String content;
  final String? iconEmoji;

  const ProjectDetailSection({
    required this.title,
    required this.content,
    this.iconEmoji,
  });
}
