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
    this.detailedSections,
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
