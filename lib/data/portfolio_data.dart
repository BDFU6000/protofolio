import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../utils/locale_provider.dart';

// ---------------------------------------------------------------------------
// 📝 PORTFOLIO DATA — Edit this file to customise your portfolio content.
//
// This class holds ALL the text, links, and data displayed on the portfolio.
// No logic or UI code lives here — only pure data constants.
// ---------------------------------------------------------------------------

/// Central data source for the entire portfolio.
///
/// Every section widget reads from this class. To update your portfolio,
/// simply change the values below — no need to touch any widget files.
class PortfolioData {
  PortfolioData._(); // Prevent instantiation; all members are static.

  // -------------------------------------------------------------------------
  // 👤 PERSONAL INFO
  // -------------------------------------------------------------------------

  static String get name => LocaleProvider.isArabic.value
      ? 'عبد المنيب صلاح أبوستة'
      : 'Abd Almoneeb Salah Abusetta';

  static String get tagline => LocaleProvider.isArabic.value
      ? 'خريج علوم حاسوب ومطور شامل'
      : 'CS Graduate & Full-Stack Developer';

  static List<String> get roles => LocaleProvider.isArabic.value
      ? [
          'مطور فلاتر',
          'مطور تطبيقات ويب وجوال',
          'مصمم واجهات (Figma)',
          'مطور مستقل',
          'مطور ذكاء اصطناعي',
          'قائد مشاريع جامعية',
        ]
      : [
          'Flutter Developer',
          'Web & Mobile App Developer',
          'UI/UX Designer (Figma)',
          'Independent Builder',
          'AI Developer',
          'University Project Leader',
        ];

  static const String englishBio = '''
I am a Computer Science graduate from Refak University (February 2026), with hands-on experience across full-stack software development, Flutter and mobile app development, web development, UI/UX design, AI-powered automation, and business workflow analysis.

Over the past eight months, I have built and refined a portfolio of practical projects spanning healthcare software, business automation, ERP workflow design, corporate website development, and experimental AI research. My work includes Smart Clinic, Sidaliti, Doctor Leandek, Tamayoz Al-Da'em ERPNext customization, AI automation experiments, and website and design work for real business needs.

My work follows the full product lifecycle: gathering requirements, analyzing business operations, planning user flows, designing interfaces, researching practical technologies, implementing frontend and backend features, integrating APIs and databases, and testing and refining the product before deployment.

I have also worked on AI and automation projects, including a Smart Clinic AI assistant, a public-data lead generation pipeline based on Google Maps and Google Places, and a research initiative focused on Libyan Arabic speech data and synthetic voice experimentation. These projects were developed as applied learning and product research rather than as production-ready consumer systems.

I have also supported business process design for Tamayoz Al-Da'em by mapping day-to-day operations to ERPNext modules, documenting responsibilities, and simplifying system complexity where unnecessary modules were identified. In parallel, I developed bilingual corporate website work, UI/UX concepts, and focused one-day web page tasks as part of my design and frontend practice.

I have led university project teams as part of my academic work, coordinating tasks, communicating technical decisions, and delivering work to deadlines. I am motivated by building useful software that solves real operational problems while keeping the user experience and business context in focus.
''';

  static const String arabicBio = '''
أنا خريج علوم الحاسوب من جامعة الرفاق (دفعة فبراير 2026)، ولدي خبرة عملية في تطوير البرمجيات بشكل كامل، وتطوير تطبيقات الهاتف والويب، وتصميم واجهات المستخدم، وأتمتة الأعمال بالذكاء الاصطناعي، وتحليل سير العمل في المشاريع التجارية.

خلال الثمانية أشهر الماضية، عملت على مجموعة من المشاريع العملية في مجالات البرمجيات الصحية، الأتمتة التجارية، تصميم سير العمل ERP، تطوير المواقع المؤسسية، والبحث التجريبي في الذكاء الاصطناعي. تشمل أعمالي Smart Clinic وSidaliti وDoctor Leandek، بالإضافة إلى تخصيص ERPNext في Tamayoz Al-Da'em، ومشاريع الذكاء الاصطناعي، والعمل على تصميم المواقع والواجهات.

أتعامل مع دورة حياة المنتج بشكل كامل: جمع المتطلبات، تحليل عمليات الأعمال، تصميم مسارات المستخدم، تصميم الواجهات، البحث عن التقنيات المناسبة، تنفيذ الواجهة الأمامية والخلفية، تكامل APIs وقواعد البيانات، ثم الاختبار والتحسين قبل النشر.

كما عملت على مشاريع الذكاء الاصطناعي والأتمتة، منها مساعد Smart Clinic الذكي، وخط توليد العملاء يعتمد على بيانات عامة من Google Maps وGoogle Places، ومشروع بحثي يركز على بيانات الكلام باللهجة الليبية وتجربة الصوت الاصطناعي. كانت هذه المشاريع تجارب تطبيقية وبحثية وليست أنظمة جاهزة للاستخدام العام.

كما ساعدت في تصميم سير العمل التجاري لشركة Tamayoz Al-Da'em من خلال ربط العمليات اليومية بوحدات ERPNext، وتوثيق المسؤوليات، وتبسيط تعقيد النظام عندما كانت بعض الوحدات غير ضرورية. إضافة إلى ذلك، عملت على تطوير موقع الشركة bilingually، وتصميمات واجهة المستخدم، وعدد من صفحات الويب ذات المهمة المحددة في يوم واحد.

سبق لي أن قمت بقيادة فرق مشاريع جامعية، مع تنسيق المهام، توضيح القرارات التقنية، وتقديم العمل في مواعيده. أهتم ببناء حلول برمجية عملية تعالج احتياجات حقيقية مع مراعاة تجربة المستخدم والسياق التجاري في الوقت نفسه.
''';

  static String get bio =>
      LocaleProvider.isArabic.value ? arabicBio : englishBio;

  // Contact Info
  static const String email = 'moneebabusetta53@gmail.com';
  static const String whatsapp = '+218918474887';
  static const String instagram = '@moneeb_salah6';
  static const String githubUrl = 'https://github.com/BDFU6000';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/moneeb-salah-abusetta-80ab4637b/';
  static const String twitterUrl = '';
  static const String resumeUrl = '';

  // -------------------------------------------------------------------------
  // 📊 STATS (displayed in the About section)
  // -------------------------------------------------------------------------

  static const int yearsOfExperience = 1;
  static const int projectsCompleted = 10;
  static const int satisfiedClients = 2;
  static const int openSourceContributions = 0;

  // -------------------------------------------------------------------------
  // 🛠️ SKILLS
  // -------------------------------------------------------------------------

