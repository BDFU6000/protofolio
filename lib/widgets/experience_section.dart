import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/locale_provider.dart';

// ─── Data model ──────────────────────────────────────────────────────────────

class _Phase {
  const _Phase({
    required this.title,
    required this.providers,
    required this.resources,
    required this.credentials,
    required this.objectives,
    required this.practical,
    required this.deliverable,
  });
  final String title;
  final List<String> providers;
  final List<String> resources;
  final List<String> credentials;
  final List<String> objectives;
  final List<String> practical;
  final String deliverable;
}

class _RoadmapTrack {
  const _RoadmapTrack({
    required this.number,
    required this.title,
    required this.phases,
    required this.icon,
    this.completed = false,
  });
  final int number;
  final String title;
  final List<_Phase> phases;
  final IconData icon;
  final bool completed;

  List<String> get shortTopics => phases.map((p) => p.title).toList();
  List<String> get allSources =>
      phases.expand((p) => p.providers).toSet().toList();
}

// ─── Track data ───────────────────────────────────────────────────────────────

const _roadmapTracks = <_RoadmapTrack>[
  _RoadmapTrack(
    number: 1,
    title: 'Product Design & User Experience',
    icon: Icons.design_services_rounded,
    completed: true,
    phases: [
      _Phase(
        title: 'Phase 01 — UX Research & Product Discovery',
        providers: ['IBM SkillsBuild', 'The Open University'],
        resources: [
          'User Experience Design Fundamentals — IBM SkillsBuild (12 hours)',
          'Design Thinking — OpenLearn (10 hours)',
          'An Introduction to Interaction Design — OpenLearn (10 hours)',
        ],
        credentials: [
          'IBM Digital Credential',
          'Open University Statements of Participation',
        ],
        objectives: [
          'User-centered design and research methodologies',
          'User personas, user stories, and problem definition',
          'Design thinking and creative problem-solving',
          'User journeys and information architecture',
          'Usability principles and interaction requirements',
          'Research findings and product evaluation',
        ],
        practical: [
          'Conduct UX audits of existing digital products',
          'Define product requirements and user problems',
          'Develop personas, user journeys, and task flows',
          'Produce wireframes and interactive prototypes',
          'Evaluate user experiences and identify improvements',
        ],
        deliverable:
            'A documented product discovery and UX research case study.',
      ),
      _Phase(
        title: 'Phase 02 — UI Design & Design Systems',
        providers: ['Figma Learn'],
        resources: [
          'Figma Design for Beginners',
          'Components Collection',
          'Introduction to Design Systems',
          'Motion Design Fundamentals',
        ],
        credentials: [
          'No formal certification; free learning resources',
        ],
        objectives: [
          'Professional interface design principles',
          'Visual hierarchy, typography, colors, and spacing',
          'Figma Auto Layout and responsive design',
          'Reusable components, variants, and properties',
          'Design tokens and scalable component libraries',
          'Interactive prototyping and motion principles',
          'Accessibility-aware interface design',
        ],
        practical: [
          'Design responsive web and mobile interfaces',
          'Create reusable UI component libraries',
          'Establish design tokens and visual guidelines',
          'Develop interactive prototypes and micro-interactions',
          'Document component behavior and design standards',
        ],
        deliverable:
            'A complete responsive design system with reusable components and interactive prototypes.',
      ),
    ],
  ),
  _RoadmapTrack(
    number: 2,
    title: 'Software Engineering & Development',
    icon: Icons.memory_rounded,
    phases: [
      _Phase(
        title: 'Phase 03 — Programming & Software Engineering',
        providers: ['freeCodeCamp', 'Official Language Documentation'],
        resources: [
          'Responsive Web Design Certification — freeCodeCamp',
          'JavaScript Certification — freeCodeCamp',
          'Front-End Development Libraries Certification — freeCodeCamp',
          'Dart and Flutter official learning resources',
        ],
        credentials: [
          'FreeCodeCamp verifiable certifications upon completing required coursework, projects, and assessments',
        ],
        objectives: [
          'Programming fundamentals and problem-solving',
          'Object-oriented and functional programming',
          'Data structures and algorithms',
          'Clean code and software engineering principles',
          'Git, version control, and collaborative workflows',
          'Asynchronous programming and error handling',
          'Application architecture and modular development',
          'Unit, integration, and automated testing',
        ],
        practical: [
          'Build maintainable applications using Flutter and Dart',
          'Develop responsive web interfaces',
          'Implement application state management',
          'Integrate APIs and external services',
          'Write reusable and testable code',
          'Organize projects into maintainable modules',
          'Debug, refactor, and improve existing applications',
        ],
        deliverable:
            'A fully functional application with documented code architecture, reusable components, and automated tests.',
      ),
      _Phase(
        title: 'Phase 04 — Backend Engineering & Database Architecture',
        providers: [
          'AWS Skill Builder',
          'PostgreSQL',
          'freeCodeCamp',
          'MongoDB University',
        ],
        resources: [
          'PostgreSQL Architecture — AWS Skill Builder',
          'Relational Databases — freeCodeCamp',
          'Back-End Development and APIs — freeCodeCamp',
          'PostgreSQL Official Documentation',
          'MongoDB Developer Learning Paths',
        ],
        credentials: [
          'freeCodeCamp certifications',
          'AWS course completion or digital credential where offered',
        ],
        objectives: [
          'Client-server architecture and HTTP protocols',
          'RESTful APIs and API design',
          'Authentication and authorization',
          'Relational and NoSQL database models',
          'Database normalization and schema design',
          'Indexing and query optimization',
          'Transactions and concurrency control',
          'Replication, partitioning, and database scaling',
          'Data integrity, migrations, and backups',
        ],
        practical: [
          'Design relational database schemas and ERDs',
          'Build backend services and REST APIs',
          'Implement authentication and role-based permissions',
          'Optimize database queries and indexing',
          'Build secure database integrations',
          'Handle transactions and concurrent operations',
          'Integrate frontend applications with backend services',
        ],
        deliverable:
            'A complete backend architecture featuring documented APIs, database schemas, authentication, and optimized data workflows.',
      ),
    ],
  ),
  _RoadmapTrack(
    number: 3,
    title: 'System Design & Software Architecture',
    icon: Icons.account_tree_rounded,
    phases: [
      _Phase(
        title: 'Phase 05 — System Design & Distributed Systems',
        providers: [
          'Microsoft Architecture Center',
          'Confluent',
          'Martin Fowler',
        ],
        resources: [
          'Microsoft Azure Architecture Center',
          'Confluent Learning Center',
          'Martin Fowler — Software Architecture and Enterprise Design',
          'Distributed Systems Fundamentals',
        ],
        credentials: [
          'Technical learning and practical architecture projects; no universal professional certification',
        ],
        objectives: [
          'Monolithic, modular monolithic, and microservices architectures',
          'Distributed systems fundamentals',
          'Event-driven architecture',
          'Message queues and Apache Kafka',
          'Caching and Redis',
          'Load balancing and horizontal scaling',
          'Fault tolerance and high availability',
          'CAP theorem and consistency models',
          'Data replication and partitioning',
          'System performance and reliability',
        ],
        practical: [
          'Design high-level and low-level system architectures',
          'Break complex requirements into architectural components',
          'Define communication between independent services',
          'Design event-driven workflows',
          'Evaluate scaling and performance bottlenecks',
          'Identify single points of failure',
          'Compare architectural approaches and trade-offs',
          'Document architectural decisions',
        ],
        deliverable:
            'A complete system design case study containing architecture diagrams, data flows, sequence diagrams, scalability analysis, and Architecture Decision Records.',
      ),
      _Phase(
        title: 'Phase 06 — Cloud & Solutions Architecture',
        providers: [
          'Oracle University',
          'AWS',
          'Google Cloud',
          'Microsoft Azure',
        ],
        resources: [
          'Oracle Cloud Infrastructure Architect Associate',
          'AWS Solutions Architect learning path',
          'Google Professional Cloud Architect learning path',
          'Microsoft Azure Architecture Center',
        ],
        credentials: [
          'Oracle OCI Architect Associate — free course and certification (2026 program)',
          'AWS Solutions Architect Associate — paid examination',
          'Google Professional Cloud Architect — paid examination',
        ],
        objectives: [
          'Cloud infrastructure fundamentals',
          'Virtual networks and network security',
          'Compute, storage, and managed databases',
          'Cloud identity and access management',
          'High availability and fault tolerance',
          'Load balancing and auto-scaling',
          'Disaster recovery and backup strategies',
          'Cloud cost optimization',
          'Multi-tier and distributed cloud architectures',
        ],
        practical: [
          'Design cloud infrastructure for production applications',
          'Deploy backend services and databases',
          'Configure network boundaries and access permissions',
          'Design resilient cloud environments',
          'Implement backup and recovery strategies',
          'Evaluate infrastructure costs and scalability',
        ],
        deliverable:
            'A documented cloud architecture with infrastructure diagrams, deployment configuration, security boundaries, and scalability considerations.',
      ),
    ],
  ),
  _RoadmapTrack(
    number: 4,
    title: 'Production Engineering & Security',
    icon: Icons.security_rounded,
    phases: [
      _Phase(
        title: 'Phase 07 — DevOps & Production Engineering',
        providers: ['Linux Foundation', 'HashiCorp', 'Kubernetes'],
        resources: [
          'Linux Foundation Training',
          'Terraform Official Tutorials',
          'Kubernetes Official Tutorials',
          'Docker documentation and learning resources',
        ],
        credentials: [
          'Practical technical experience; optional vendor certifications can be pursued later',
        ],
        objectives: [
          'Linux administration and command-line operations',
          'Containers and Docker',
          'Kubernetes and container orchestration',
          'Continuous Integration and Continuous Deployment',
          'Infrastructure as Code using Terraform',
          'Automated deployment pipelines',
          'Monitoring and observability',
          'Logging and distributed tracing',
          'Incident management and recovery',
        ],
        practical: [
          'Containerize applications',
          'Build automated CI/CD pipelines',
          'Provision cloud resources using Terraform',
          'Deploy and manage containerized applications',
          'Configure monitoring, logging, and alerts',
          'Implement controlled deployment and rollback strategies',
        ],
        deliverable:
            'A deployed application with automated CI/CD, infrastructure configuration, and production monitoring.',
      ),
      _Phase(
        title: 'Phase 08 — Security, Accessibility & Reliability Engineering',
        providers: ['OWASP', 'W3C', 'Cloud Provider Documentation'],
        resources: [
          'OWASP Top 10',
          'Digital Accessibility Foundations — W3C',
          'OAuth 2.0 and OpenID Connect documentation',
          'Google Cloud Well-Architected Framework',
        ],
        credentials: [
          'W3C accessibility course is free to audit; optional verified certificate is paid',
        ],
        objectives: [
          'Secure software development practices',
          'OAuth 2.0 and OpenID Connect',
          'Identity and access management',
          'Encryption and secrets management',
          'Threat modeling and vulnerability assessment',
          'Data protection and access control',
          'Disaster recovery and business continuity',
          'WCAG accessibility guidelines',
          'Application reliability and security testing',
        ],
        practical: [
          'Conduct application security reviews',
          'Identify common web application vulnerabilities',
          'Implement secure authentication and authorization',
          'Evaluate access permissions and data protection',
          'Perform accessibility audits',
          'Prepare backup, recovery, and reliability plans',
        ],
        deliverable:
            'A security and reliability assessment documenting vulnerabilities, accessibility issues, mitigation strategies, and improvements.',
      ),
    ],
  ),
];

