/// Model representing a single work experience entry.
///
/// Rendered as a timeline card in [ExperienceSection].
class ExperienceModel {
  /// Job title / role held at the company.
  final String role;

  /// Name of the company or organization.
  final String company;

  /// Employment period displayed as a string (e.g. "Jan 2022 – Present").
  final String period;

  /// Short description of responsibilities and achievements.
  final String description;

  /// List of tools/technologies used during this role.
  final List<String> technologies;

  /// Emoji representing the type of company (e.g. "🏥", "🛒", "🚀").
  final String emoji;

  /// Optional fuller summary used in modal detail sheets.
  final String? detailSummary;

  /// Optional responsibilities used in expanded views.
  final List<String>? responsibilities;

  /// Optional achievements used in expanded views.
  final List<String>? achievements;

  /// Optional related projects to surface in expanded views.
  final List<String>? relatedProjects;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.technologies,
    required this.emoji,
    this.detailSummary,
    this.responsibilities,
    this.achievements,
    this.relatedProjects,
  });
}
