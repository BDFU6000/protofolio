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

  const SkillModel({
    required this.name,
    required this.emoji,
    required this.level,
    required this.color,
  });
}