// ─── Section widget ───────────────────────────────────────────────────────────

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const _cyan = Color(0xFF52D8DE);
  static const _gold = Color(0xFFFFC900);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: LocaleProvider.isArabic,
        builder: (context, isArabic, _) {
          final wide = MediaQuery.sizeOf(context).width > 760;
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: wide ? 20 : 16,
              vertical: wide ? 58 : 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final imageWidth =
                        (constraints.maxWidth * .4).clamp(240.0, 420.0);
                    return SizedBox(
                      height: wide ? 270 : 220,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            width: wide
                                ? constraints.maxWidth * .57
                                : constraints.maxWidth,
                            child:
                                _RoadmapIntro(isArabic: isArabic, wide: wide),
                          ),
                          if (wide)
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              width: imageWidth,
                              child: Image.asset(
                                'assets/images/My_roadmap.png',
                                fit: BoxFit.contain,
                                alignment: Alignment.centerRight,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.route_rounded,
                                  size: 130,
                                  color: _cyan,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton.icon(
                    onPressed: () => _showAllTracks(context, isArabic),
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.arrow_circle_right_rounded,
                        color: _gold, size: 23),
                    label: Text(
                      isArabic ? 'عرض كل المسارات' : 'See All the Road',
                      style: GoogleFonts.inter(
                        color: _gold,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 900
                        ? 3
                        : constraints.maxWidth >= 600
                            ? 2
                            : 1;
                    return Wrap(
                      spacing: 18,
                      runSpacing: 18,
                      children: [
                        for (final track in _roadmapTracks.take(3))
                          SizedBox(
                            width: (constraints.maxWidth - (columns - 1) * 18) /
                                columns,
                            child: _TrackCard(
                              track: track,
                              isArabic: isArabic,
                              onTap: () =>
                                  _showTrackDetails(context, track, isArabic),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      );

  void _showAllTracks(BuildContext context, bool isArabic) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: const Color(0xFF062F35),
        insetPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: _cyan, width: 1),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900, maxHeight: 720),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        isArabic ? 'كل مسارات التعلم' : 'All Learning Tracks',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      icon: const Icon(Icons.close, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: SingleChildScrollView(
                    child: LayoutBuilder(
                      builder: (ctx, constraints) {
                        final cols = constraints.maxWidth >= 700 ? 2 : 1;
                        final itemWidth =
                            (constraints.maxWidth - (cols - 1) * 14) / cols;
                        return Wrap(
                          spacing: 14,
                          runSpacing: 14,
                          children: [
                            for (final track in _roadmapTracks)
                              SizedBox(
                                width: itemWidth,
                                child: _TrackCard(
                                  track: track,
                                  isArabic: isArabic,
                                  compact: true,
                                  onTap: () {
                                    Navigator.pop(dialogContext);
                                    _showTrackDetails(context, track, isArabic);
                                  },
                                ),
                              ),
                          ],
                        );
                      },
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

  void _showTrackDetails(
    BuildContext context,
    _RoadmapTrack track,
    bool isArabic,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => _TrackDetailDialog(
        track: track,
        isArabic: isArabic,
        onClose: () => Navigator.pop(dialogContext),
      ),
    );
  }
}

// ─── Track detail dialog ──────────────────────────────────────────────────────

class _TrackDetailDialog extends StatefulWidget {
  const _TrackDetailDialog({
    required this.track,
    required this.isArabic,
    required this.onClose,
  });
  final _RoadmapTrack track;
  final bool isArabic;
  final VoidCallback onClose;

  @override
  State<_TrackDetailDialog> createState() => _TrackDetailDialogState();
}

class _TrackDetailDialogState extends State<_TrackDetailDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  static const _cyan = Color(0xFF52D8DE);
  static const _gold = Color(0xFFFFC900);

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: widget.track.phases.length, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final track = widget.track;
    final accent = track.completed ? _gold : _cyan;
    final strike = track.completed;

    return Dialog(
      backgroundColor: const Color(0xFF062F35),
      insetPadding: const EdgeInsets.all(22),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: accent, width: 1.3),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 780, maxHeight: 820),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 0),
              child: Row(
                children: [
                  _TrackNumber(track: track, size: 48),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isArabic
                              ? 'مسار ${track.number}'
                              : 'TRACK ${track.number}',
                          style: GoogleFonts.inter(
                            color: accent,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.8,
                            decoration:
                                strike ? TextDecoration.lineThrough : null,
                            decorationColor: accent,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          track.title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            decoration:
                                strike ? TextDecoration.lineThrough : null,
                            decorationColor: accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: widget.onClose,
                        icon: const Icon(Icons.close, color: Colors.white60),
                      ),
                      if (track.completed)
                        _CompletedBadge(isArabic: widget.isArabic),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // ── Phase tabs ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TabBar(
                controller: _tab,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: accent,
                labelColor: accent,
                unselectedLabelColor: Colors.white38,
                dividerColor: Colors.white12,
                labelStyle: GoogleFonts.inter(
                    fontSize: 11, fontWeight: FontWeight.w600),
                tabs: [
                  for (final phase in track.phases)
                    Tab(text: phase.title.split('—').last.trim()),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // ── Phase content ──
            Flexible(
              child: TabBarView(
                controller: _tab,
                children: [
                  for (final phase in track.phases)
                    _PhaseContent(
                      phase: phase,
                      completed: track.completed,
                      isArabic: widget.isArabic,
                      accent: accent,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhaseContent extends StatelessWidget {
  const _PhaseContent({
    required this.phase,
    required this.completed,
    required this.isArabic,
    required this.accent,
  });
  final _Phase phase;
  final bool completed;
  final bool isArabic;
  final Color accent;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Providers
            _SectionLabel(
                text: isArabic ? 'المزودون' : 'Providers', accent: accent),
            const SizedBox(height: 8),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children:
                  phase.providers.map((p) => _SourceChip(source: p)).toList(),
            ),
            const SizedBox(height: 18),
            // Resources
            _SectionLabel(
                text: isArabic ? 'مصادر التعلم' : 'Learning Resources',
                accent: accent),
            const SizedBox(height: 8),
            for (final r in phase.resources)
              _BulletRow(text: r, completed: completed, bulletColor: accent),
            const SizedBox(height: 18),
            // Credentials
            _SectionLabel(
                text: isArabic ? 'الشهادات' : 'Credentials', accent: accent),
            const SizedBox(height: 8),
            for (final c in phase.credentials)
              _BulletRow(
                  text: c,
                  completed: completed,
                  bulletColor: const Color(0xFFFFC900)),
            const SizedBox(height: 18),
            // Objectives
            _SectionLabel(
                text: isArabic ? 'أهداف التعلم' : 'Learning Objectives',
                accent: accent),
            const SizedBox(height: 8),
            for (var i = 0; i < phase.objectives.length; i++)
              _NumberedRow(
                  index: i + 1,
                  text: phase.objectives[i],
                  completed: completed),
            const SizedBox(height: 18),
            // Practical
            _SectionLabel(
                text: isArabic ? 'التجربة العملية' : 'Practical Experience',
                accent: accent),
            const SizedBox(height: 8),
            for (final p in phase.practical)
              _BulletRow(
                  text: p,
                  completed: completed,
                  bulletColor: const Color(0xFF52D8DE)),
            const SizedBox(height: 18),
            // Deliverable
            _SectionLabel(
                text: isArabic ? 'المخرج النهائي' : 'Portfolio Deliverable',
                accent: accent),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: .07),
                border: Border.all(color: accent.withValues(alpha: .3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                phase.deliverable,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: .88),
                  fontSize: 12,
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                  decoration: completed ? TextDecoration.lineThrough : null,
                  decorationColor: accent,
                ),
              ),
            ),
          ],
        ),
      );
}

// ─── Intro ────────────────────────────────────────────────────────────────────

class _RoadmapIntro extends StatelessWidget {
  const _RoadmapIntro({required this.isArabic, required this.wide});
  final bool isArabic;
  final bool wide;

  static const _gold = Color(0xFFFFC900);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RoadmapPill(isArabic: isArabic),
          const SizedBox(height: 26),
          Text.rich(
            TextSpan(
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontSize: wide ? 28 : 23,
                fontWeight: FontWeight.w700,
                height: 1.55,
                letterSpacing: wide ? 5 : 2,
                shadows: const [
                  Shadow(
                      color: Color(0xAA00D4FF),
                      offset: Offset(1, 2),
                      blurRadius: 2),
                ],
              ),
              children: [
                TextSpan(
                    text: isArabic ? 'مساري المهني\n' : 'My Professional\n'),
                TextSpan(
                  text: isArabic ? 'خريطة التطور' : 'development ',
                  style: const TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: isArabic ? '' : 'roadmap',
                  style: const TextStyle(color: _gold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: wide ? 570 : 600),
            child: Text(
              isArabic
                  ? 'مسار تعلم منظم يغطي دورة حياة المنتج الرقمي بالكامل، من البحث والتصميم إلى الهندسة والبنية التحتية والنشر.'
                  : 'A structured learning path covering the entire digital product lifecycle — from research and design to engineering, architecture, and deployment.',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: .88),
                fontSize: 12,
                height: 1.8,
                letterSpacing: 2.2,
                shadows: const [
                  Shadow(
                      color: Color(0x9900D4FF),
                      offset: Offset(1, 1),
                      blurRadius: 2),
                ],
              ),
            ),
          ),
        ],
      );
}

class _RoadmapPill extends StatelessWidget {
  const _RoadmapPill({required this.isArabic});
  final bool isArabic;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF073F45),
          border: Border.all(color: const Color(0xFF16818A)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.circle, size: 9, color: Color(0xFF69E4E6)),
            const SizedBox(width: 6),
            Text(
              isArabic ? 'مساري المهني' : 'My Roadmap',
              style: GoogleFonts.inter(
                color: const Color(0xFF69E4E6),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
}

// ─── Track card ───────────────────────────────────────────────────────────────

class _TrackCard extends StatefulWidget {
  const _TrackCard({
    required this.track,
    required this.isArabic,
    required this.onTap,
    this.compact = false,
  });
  final _RoadmapTrack track;
  final bool isArabic;
  final VoidCallback onTap;
  final bool compact;

  @override
  State<_TrackCard> createState() => _TrackCardState();
}

class _TrackCardState extends State<_TrackCard> {
  bool _hovered = false;

  static const _cyan = Color(0xFF52D8DE);
  static const _gold = Color(0xFFFFC900);

  @override
  Widget build(BuildContext context) {
    final track = widget.track;
    final accent = track.completed ? _gold : _cyan;
    final strike = track.completed;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: track.completed
              ? const Color(0xFFFFC900).withValues(alpha: .09)
              : const Color(0xFF52D8DE).withValues(alpha: .06),
          border: Border.all(color: accent.withValues(alpha: .5)),
          borderRadius: BorderRadius.circular(20),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                      color: accent.withValues(alpha: .18), blurRadius: 20)
                ]
              : null,
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(widget.compact ? 14 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    _TrackNumber(track: track, size: 36),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.isArabic
                            ? 'مسار ${track.number}'
                            : 'TRACK ${track.number}',
                        style: GoogleFonts.inter(
                          color: accent,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.6,
                          decoration:
                              strike ? TextDecoration.lineThrough : null,
                          decorationColor: accent,
                        ),
                      ),
                    ),
                    if (track.completed)
                      const Icon(Icons.check_circle, color: _gold, size: 17),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  track.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withValues(alpha: .94),
                    fontSize: widget.compact ? 14 : 15,
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                    decoration: strike ? TextDecoration.lineThrough : null,
                    decorationColor: accent,
                  ),
                ),
                const SizedBox(height: 10),
                for (final topic in track.shortTopics)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '•  $topic',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white54,
                        fontSize: 9.5,
                        decoration: strike ? TextDecoration.lineThrough : null,
                        decorationColor: accent,
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: track.allSources
                      .take(3)
                      .map((s) => _SourceChip(source: s, small: true))
                      .toList(),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      widget.isArabic ? 'اقرأ المزيد  ›' : 'Read More  ›',
                      style: GoogleFonts.inter(
                        color: _gold,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
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

// ─── Shared small widgets ─────────────────────────────────────────────────────

class _TrackNumber extends StatelessWidget {
  const _TrackNumber({required this.track, required this.size});
  final _RoadmapTrack track;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color =
        track.completed ? const Color(0xFFFFC900) : const Color(0xFF52D8DE);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF0B4A50),
        border: Border.all(color: color, width: 1.4),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: .25), blurRadius: 10)
        ],
      ),
      child: Icon(track.icon, color: color, size: size * .5),
    );
  }
}