  static const List<SkillModel> skills = [
    SkillModel(
      name: 'Flutter & Dart',
      emoji: '💙',
      level: 0.95,
      color: '02569B',
    ),
    SkillModel(
      name: 'Firebase',
      emoji: '🔥',
      level: 0.85,
      color: 'FFCA28',
    ),
    SkillModel(
      name: 'Supabase & PostgreSQL',
      emoji: '⚡',
      level: 0.90,
      color: '3ECF8E',
    ),
    SkillModel(
      name: 'Riverpod',
      emoji: '🌊',
      level: 0.90,
      color: '02569B',
    ),
    SkillModel(
      name: 'Python',
      emoji: '🐍',
      level: 0.85,
      color: '3776AB',
    ),
    SkillModel(
      name: 'REST APIs & Webhooks',
      emoji: '🔌',
      level: 0.90,
      color: '4CAF50',
    ),
    SkillModel(
      name: 'UI/UX Design (Figma)',
      emoji: '🎨',
      level: 0.85,
      color: 'F24E1E',
    ),
    SkillModel(
      name: 'Google Maps / Google Places',
      emoji: '🌍',
      level: 0.80,
      color: '4285F4',
    ),
    SkillModel(
      name: 'AI / NLP',
      emoji: '💡',
      level: 0.80,
      color: 'FF6B6B',
    ),
    SkillModel(
      name: 'ERPNext',
      emoji: '📦',
      level: 0.80,
      color: '8B5CF6',
    ),
    SkillModel(
      name: 'Business Workflow Design',
      emoji: '🧭',
      level: 0.85,
      color: '14B8A6',
    ),
    SkillModel(
      name: 'Git & GitHub',
      emoji: '🐙',
      level: 0.90,
      color: 'F05032',
    ),
  ];

  // -------------------------------------------------------------------------
  // 💼 EXPERIENCE
  // -------------------------------------------------------------------------

  static const List<ExperienceModel> arabicExperiences = [
    ExperienceModel(
      role: 'تطوير تطبيقات كاملة المكدس',
      company: 'مشاريع مستقلة / عملاء خاصون',
      period: 'أغسطس 2025 - فبراير 2026',
      description:
          'عملت على بناء تطبيقات وخدمات رقمية تشمل تطبيقات الجوال، أنظمة إدارة، ومشاريع ويب في إطار منتج مستقل ومشاريع عميل خاص. ركزت على جمع المتطلبات، تصميم تجربة المستخدم، التنفيذ، والتكامل مع الخلفية وقواعد البيانات.',
      technologies: ['Flutter', 'Dart', 'Supabase', 'PostgreSQL', 'Riverpod'],
      emoji: '💼',
    ),
    ExperienceModel(
      role: 'تطوير الذكاء الاصطناعي والأتمتة',
      company: 'مشاريع بحثية وتجريبية',
      period: 'سبتمبر 2025 - فبراير 2026',
      description:
          'طورت حلولاً للذكاء الاصطناعي والأتمتة في سياقات عملية، بما في ذلك مساعد ذكي داخل نظام العيادة، خط معالجة بيانات تجارية عامة، وبحث صوتي باللهجة الليبية. ركزت على جمع البيانات، تنظيمها، اختبارها، وتحسينها بدلاً من بناء أنظمة جاهزة للإنتاج.',
      technologies: [
        'Python',
        'Google Places',
        'Ollama',
        'Groq',
        'Google Sheets'
      ],
      emoji: '🤖',
    ),
    ExperienceModel(
      role: 'تخصيص ERPNext',
      company: 'Tamayoz Al-Da\'em',
      period: '2025',
      description:
          'قمت بتحليل العمليات الفعلية للشركة، تصميم مسارات العمل، توثيق المسؤوليات، وربط المتطلبات بوحدات ERPNext في الحسابات، المخزون، المشتريات، المبيعات، الجودة، الصيانة، الأصول، وقسم الموارد البشرية.',
      technologies: [
        'ERPNext',
        'Process Mapping',
        'Microsoft Word',
        'Business Workflow'
      ],
      emoji: '📦',
    ),
    ExperienceModel(
      role: 'تطوير المواقع وتصميم واجهات المستخدم',
      company: 'Tamayoz Al-Da\'em / مشاريع تصميم مستقلة',
      period: '2025',
      description:
          'صممت واطبقت واجهات موقع الشركة بطريقة عربية/إنجليزية، مع مراعاة استجابة الموقع على الشاشات المختلفة، عرض الخدمات، هوية العلامة التجارية، والطلب التجاري عبر نموذج استفسار.',
      technologies: ['Figma', 'Responsive Web', 'Vercel', 'UI/UX'],
      emoji: '🌐',
    ),
    ExperienceModel(
      role: 'قيادة مشاريع الجامعة',
      company: 'Refak University',
      period: '2024 - 2026',
      description:
          'قادت فرقاً أكاديمية في مشاريع رئيسية، مع تنسيق المهام، توضيح القرارات التقنية، ومتابعة التقدم ضمن المواعيد الجامعية. ساعد هذا في تطوير مهاراتي في التواصل والتخطيط والتنفيذ الجماعي.',
      technologies: [
        'Team Coordination',
        'Project Planning',
        'Requirements',
        'Documentation'
      ],
      emoji: '🎓',
    ),
  ];

  static const List<ExperienceModel> englishExperiences = [
    ExperienceModel(
      role: 'Full-Stack Application Development',
      company: 'Independent projects / private clients',
      period: 'Aug 2025 - Feb 2026',
      description:
          'I developed mobile, business, and web application solutions as part of independent product work and client-based projects. My efforts covered requirements gathering, design, implementation, state management, and API/database integration.',
      technologies: ['Flutter', 'Dart', 'Supabase', 'PostgreSQL', 'Riverpod'],
      emoji: '💼',
    ),
    ExperienceModel(
      role: 'Applied AI and Automation Development',
      company: 'Research and experimental projects',
      period: 'Sep 2025 - Feb 2026',
      description:
          'I created practical AI and automation workflows including a Smart Clinic assistant, a public-business lead-generation pipeline, and Libyan Arabic speech research. The focus was on data collection, normalization, experimentation, and iterative improvement rather than production-only systems.',
      technologies: [
        'Python',
        'Google Places',
        'Ollama',
        'Groq',
        'Google Sheets'
      ],
      emoji: '🤖',
    ),
    ExperienceModel(
      role: 'ERPNext Workflow Customization',
      company: 'Tamayoz Al-Da\'em',
      period: '2025',
      description:
          'I analyzed the company’s real operations, designed business workflows, documented responsibilities, and mapped processes to ERPNext modules across Accounts, Stock, Buying, Selling, Quality, Maintenance, Assets, and HR.',
      technologies: [
        'ERPNext',
        'Process Mapping',
        'Microsoft Word',
        'Business Workflow'
      ],
      emoji: '📦',
    ),
    ExperienceModel(
      role: 'Corporate Website and UI/UX Development',
      company: 'Tamayoz Al-Da\'em / independent design work',
      period: '2025',
      description:
          'I designed and implemented a bilingual Arabic-English corporate website, focusing on responsiveness, service presentation, brand clarity, and business inquiry pathways across health and manufacturing sectors.',
      technologies: ['Figma', 'Responsive Web', 'Vercel', 'UI/UX'],
      emoji: '🌐',
    ),
    ExperienceModel(
      role: 'University Project Team Leadership',
      company: 'Refak University',
      period: '2024 - 2026',
      description:
          'I led university project teams on major assignments, coordinating tasks, clarifying technical decisions, and managing progress to meet academic deadlines. This strengthened my project coordination and communication skills.',
      technologies: [
        'Team Coordination',
        'Project Planning',
        'Requirements',
        'Documentation'
      ],
      emoji: '🎓',
    ),
  ];

