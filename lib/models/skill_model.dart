/// Model representing a skill or technology the developer knows.
///
/// Used by [SkillsSection] to render the tech stack grid.
class SkillModel {
  /// Display name of the skill (e.g. "Flutter", "Firebase").
  final String name;

  /// Emoji icon representing the technology.
  final String emoji;

  /// Proficiency level from 0.0 to 1.0, used for progress indicators.
  final double level;

  /// Hex color code (without #) for the skill's accent color.
  final String color;

  /// Optional category grouping such as "Mobile Development".
  final String? category;

  /// Optional summary description used in detail sheets.
  final String? description;

  /// Optional examples of where the skill was applied.
  final List<String>? applications;

  /// Optional related project names for context.
  final List<String>? relatedProjects;

  const SkillModel({
    required this.name,
    required this.emoji,
    required this.level,
    required this.color,
    this.category,
    this.description,
    this.applications,
    this.relatedProjects,
  });
}