class _CompletedBadge extends StatelessWidget {
  const _CompletedBadge({required this.isArabic});
  final bool isArabic;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFC900).withValues(alpha: .12),
          border:
              Border.all(color: const Color(0xFFFFC900).withValues(alpha: .45)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          isArabic ? 'مكتمل' : 'Completed',
          style: GoogleFonts.inter(
              color: const Color(0xFFFFC900),
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
      );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text, required this.accent});
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: GoogleFonts.poppins(
          color: accent,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      );
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({
    required this.text,
    required this.completed,
    required this.bulletColor,
  });
  final String text;
  final bool completed;
  final Color bulletColor;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Icon(Icons.circle, size: 6, color: bulletColor),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: .82),
                  fontSize: 12,
                  height: 1.55,
                  decoration: completed ? TextDecoration.lineThrough : null,
                  decorationColor: bulletColor,
                ),
              ),
            ),
          ],
        ),
      );
}

class _NumberedRow extends StatelessWidget {
  const _NumberedRow(
      {required this.index, required this.text, required this.completed});
  final int index;
  final String text;
  final bool completed;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 7),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .03),
          border:
              Border.all(color: const Color(0xFF52D8DE).withValues(alpha: .14)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              index.toString().padLeft(2, '0'),
              style: GoogleFonts.orbitron(
                  color: const Color(0xFFFFC900),
                  fontSize: 10,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 12,
                  height: 1.45,
                  decoration: completed ? TextDecoration.lineThrough : null,
                  decorationColor: const Color(0xFFFFC900),
                ),
              ),
            ),
          ],
        ),
      );
}

class _SourceChip extends StatelessWidget {
  const _SourceChip({required this.source, this.small = false});
  final String source;
  final bool small;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
            horizontal: small ? 7 : 10, vertical: small ? 4 : 7),
        decoration: BoxDecoration(
          color: const Color(0xFF52D8DE).withValues(alpha: .1),
          border:
              Border.all(color: const Color(0xFF52D8DE).withValues(alpha: .2)),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          source,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: small ? 8 : 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