  static List<ExperienceModel> get experiences =>
      LocaleProvider.isArabic.value ? arabicExperiences : englishExperiences;

  // -------------------------------------------------------------------------
  // 🗂️ PROJECTS
  // -------------------------------------------------------------------------

  static const List<ProjectModel> arabicProjects = [
    ProjectModel(
      title: 'نظام العيادة الذكية',
      description:
          'تطبيق متعدد المستأجرين لإدارة العيادات والعمليات الطبية والإدارية في بيئة موحدة.',
      technologies: ['Flutter', 'Dart', 'Supabase', 'PostgreSQL', 'Riverpod'],
      emoji: '🏥',
      gradientColors: [0xFF1a1a2e, 0xFF16213e],
      completionDate: '2025',
      imageUrl: 'assets/images/smart-clinic.png',
      featuredVisual: 'desktop',
      featuredImages: [
        'assets/images/smart-clinic.png',
      ],
      gallery: [
        ProjectGalleryItem(
          title: 'لوحة نظام العيادة',
          imageUrl: 'assets/images/smart-clinic.png',
          caption:
              'عمليات العيادة متعددة المستأجرين داخل مساحة عمل واحدة على سطح المكتب.',
        ),
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'نطاق المشروع',
          content:
              'تم تصميم النظام كمنصة إدارة عيادات متعددة المستأجرين تدعم الحجز، السجلات الطبية، الصيدلة والمخزون، الموارد البشرية، والمهام الإدارية.',
          iconEmoji: '🏗️',
        ),
        ProjectDetailSection(
          title: 'إدارة الصلاحيات',
          content:
              'يدعم المشروع 11 دوراً للمستخدمين، مع توضيح واضح للأدوار والمسؤوليات. تم دعم الأمان باستخدام سياسات Supabase RLS مع تنظيم مناسب للبيانات المهمة.',
          iconEmoji: '🔐',
        ),
        ProjectDetailSection(
          title: 'التنفيذ',
          content:
              'تم التركيز على قابلية التوسع في إدارة الحالة، وضوح سير العمل، والتكامل بين الوحدات الطبية والإدارية داخل تطبيق Flutter موحد.',
          iconEmoji: '⚙️',
        ),
      ],
    ),
    ProjectModel(
      title: 'Sidaliti',
      description:
          'مشروع منتج مستقل طور خلال نفس الفترة، مع تركيز على تعريف الفكرة، تخطيط تجربة المستخدم، وتصميم وتنفيذ حل مبني على احتياج واضح.',
      technologies: ['Flutter', 'Dart', 'UI/UX', 'Product Planning'],
      emoji: '📱',
      gradientColors: [0xFF0f172a, 0xFF1d4ed8],
      completionDate: '2025',
      detailedSections: [
        ProjectDetailSection(
          title: 'دور المشروع',
          content:
              'شمل المشروع فهم الطلب، بناء مسارات التطبيق، تصميم الواجهات، وتخطيط تنفيذ الحل بشكل موجه نحو تجربة مستخدم واضحة.',
          iconEmoji: '🧭',
        ),
        ProjectDetailSection(
          title: 'التركيز التصميمي',
          content:
              'تمت مراعاة سهولة الاستخدام، وضوح التدفق، وقابلية التوسع في المستقبل داخل القصة الأساسية للمنتج.',
          iconEmoji: '✨',
        ),
      ],
    ),
    ProjectModel(
      title: 'Doctor Leandek',
      description:
          'منظومة صحية متكاملة تشمل تطبيق مرضى، واجهة إدارة صيدليات، لوحة تحكم إدارية، وموقع شركة، مع دعم سير عمل المرضى والأطباء والممرضات والصيدليات والتوصيل.',
      technologies: ['Flutter', 'Dart', 'Supabase', 'Firebase', 'Google Maps'],
      emoji: '💊',
      gradientColors: [0xFF0f3460, 0xFF533483],
      completionDate: '2025',
      imageUrl: 'assets/images/doctor_leandek_main.png',
      featuredVisual: 'mobile',
      featuredImages: [
        'assets/images/doctor_leandek_login.png',
        'assets/images/doctor_leandek_main.png',
      ],
      keyFeatures: [
        'تسجيل الدخول برقم الهاتف عبر OTP وإعداد ملف المريض',
        'الرئيسية مع تصنيفات الخدمات الصحية',
        'طلبات حجز الأطباء والممرضات',
        'تصفح الصيدلية والوصفات وطلب الأدوية',
        'تتبع التوصيل المرتبط بالموقع عبر Google Maps',
        'لوحات إدارية وصيدلية لإدارة سير الخدمة',
      ],
      gallery: [
        ProjectGalleryItem(
          title: 'تسجيل دخول آمن',
          imageUrl: 'assets/images/doctor_leandek_login.png',
          caption: 'دخول عبر رمز OTP وإعداد ملف المريض.',
        ),
        ProjectGalleryItem(
          title: 'الرئيسية للخدمات',
          imageUrl: 'assets/images/doctor_leandek_main.png',
          caption: 'لوحة رئيسية للخدمات والطلبات الصحية.',
        ),
        ProjectGalleryItem(
          title: 'خدمات الرعاية',
          imageUrl: 'assets/images/doctor_leandek_services.webp',
          caption: 'تصنيفات تجمع الرعاية والصيدلية والتوصيل.',
        ),
        ProjectGalleryItem(
          title: 'سير الصيدلية',
          imageUrl: 'assets/images/doctor_leandek_home.webp',
          caption: 'رحلة المريض مع الصيدلية وطلب الأدوية.',
        ),
        ProjectGalleryItem(
          title: 'نظرة المريض',
          imageUrl: 'assets/images/doctor_leandek_hero.webp',
          caption: 'نظرة عامة على المنظومة عبر الواجهات المختلفة.',
        ),
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'رحلة المريض اليومية',
          content:
              'يدخل المريض برقم الهاتف عبر OTP، ثم يستخدم الرئيسية لاكتشاف الخدمات الصحية وطلب المواعيد وبدء طلبات الأدوية من الصيدلية.',
          iconEmoji: '📱',
        ),
        ProjectDetailSection(
          title: 'الصيدلية والتوصيل',
          content:
              'تربط الوصفات وطلب الأدوية وتتبع التوصيل المرتبط بالموقع بين تطبيق المريض وعمليات الصيدلية والتنسيق عبر الخرائط.',
          iconEmoji: '🚚',
        ),
        ProjectDetailSection(
          title: 'الواجهات الإدارية',
          content:
              'تدعم لوحات الصيدلية والإدارة الجانب التشغيلي من المنظومة، إلى جانب موقع الشركة والمنتج الموجه للمريض.',
          iconEmoji: '🧩',
        ),
      ],
    ),
    ProjectModel(
      title: 'مساعد Smart Clinic الذكي',
      description:
          'مساعد ذكائي مدمج داخل المنتج الصحي لدعم سير العمل الطبي والإداري، وتحسين التفاعل داخل بيئة العيادة.',
      technologies: ['Flutter', 'Supabase', 'Python', 'AI Integration'],
      emoji: '🤖',
      gradientColors: [0xFF0f172a, 0xFF7c3aed],
      completionDate: '2025',
      imageUrl: 'assets/images/smart-clinic.png',
      featuredVisual: 'desktop-robot',
      featuredImages: [
        'assets/images/smart-clinic.png',
        'assets/images/Robot_smart_clinic.png',
      ],
      gallery: [
        ProjectGalleryItem(
          title: 'مساحة عمل المساعد الذكي',
          imageUrl: 'assets/images/smart-clinic.png',
          caption:
              'واجهة Smart Clinic التي يعمل داخلها المساعد لدعم المهام اليومية.',
        ),
        ProjectGalleryItem(
          title: 'هوية المساعد',
          imageUrl: 'assets/images/Robot_smart_clinic.png',
          caption:
              'شخصية الروبوت المستخدمة لإظهار طبقة الذكاء الاصطناعي بأسلوب واضح وقريب.',
        ),
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'دور المساعد داخل المنتج',
          content:
              'كان الهدف منه دعم المستخدمين داخل النظام عبر مسارات ذكية مرتبطة بالعمل العيادي، مثل المساعدة في إدخال المعلومات وتسهيل التفاعل داخل العمليات اليومية.',
          iconEmoji: '💬',
        ),
        ProjectDetailSection(
          title: 'التكامل',
          content:
              'تم ربط المساعد بالبنية الحالية داخل المنتج مع الحفاظ على وضوح سير العمل، وتجنب تعقيد إجراءات المستخدم أو нарушения صلاحيات الوصول.',
          iconEmoji: '🧠',
        ),
      ],
    ),
    ProjectModel(
      title: 'خط توليد العملاء التجاري',
      description:
          'خط معالجة بيانات للبحث عن العيادات والمنظمات كفرص شراكات تجارية وعقود، مع الاعتماد على معلومات عامة متاحة من Google Maps وGoogle Places.',
      technologies: [
        'Python',
        'Google Places API',
        'Ollama (Llama 3)',
        'Groq API',
        'Google Sheets',
        'Telethon',
      ],
      emoji: '📈',
      gradientColors: [0xFF111827, 0xFF065f46],
      completionDate: '2025',
      imageUrl: 'assets/images/Seven-Stage Data Pipeline Infographic.png',
      featuredVisual: 'infographic',
      featuredImages: [
        'assets/images/Seven-Stage Data Pipeline Infographic.png',
      ],
      liveUrl:
          'https://docs.google.com/spreadsheets/d/16ZONKqGDntWeHtt9qioxUlpQ2bSFLbrtKTM-2z3EQmA/edit?usp=sharing',
      detailedSections: [
        ProjectDetailSection(
          title: 'مصدر البيانات',
          content:
              'تم استخدام معلومات تجارية عامة متاحة من Google Maps وGoogle Places لأن مجموعات بيانات مناسبة ومكتملة لم تكن متاحة بسهولة في مصادر أخرى. كان التركيز على جمع وتنظيم المعلومات العامة وتخصيصها للبحث والتواصل.',
          iconEmoji: '🌍',
        ),
        ProjectDetailSection(
          title: 'إطار العمل',
          content:
              'تم جمع البيانات وتطبيعها باستخدام Python، مع استخدام Ollama/Llama 3 لتجهيز النصوص، وGroq لتوليد رسائل واتساب مستهدفة، مع مزامنة النتائج داخل جداول Google.',
          iconEmoji: '🧩',
        ),
      ],
    ),
    ProjectModel(
      title: 'بحث الصوت العربي الليبي بالذكاء الاصطناعي',
      description:
          'بحث تجريبي في بيانات اللهجة الليبية، استخراج المقاطع الصوتية، وتدريب نموذج من Open Source على مهام الكلام العربية اللهجية.',
      technologies: ['Python', 'Speech Data', 'Chatterbox', 'GPU Research'],
      emoji: '🎙️',
      gradientColors: [0xFF1f2937, 0xFFb91c1c],
      completionDate: '2026',
      imageUrl: 'assets/images/Libyan_dealect_Ai_voice.png',
      featuredVisual: 'voice-overflow',
      featuredImages: [
        'assets/images/Libyan_dealect_Ai_voice.png',
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'إعداد البيانات',
          content:
              'تم جمع نصوص من 51 حلقة بودكاست ليبية مع محاذاة زمنية دقيقة، مما أنتج 32,876 سطر نصي تقريباً 87.5 ساعة من الكلام. كما تم بناء قاموس لهجي من 11,306 كلمة، وإعداد نص تسجيل من 1,154 سطر.',
          iconEmoji: '📚',
        ),
        ProjectDetailSection(
          title: 'استخراج المقاطع',
          content:
              'تم استخراج 4,814 مقطع صوتي ثم تصفيتها إلى 3,226 مقطعاً أنظف بإجمالي يقارب 8 ساعات، مع إعداد مناسب قبل التدريب.',
          iconEmoji: '🔊',
        ),
        ProjectDetailSection(
          title: 'التدريب والتقييم',
          content:
              'تم ضبط نموذج Chatterbox المفتوح المصدر باستخدام موارد GPU مجانية سحابياً، مع حفظ نقاط التوقف واستئناف التدريب عند الانقطاع. كما تم تصميم صوت اصطناعي مجهول الهوية وتقييم تشابه المتحدث، حيث انخفض التشابه من 0.67 إلى 0.44، وتحسّنت تقييمات الاستماع الداخلية من 6/10 إلى 6.5/10.',
          iconEmoji: '🧠',
        ),
      ],
    ),
    ProjectModel(
      title: 'موقع Tamayoz Al-Da\'em الرسمي',
      description:
          'موقع شركة ثنائي اللغة عربي/إنجليزي تم تطويره بشكل مستقل، مع واجهة متجاوبة، هوية بصرية، وعرض خدمات الشركة وفرص التعاون.',
      technologies: ['Figma', 'Responsive Web', 'Vercel', 'UI/UX'],
      emoji: '🌐',
      gradientColors: [0xFF0f172a, 0xFF0ea5e9],
      completionDate: '2024',
      imageUrl: 'assets/images/Tamayous_website.png',
      featuredVisual: 'desktop-mobile',
      featuredImages: [
        'assets/images/Tamayous_website.png',
        'assets/images/Tamayous_website_mobile .png',
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'مجال الموقع',
          content:
              'شمل الموقع عرض معلومات الشركة، الخدمات، المحتوى الثنائي اللغة، والممرات التجارية لاستفسار العملاء في قطاع الرعاية الصحية والتصنيع.',
          iconEmoji: '🧑‍💻',
        ),
        ProjectDetailSection(
          title: 'الهوية البصرية',
          content:
              'تمت معالجة الهوية البصرية عبر شعار، ألوان، وتقديم الخدمات بطريقة متماسكة تسهل فهم طبيعة الشركة لدى الشركاء المحتملين.',
          iconEmoji: '🎨',
        ),
        ProjectDetailSection(
          title: 'النشر',
          content:
              'تم تنفيذ الموقع ونشره عبر Vercel. كما تم تصميم فكرة إعادة تصميم مستقلة لـ Torrance Expert Concrete كخطة مستقبلية لا كما مشروعًا مُنفّذًا أو مُعتمداً.',
          iconEmoji: '🚀',
        ),
      ],
    ),
    ProjectModel(
      title: 'تخصيص ERPNext في Tamayoz Al-Da\'em',
      description:
          'مبادرة تحليلية وتصميمية لتخصيص ERPNext بناءً على العمليات الحقيقية للشركة، مع تصميم مسارات العمل، وتوثيق الأدوار.',
      technologies: ['ERPNext', 'Business Workflow Design', 'Process Mapping'],
      emoji: '📦',
      gradientColors: [0xFF111827, 0xFF7c2d12],
      completionDate: '2024',
      imageUrl: 'assets/images/ERPNext.png',
      featuredVisual: 'plain-image',
      featuredImages: [
        'assets/images/ERPNext.png',
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'التحليل الوظيفي',
          content:
              'تم تحليل العمليات اليومية للشركة، وتوثيقها، وربطها بوحدات ERPNext في الحسابات، المخزون، المشتريات، المبيعات، الجودة، الصيانة، الأصول، وقسم الموارد البشرية.',
          iconEmoji: '📋',
        ),
        ProjectDetailSection(
          title: 'تصميم سير العمل',
          content:
              'تضمنت المهمة تحديد المسؤوليات، توثيق الإجراءات في Microsoft Word، وتبسيط النظام من خلال التعرف على الوحدات غير الضرورية، مثل المشاريع، التصنيع، التعاقد من الباطن، ونقاط البيع (POS).',
          iconEmoji: '🧭',
        ),
      ],
    ),
    ProjectModel(
      title: 'إعادة تصميم Torrance Expert Concrete',
      description:
          'تصميم مفهوم مستقل لإعادة تصميم موقع خدماتي/صناعي مع تركيز على اكتشاف الخدمات، طلبات التسعير، التصاميم المتجاوبة، وتجربة تقدير التكلفة.',
      technologies: ['Figma', 'UX/UI', 'Responsive Design', 'Concept Design'],
      emoji: '🏗️',
      gradientColors: [0xFF1f2937, 0xFFf59e0b],
      liveUrl: 'https://concept-jade-eta.vercel.app/',
      completionDate: '2025',
      featuredVisual: 'desktop-mobile',
      featuredImages: [
        'assets/images/torrance_website_desktop.jpg',
        'assets/images/torrance_website_mobile.png',
      ],
      websiteComparison: ProjectWebsiteComparison(
        newUrl: 'https://concept-jade-eta.vercel.app/',
        oldUrl: 'https://www.torranceexpertconcrete.com/',
        newLabel: 'المفهوم الجديد',
        oldLabel: 'التصميم الحالي',
        summary:
            'تعريف الزائر بالخدمات بشكل أسرع، وتقليل المسافة بينه وبين طلب السعر، مع عرض متجاوب يعمل بوضوح على الهاتف وسطح المكتب.',
        improvements: [
          'هيكل صفحات أوضح يبدأ بالخدمات ثم الإثبات ثم دعوة طلب السعر.',
          'تسلسل بصري أقوى وعناوين وأزرار أكثر وضوحاً لكل مرحلة من رحلة العميل.',
          'تصميم متجاوب حقيقي للهاتف بدلاً من الاعتماد على عرض سطح المكتب فقط.',
          'تبسيط النصوص وتقليل الفوضى البصرية وإبراز معلومات التواصل والثقة.',
        ],
      ),
      detailedSections: [
        ProjectDetailSection(
          title: 'ما تم تنفيذه',
          content:
              'بنيت نسخة تصورية كاملة للموقع ونشرتها على Vercel، مع إعادة تنظيم المحتوى حول الخدمات، طلب السعر، عرض الأعمال، ومعلومات التواصل. النسخة مصممة كنموذج قابل للتصفح وليست تعديلاً رسمياً على الموقع الحالي للشركة.',
          iconEmoji: '🧩',
        ),
        ProjectDetailSection(
          title: 'كيف تم التنفيذ',
          content:
              'بدأت بتحليل الموقع الحالي وتحديد رحلة الزائر من صفحة البداية حتى طلب السعر. بعدها أعدت صياغة الهيكل المعلوماتي، وصممت نظام ألوان وطباعة وتخطيط متجاوب في Figma، ثم حوّلت التصميم إلى نموذج ويب فعلي مع أقسام واضحة، دعوات إجراء متكررة، وتجربة استخدام متسقة على الهاتف وسطح المكتب.',
          iconEmoji: '🛠️',
        ),
        ProjectDetailSection(
          title: 'الفرق والتطوير',
          content:
              'الموقع الحالي يقدم المعلومات بشكل تقليدي، بينما يركز المفهوم الجديد على وصول أسرع إلى الخدمة المطلوبة، مسار أوضح لطلب التسعير، هيكل بصري أكثر تنظيماً، وتجاوب أفضل مع أحجام الشاشات. الهدف كان تقليل الإدراك والارتباك وزيادة ثقة الزائر قبل التواصل.',
          iconEmoji: '📈',
        ),
        ProjectDetailSection(
          title: 'الطبيعة التجريبية',
          content:
              'هذا العمل تجريبي ومستقل، وتم تطويره أثناء متابعة عميل محتمل. لم يتم تكليفه أو اعتماده أو تنفيذه من قِبل الشركة، ويُعرض هنا كدراسة تصميم ومقارنة بين التصميم الحالي والمفهوم المقترح.',
          iconEmoji: '💡',
        ),
      ],
    ),
    ProjectModel(
      title: 'Feedme — مفهوم واجهة الهاتف',
      description:
          'تصميم شخصي في Figma يركز على اكتشاف الطعام والمطاعم، تفاصيل المنتجات، سلة التسوق، التفاعل الأولي، والتتبع مع أدوار متعددة.',
      technologies: ['Figma', 'Product Design', 'Mobile UI/UX'],
      emoji: '🍽️',
      gradientColors: [0xFF111827, 0xFFef4444],
      completionDate: '2025',
      imageUrl: 'assets/images/Main Page.png',
      featuredVisual: 'mobile',
      featuredImages: [
        'assets/images/Login Page.png',
        'assets/images/Main Page.png',
      ],
      gallery: [
        ProjectGalleryItem(
          title: 'صفحة التسوق',
          imageUrl: 'assets/images/Shopping Page.png',
          caption: 'تصفح الأصناف وبناء الطلب',
        ),
        ProjectGalleryItem(
          title: 'تفاصيل المنتج',
          imageUrl: 'assets/images/Products detiaes Page.png',
          caption: 'خيارات التخصيص قبل الإضافة للسلة',
        ),
        ProjectGalleryItem(
          title: 'سلة التسوق',
          imageUrl: 'assets/images/Cart Page.png',
          caption: 'مراجعة الطلب قبل التأكيد',
        ),
        ProjectGalleryItem(
          title: 'تتبع الطلب',
          imageUrl: 'assets/images/Order tracking Page.png',
          caption: 'متابعة التوصيل بعد تأكيد الطلب',
        ),
        ProjectGalleryItem(
          title: 'الحساب',
          imageUrl: 'assets/images/Account Page.png',
          caption: 'إدارة بيانات الحساب',
        ),
        ProjectGalleryItem(
          title: 'الملف الشخصي',
          imageUrl: 'assets/images/Profile page.png',
          caption: 'إعدادات الملف الشخصي',
        ),
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'مجال التطبيق',
          content:
              'استكشف المشروع تجربة تطبيق لتوصيل الطعام تشمل اكتشاف المطاعم، التخصيص، سلة الطلبات، وتتبع التوصيل.',
          iconEmoji: '🍔',
        ),
        ProjectDetailSection(
          title: 'أدوار المستخدمين',
          content:
              'تم تصميم ثلاثة أدوار رئيسية: العميل، المطعم، والسائق، مع تدفقات مناسبة لكل دور ضمن نظام موحد.',
          iconEmoji: '👥',
        ),
      ],
    ),
  ];

  static const List<ProjectModel> englishProjects = [
    ProjectModel(
      title: 'Smart Clinic',
      description:
          'A multi-tenant clinic management system designed to handle healthcare and administrative workflows in a unified platform.',
      technologies: ['Flutter', 'Dart', 'Supabase', 'PostgreSQL', 'Riverpod'],
      emoji: '🏥',
      gradientColors: [0xFF1a1a2e, 0xFF16213e],
      completionDate: '2025',
      imageUrl: 'assets/images/smart-clinic.png',
      featuredVisual: 'desktop',
      featuredImages: [
        'assets/images/smart-clinic.png',
      ],
      gallery: [
        ProjectGalleryItem(
          title: 'Clinic ERP dashboard',
          imageUrl: 'assets/images/smart-clinic.png',
          caption:
              'Multi-tenant clinic operations in a single desktop workspace.',
        ),
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'Project Scope',
          content:
              'The system was designed as a multi-tenant healthcare and clinic ERP platform covering appointments, medical records, pharmacy and inventory, HR, and administrative operations.',
          iconEmoji: '🏗️',
        ),
        ProjectDetailSection(
          title: 'Access Model',
          content:
              'The application supports 11 user roles with clear separation of responsibilities. Supabase Row Level Security was used to protect access to sensitive data and operational records.',
          iconEmoji: '🔐',
        ),
        ProjectDetailSection(
          title: 'Implementation',
          content:
              'The engineering focus was on scalable state management, modular workflow design, and dependable integration across medical and administrative modules.',
          iconEmoji: '⚙️',
        ),
      ],
    ),
    ProjectModel(
      title: 'Sidaliti',
      description:
          'An independent product-development project completed in the same eight-month period, centered on founding a practical solution and shaping its UX and implementation path.',
      technologies: ['Flutter', 'Dart', 'UI/UX', 'Product Planning'],
      emoji: '📱',
      gradientColors: [0xFF0f172a, 0xFF1d4ed8],
      completionDate: '2025',
      detailedSections: [
        ProjectDetailSection(
          title: 'Project Role',
          content:
              'My work included product discovery, user-flow planning, interface design, and implementation planning for a mobile-first solution aligned to a real problem.',
          iconEmoji: '🧭',
        ),
        ProjectDetailSection(
          title: 'Design Focus',
          content:
              'The project emphasized user clarity, workflow simplicity, and an architecture that could grow beyond the initial concept into a usable product.',
          iconEmoji: '✨',
        ),
      ],
    ),
    ProjectModel(
      title: 'Doctor Leandek',
      description:
          'A connected healthcare service ecosystem including a patient app, pharmacy admin functions, an administrative control panel, and a company website supporting healthcare delivery workflows.',
      technologies: ['Flutter', 'Dart', 'Supabase', 'Firebase', 'Google Maps'],
      emoji: '💊',
      gradientColors: [0xFF0f3460, 0xFF533483],
      completionDate: '2025',
      imageUrl: 'assets/images/doctor_leandek_main.png',
      featuredVisual: 'mobile',
      featuredImages: [
        'assets/images/doctor_leandek_login.png',
        'assets/images/doctor_leandek_main.png',
      ],
      keyFeatures: [
        'Phone OTP sign-in and patient profile setup',
        'Home dashboard with healthcare service categories',
        'Doctor and nurse appointment requests',
        'Pharmacy browsing, prescriptions, and medication ordering',
        'Location-aware delivery tracking with Google Maps',
        'Admin and pharmacy panels for managing service workflows',
      ],
      gallery: [
        ProjectGalleryItem(
          title: 'Secure sign-in',
          imageUrl: 'assets/images/doctor_leandek_login.png',
          caption: 'Phone OTP onboarding and patient profile entry.',
        ),
        ProjectGalleryItem(
          title: 'Service home',
          imageUrl: 'assets/images/doctor_leandek_main.png',
          caption: 'Main dashboard for healthcare services and requests.',
        ),
        ProjectGalleryItem(
          title: 'Care services',
          imageUrl: 'assets/images/doctor_leandek_services.webp',
          caption: 'Service categories spanning care, pharmacy, and delivery.',
        ),
        ProjectGalleryItem(
          title: 'Pharmacy workflow',
          imageUrl: 'assets/images/doctor_leandek_home.webp',
          caption: 'Patient-facing pharmacy and medication journey.',
        ),
        ProjectGalleryItem(
          title: 'Patient overview',
          imageUrl: 'assets/images/doctor_leandek_hero.webp',
          caption: 'Health ecosystem overview across connected surfaces.',
        ),
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'Daily patient journey',
          content:
              'Patients enter with phone OTP, set up their profile, then use the home dashboard to discover healthcare services, request appointments, and start pharmacy orders.',
          iconEmoji: '📱',
        ),
        ProjectDetailSection(
          title: 'Pharmacy and delivery',
          content:
              'Prescriptions, medication ordering, and location-aware delivery tracking connect the patient app with pharmacy operations and maps-based coordination.',
          iconEmoji: '🚚',
        ),
        ProjectDetailSection(
          title: 'Admin surfaces',
          content:
              'Pharmacy and administrative panels support the operational side of the ecosystem, alongside the company website and patient-facing mobile product.',
          iconEmoji: '🧩',
        ),
      ],
    ),
    ProjectModel(
      title: 'Smart Clinic AI Assistant',
      description:
          'An AI assistant integrated into the Smart Clinic product to support healthcare workflows and practical user assistance inside the clinic management system.',
      technologies: ['Flutter', 'Supabase', 'Python', 'AI Integration'],
      emoji: '🤖',
      gradientColors: [0xFF0f172a, 0xFF7c3aed],
      completionDate: '2025',
      imageUrl: 'assets/images/smart-clinic.png',
      featuredVisual: 'desktop-robot',
      featuredImages: [
        'assets/images/smart-clinic.png',
        'assets/images/Robot_smart_clinic.png',
      ],
      gallery: [
        ProjectGalleryItem(
          title: 'AI assistant workspace',
          imageUrl: 'assets/images/smart-clinic.png',
          caption:
              'The Smart Clinic interface where the assistant supports daily work.',
        ),
        ProjectGalleryItem(
          title: 'Assistant identity',
          imageUrl: 'assets/images/Robot_smart_clinic.png',
          caption:
              'Robot character used to make the AI layer visible and approachable.',
        ),
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'Role in Product',
          content:
              'The assistant was intended to support daily clinic work by helping with task flow, information handling, and user interaction patterns inside a healthcare environment.',
          iconEmoji: '💬',
        ),
        ProjectDetailSection(
          title: 'AI Integration',
          content:
              'The feature was connected to the existing product backend and data model to support a useful and low-friction AI layer without disrupting workflow or access control.',
          iconEmoji: '🧠',
        ),
      ],
    ),
    ProjectModel(
      title: 'Business Lead Generation Pipeline',
      description:
          'A data-processing pipeline for identifying clinics and companies as partnership or contract opportunities using public business information from Google Maps and Google Places.',
      technologies: [
        'Python',
        'Google Places API',
        'Ollama (Llama 3)',
        'Groq API',
        'Google Sheets',
        'Telethon',
      ],
      emoji: '📈',
      gradientColors: [0xFF111827, 0xFF065f46],
      completionDate: '2025',
      imageUrl: 'assets/images/Seven-Stage Data Pipeline Infographic.png',
      featuredVisual: 'infographic',
      featuredImages: [
        'assets/images/Seven-Stage Data Pipeline Infographic.png',
      ],
      liveUrl:
          'https://docs.google.com/spreadsheets/d/16ZONKqGDntWeHtt9qioxUlpQ2bSFLbrtKTM-2z3EQmA/edit?usp=sharing',
      detailedSections: [
        ProjectDetailSection(
          title: 'Data Source',
          content:
              'The project used publicly available business information from Google Maps and Google Places because suitable, complete datasets were unavailable elsewhere. The focus was on collecting, organizing, and enriching public business records for research and outreach support.',
          iconEmoji: '🌍',
        ),
        ProjectDetailSection(
          title: 'Processing Workflow',
          content:
              'Python handled data collection and normalization, Ollama/Llama 3 processed raw text, Groq generated outreach drafts, and Google Sheets served as the live reporting layer. The project was intended for research and lead generation support, not for a private or fully verified database.',
          iconEmoji: '🧩',
        ),
      ],
    ),
    ProjectModel(
      title: 'Libyan Arabic AI Voice Research',
      description:
          'An experimental speech-model research project focused on Libyan Arabic dialect data preparation, audio extraction, and fine-tuning an open-source model for evaluation.',
      technologies: ['Python', 'Speech Data', 'Chatterbox', 'GPU Research'],
      emoji: '🎙️',
      gradientColors: [0xFF1f2937, 0xFFb91c1c],
      completionDate: '2026',
      imageUrl: 'assets/images/Libyan_dealect_Ai_voice.png',
      featuredVisual: 'voice-overflow',
      featuredImages: [
        'assets/images/Libyan_dealect_Ai_voice.png',
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'Dataset Preparation',
          content:
              'I collected and timestamp-aligned transcripts from 51 Libyan podcast episodes, creating 32,876 transcript lines and about 87.5 hours of spoken content. I also built a dialect lexicon with 11,306 words and prepared a 1,154-line recording script.',
          iconEmoji: '📚',
        ),
        ProjectDetailSection(
          title: 'Audio Curation',
          content:
              'A total of 4,814 audio clips were extracted and filtered down to 3,226 cleaner clips, totaling about 8 hours of usable speech data for model experimentation.',
          iconEmoji: '🔊',
        ),
        ProjectDetailSection(
          title: 'Fine-Tuning and Evaluation',
          content:
              'The open-source Chatterbox model was fine-tuned using free cloud GPU resources, with checkpoint saving and recovery to manage interrupted sessions. I designed an anonymized synthetic voice and evaluated speaker similarity, reducing the closest-source similarity from 0.67 to 0.44 and improving internal listening scores from 6/10 to 6.5/10.',
          iconEmoji: '🧠',
        ),
      ],
    ),
    ProjectModel(
      title: "Tamayoz Al-Da'em Corporate Website",
      description:
          'A bilingual Arabic-English corporate website developed independently for company presentation, brand display, and inquiry flow in healthcare and manufacturing sectors.',
      technologies: ['Figma', 'Responsive Web', 'Vercel', 'UI/UX'],
      emoji: '🌐',
      gradientColors: [0xFF0f172a, 0xFF0ea5e9],
      completionDate: '2024',
      imageUrl: 'assets/images/Tamayous_website.png',
      featuredVisual: 'desktop-mobile',
      featuredImages: [
        'assets/images/Tamayous_website.png',
        'assets/images/Tamayous_website_mobile .png',
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'Website Scope',
          content:
              'The website included bilingual company content, service presentation, responsive frontend development, and business inquiry pathways for healthcare and product partnership opportunities.',
          iconEmoji: '🧑‍💻',
        ),
        ProjectDetailSection(
          title: 'Brand and UX',
          content:
              'I handled the website’s visual identity, logo direction, and responsive UI decisions to present the company clearly and professionally to potential partners.',
          iconEmoji: '🎨',
        ),
        ProjectDetailSection(
          title: 'Deployment',
          content:
              'The site was deployed through Vercel. This work also informed a separate concept redesign for Torrance Expert Concrete, but it was not a commissioned or approved commercial redesign for the original business.',
          iconEmoji: '🚀',
        ),
      ],
    ),
    ProjectModel(
      title: 'Tamayoz ERPNext Customization',
      description:
          'An ERPNext customization and workflow-design project based on the real operations of the company, covering role mapping, process documentation, and requirements alignment.',
      technologies: ['ERPNext', 'Business Workflow Design', 'Process Mapping'],
      emoji: '📦',
      gradientColors: [0xFF111827, 0xFF7c2d12],
      completionDate: '2024',
      imageUrl: 'assets/images/ERPNext.png',
      featuredVisual: 'plain-image',
      featuredImages: [
        'assets/images/ERPNext.png',
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'Operational Analysis',
          content:
              'I analyzed the actual company operations and mapped them to ERPNext modules such as Accounts, Stock, Buying, Selling, Quality, Maintenance, Assets, and Frappe HR.',
          iconEmoji: '📋',
        ),
        ProjectDetailSection(
          title: 'Workflow Design',
          content:
              'The project included defining roles, documenting processes in Microsoft Word, and simplifying the system by identifying modules that were unnecessary or too broad for the business, including Projects, Manufacturing, Subcontracting, and POS.',
          iconEmoji: '🧭',
        ),
      ],
    ),
    ProjectModel(
      title: 'Torrance Expert Concrete Redesign Concept',
      description:
          'An independent redesign concept for a service-focused business, with emphasis on service discovery, quote requests, responsive layout, and interactive cost-estimation presentation.',
      technologies: ['Figma', 'UX/UI', 'Responsive Design', 'Concept Design'],
      emoji: '🏗️',
      gradientColors: [0xFF1f2937, 0xFFf59e0b],
      liveUrl: 'https://concept-jade-eta.vercel.app/',
      completionDate: '2025',
      featuredVisual: 'desktop-mobile',
      featuredImages: [
        'assets/images/torrance_website_desktop.jpg',
        'assets/images/torrance_website_mobile.png',
      ],
      websiteComparison: ProjectWebsiteComparison(
        newUrl: 'https://concept-jade-eta.vercel.app/',
        oldUrl: 'https://www.torranceexpertconcrete.com/',
        newLabel: 'New concept',
        oldLabel: 'Current design',
        summary:
            'Help visitors understand the services faster, shorten the path to a quote request, and present the business clearly on both phone and desktop.',
        improvements: [
          'A clearer page structure: services first, proof next, then a direct quote request.',
          'Stronger visual hierarchy with clearer headings, spacing, and repeatable calls to action.',
          'A genuinely responsive phone layout instead of relying on the desktop presentation.',
          'Simplified copy and reduced visual noise while keeping contact and trust signals prominent.',
        ],
      ),
      detailedSections: [
        ProjectDetailSection(
          title: 'What I Built',
          content:
              'I created a complete concept site and deployed it on Vercel. The content was reorganised around services, quote requests, selected work, and contact details. It is a browsable prototype, not an official modification of the company’s current website.',
          iconEmoji: '🧩',
        ),
        ProjectDetailSection(
          title: 'How I Built It',
          content:
              'I started by reviewing the current site and mapping the visitor journey from the landing page to the quote request. I then rebuilt the information architecture, defined a responsive colour, typography, and layout system in Figma, and translated it into a working web prototype with clear sections, repeated calls to action, and consistent behaviour on phone and desktop.',
          iconEmoji: '🛠️',
        ),
        ProjectDetailSection(
          title: 'The Difference',
          content:
              'The current site presents information in a traditional way. The new concept focuses on faster service discovery, a clearer quote path, a more organised visual hierarchy, and better adaptation to different screen sizes. The goal was to reduce friction and uncertainty before a visitor gets in touch.',
          iconEmoji: '📈',
        ),
        ProjectDetailSection(
          title: 'Concept Status',
          content:
              'This work is independent and exploratory. It was developed while pursuing a prospective client and was not commissioned, approved, or implemented by the business. It is shown here as a design study and a side-by-side comparison between the current design and the proposed concept.',
          iconEmoji: '💡',
        ),
      ],
    ),
    ProjectModel(
      title: 'Feedme Mobile UI/UX Concept',
      description:
          'A personal Figma concept exploring food and restaurant discovery, product details, shopping cart logic, onboarding, delivery tracking, and multi-role user experiences.',
      technologies: ['Figma', 'Product Design', 'Mobile UI/UX'],
      emoji: '🍽️',
      gradientColors: [0xFF111827, 0xFFef4444],
      completionDate: '2025',
      imageUrl: 'assets/images/Main Page.png',
      featuredVisual: 'mobile',
      featuredImages: [
        'assets/images/Login Page.png',
        'assets/images/Main Page.png',
      ],
      gallery: [
        ProjectGalleryItem(
          title: 'Shopping',
          imageUrl: 'assets/images/Shopping Page.png',
          caption: 'Browse categories and build an order',
        ),
        ProjectGalleryItem(
          title: 'Product Details',
          imageUrl: 'assets/images/Products detiaes Page.png',
          caption: 'Customize an item before adding it to the cart',
        ),
        ProjectGalleryItem(
          title: 'Cart',
          imageUrl: 'assets/images/Cart Page.png',
          caption: 'Review the order before checkout',
        ),
        ProjectGalleryItem(
          title: 'Order Tracking',
          imageUrl: 'assets/images/Order tracking Page.png',
          caption: 'Follow delivery after checkout',
        ),
        ProjectGalleryItem(
          title: 'Account',
          imageUrl: 'assets/images/Account Page.png',
          caption: 'Manage account details',
        ),
        ProjectGalleryItem(
          title: 'Profile',
          imageUrl: 'assets/images/Profile page.png',
          caption: 'Profile settings',
        ),
      ],
      detailedSections: [
        ProjectDetailSection(
          title: 'Domain',
          content:
              'The concept explored restaurant discovery, food customization, cart management, and delivery tracking in a multi-user environment.',
          iconEmoji: '🍔',
        ),
        ProjectDetailSection(
          title: 'User Roles',
          content:
              'The design covers customer, restaurant, and delivery driver flows, each with responsibilities and information needs tailored to a shared food-delivery ecosystem.',
          iconEmoji: '👥',
        ),
      ],
    ),
  ];

  static List<ProjectModel> get projects =>
      LocaleProvider.isArabic.value ? arabicProjects : englishProjects;

  // -------------------------------------------------------------------------
  // 🧭 NAVIGATION
  // -------------------------------------------------------------------------

  static List<String> get navItems => LocaleProvider.isArabic.value
      ? [
          'الرئيسية',
          'المهارات',
          'المشاريع',
          'عني',
          'مساري',
          'ماذا أقدم',
          'التواصل',
        ]
      : [
          'Home',
          'Tools & Technologies',
          'Featured Work',
          'About Me',
          'My Roadmap',
          'What I Do',
          'Contact',
        ];
}
