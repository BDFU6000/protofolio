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
      ? 'عبد المنيب صالح أبوسنة'
      : 'Abd Almoneeb Salah Abusetta';

  static String get tagline => LocaleProvider.isArabic.value
      ? 'خريج علوم حاسوب ومطور فلاتر شامل'
      : 'CS Graduate & Full-Stack Flutter Developer';

  static List<String> get roles => LocaleProvider.isArabic.value
      ? [
          'مطور فلاتر',
          'مهندس تطبيقات هواتف',
          'مصمم واجهات (Figma)',
          'مطور شامل مستقل',
          'قائد فريق',
        ]
      : [
          'Flutter Developer',
          'Mobile App Engineer',
          'UI/UX Designer (Figma)',
          'Solo Full-Stack Builder',
          'Team Leader',
        ];

  static const String englishBio = 'I am a 26-year-old Computer Science graduate from Refak University (Class of Feb 2026), specialising in building full-scale production applications from scratch — solo. Throughout my academic career and beyond, I have shipped 4 complete projects and 2 websites, with 3 additional certified projects through my university. I design every UI myself using Figma before writing a single line of code, giving me complete ownership of the product experience. I have led teams for 2 major college projects, strengthening my ability to communicate, coordinate, and deliver under real deadlines. My passion is taking on big, complex systems and making them work elegantly.';
  static const String arabicBio = 'أنا خريج علوم حاسوب يبلغ من العمر 26 عاماً من جامعة الرفاق (دفعة فبراير 2026)، متخصص في بناء تطبيقات إنتاجية متكاملة من الصفر وبمفردي. خلال مسيرتي الأكاديمية وما بعدها، قمت بإطلاق 4 مشاريع كاملة وموقعين إلكترونيين، بالإضافة إلى 3 مشاريع معتمدة من جامعتي. أقوم بتصميم كل واجهة مستخدم بنفسي باستخدام Figma قبل كتابة سطر واحد من الكود، مما يمنحني ملكية كاملة لتجربة المنتج. لقد قُدت فرقاً لمشروعين جامعيين كبيرين، مما عزز قدرتي على التواصل والتنسيق والتسليم في المواعيد المحددة. شغفي هو مواجهة الأنظمة الكبيرة والمعقدة وجعلها تعمل بأناقة.';

  static String get bio => LocaleProvider.isArabic.value ? arabicBio : englishBio;

  // Contact Info
  static const String email = 'moneebabusetta53@gmail.com';
  static const String whatsapp = '+218918474887';
  static const String instagram = '@moneeb_salah6';
  static const String githubUrl = 'https://github.com/BDFU6000';
  static const String linkedinUrl = '';
  static const String twitterUrl = '';
  static const String resumeUrl = '';

  // -------------------------------------------------------------------------
  // 📊 STATS (displayed in the About section)
  // -------------------------------------------------------------------------

  static const int yearsOfExperience = 2;
  static const int projectsCompleted = 4;
  static const int satisfiedClients = 3;
  static const int openSourceContributions = 1;

  // -------------------------------------------------------------------------
  // 🛠️ SKILLS
  // -------------------------------------------------------------------------

  static const List<SkillModel> skills = [
    SkillModel(name: 'Flutter & Dart', emoji: '💙', level: 0.95, color: '02569B'),
    SkillModel(name: 'Firebase', emoji: '🔥', level: 0.85, color: 'FFCA28'),
    SkillModel(name: 'Supabase & PostgreSQL', emoji: '⚡', level: 0.90, color: '3ECF8E'),
    SkillModel(name: 'Python (AI & Scraping)', emoji: '🐍', level: 0.85, color: '3776AB'),
    SkillModel(name: 'Riverpod & State Mgmt', emoji: '🌊', level: 0.90, color: '02569B'),
    SkillModel(name: 'REST APIs & Webhooks', emoji: '🔌', level: 0.90, color: '4CAF50'),
    SkillModel(name: 'UI/UX Design (Figma)', emoji: '🎨', level: 0.80, color: 'F24E1E'),
    SkillModel(name: 'No-Code / n8n', emoji: '🤖', level: 0.80, color: 'FF6C37'),
    SkillModel(name: 'C# .NET', emoji: '💻', level: 0.75, color: '512BD4'),
    SkillModel(name: 'AI / NLP', emoji: '💡', level: 0.75, color: 'FF6B6B'),
    SkillModel(name: 'Google Maps', emoji: '🌍', level: 0.80, color: '4285F4'),
    SkillModel(name: 'WebRTC', emoji: '🎥', level: 0.70, color: '333333'),
    SkillModel(name: 'Git & GitHub', emoji: '🐙', level: 0.90, color: 'F05032'),
  ];

  // -------------------------------------------------------------------------
  // 💼 EXPERIENCE
  // -------------------------------------------------------------------------

  static const List<ExperienceModel> arabicExperiences = [
    ExperienceModel(
      role: 'مطور وكيل ذكاء اصطناعي وSaaS',
      company: 'مستقل / مصدر مفتوح',
      period: 'أبريل 2026',
      description: 'طورت نظاماً متكاملاً لكشط منشورات الوظائف من تليجرام باستخدام Telethon، وتصنيف البيانات بالذكاء الاصطناعي (Ollama Llama 3) وإثرائها عبر Google Places API وتوليد رسائل تسويق ذكية عبر Groq مع المزامنة مع جداول بيانات جوجل المباشرة. وفي نفس الوقت قمت ببناء نظام العيادة الذكية المعتمد على فلاتر وRiverpod.',
      technologies: ['Python', 'Telethon', 'Ollama (Llama 3)', 'Google Places API', 'Groq API', 'Google Sheets'],
      emoji: '🧠',
    ),
    ExperienceModel(
      role: 'مطور تطبيقات هواتف شامل',
      company: 'عميل خاص (DoctorLeandak)',
      period: 'نهاية 2025',
      description: 'قمت بتصميم وبناء DoctorLeandak، وهو تطبيق رعاية صحية شامل يربط بين المرضى والأطباء والصيدليات وموظفي التوصيل. دمجت خرائط جوجل في الوقت الفعلي ومراسلة Firebase وتعديل كامل البنية لتعتمد على معرفات UUID.',
      technologies: ['Flutter', 'Firebase', 'Supabase', 'Google Maps'],
      emoji: '💊',
    ),
    ExperienceModel(
      role: 'مطور تطبيقات هواتف',
      company: 'مشروع عام ومفتوح المصدر',
      period: '2024',
      description: 'قمت بإنشاء ونشر أول مشروع رئيسي لي، وهو نظام العيادة العامة. بنيت أساس خبرتي في التطبيقات الطبية باستخدام إدارة الحالة الحديثة والبنية القابلة للتطوير.',
      technologies: ['Flutter', 'Dart', 'State Management'],
      emoji: '🏥',
    ),
  ];

  static const List<ExperienceModel> englishExperiences = [
    ExperienceModel(
      role: 'AI Agent & SaaS Developer',
      company: 'Freelance / Open Source',
      period: 'April 2026',
      description:
          'Developed an automated Telegram job scraping pipeline using Telethon, local AI (Ollama Llama 3) for parsing, Google Places API for company contact enrichment, and Groq Cloud API for generating targeted B2B WhatsApp pitches synced live to Google Sheets. Simultaneously built the SmartClinic ERP platform.',
      technologies: ['Python', 'Telethon', 'Ollama (Llama 3)', 'Google Places API', 'Groq API', 'Google Sheets'],
      emoji: '🧠',
    ),
    ExperienceModel(
      role: 'Full Stack Mobile Developer',
      company: 'Private Client (DoctorLeandak)',
      period: 'End of 2025',
      description:
          'Architected and built DoctorLeandak, a comprehensive private healthcare app connecting '
          'patients, doctors, pharmacies, and delivery personnel. Integrated real-time Google Maps '
          'and Firebase messaging, and migrated database schema to secure UUID-based relations.',
      technologies: ['Flutter', 'Firebase', 'Supabase', 'Google Maps'],
      emoji: '💊',
    ),
    ExperienceModel(
      role: 'Mobile App Developer',
      company: 'Public Open Source',
      period: '2024',
      description:
          'Created and published my first major project, a Public Clinic System '
          '(github.com/BDFU6000/Clinic_System). Built the foundation of my medical application '
          'expertise using modern state management and scalable architecture.',
      technologies: ['Flutter', 'Dart', 'State Management'],
      emoji: '🏥',
    ),
  ];

  static List<ExperienceModel> get experiences => LocaleProvider.isArabic.value ? arabicExperiences : englishExperiences;

  // -------------------------------------------------------------------------
  // 🗂️ PROJECTS
  // -------------------------------------------------------------------------

  static const List<ProjectModel> arabicProjects = [
    ProjectModel(
      title: 'نظام العيادة الذكية',
      description: 'تطبيق ERP شامل ومتعدد المستأجرين مصمم لإدارة العيادات. يدعم 11 دوراً مميزاً للمستخدمين ويدير 8 وحدات طبية وإدارية.',
      technologies: ['Flutter', 'Dart', 'Supabase', 'PostgreSQL', 'Riverpod'],
      emoji: '🏥',
      gradientColors: [0xFF1a1a2e, 0xFF16213e],
      imageUrl: 'assets/images/smartclinic_logo.png',
      detailedSections: [
        ProjectDetailSection(
          title: 'بنية النظام',
          content: 'تم بناء النظام كمنصة ERP متعددة المستأجرين. يعتمد على فلاتر لواجهة مستخدم متجاوبة ويعتمد بشدة على Riverpod لإدارة حالة يمكن التنبؤ بها وقابلة للتطوير.',
          iconEmoji: '🏗️',
        ),
        ProjectDetailSection(
          title: 'التحكم في الوصول',
          content: 'يدير النظام بشكل آمن 11 دوراً (مالك النظام، مسؤول العيادة، طبيب، ممرض، إلخ). كل إجراء محمي بسياسات RLS صارمة من Supabase لضمان الخصوصية.',
          iconEmoji: '🔐',
        ),
        ProjectDetailSection(
          title: 'الوحدات الأساسية',
          content: 'يحتوي على 8 وحدات مدمجة بالكامل بما في ذلك جدولة المواعيد في الوقت الفعلي، السجلات الطبية (EMR)، تتبع الصيدلية والمخزون، وإدارة الموارد البشرية.',
          iconEmoji: '⚙️',
        ),
      ],
    ),
    ProjectModel(
      title: 'DoctorLeandak',
      description: 'نظام شامل لإدارة الرعاية الصحية يربط بين المرضى والأطباء والصيدليات وموظفي التوصيل. يتميز بمصادقة متعددة الأدوار وتحديثات طبية في الوقت الفعلي.',
      technologies: ['Flutter', 'Dart', 'Supabase', 'Firebase', 'Google Maps'],
      emoji: '💊',
      gradientColors: [0xFF0f3460, 0xFF533483],
      imageUrl: 'assets/images/doctorleandak_logo.png',
      detailedSections: [
        ProjectDetailSection(
          title: 'نظام الخدمات',
          content: 'يسد التطبيق الفجوة بين الأطراف الصحية المتعددة. يوفر مسارات مخصصة للمرضى والأطباء والصيدليات، تتواصل جميعها بسلاسة عبر خلفية موحدة.',
          iconEmoji: '🌐',
        ),
        ProjectDetailSection(
          title: 'اتصال في الوقت الفعلي',
          content: 'يستخدم Supabase Realtime و Firebase FCM لتنبيه الأطباء فوراً، وإشعار المرضى بحالة الوصفات، وتتبع التوصيل الطارئ عبر خرائط جوجل.',
          iconEmoji: '⚡',
        ),
        ProjectDetailSection(
          title: 'إدارة البيانات الطبية',
          content: 'يتعامل بأمان مع تاريخ المرضى، والوصفات الرقمية، ومكالمات الطوارئ. تم ترحيل قاعدة البيانات إلى بنية علائقية تعتمد على UUID لدعم التوسع الهائل.',
          iconEmoji: '🗄️',
        ),
      ],
    ),
    ProjectModel(
      title: 'كاشط وظائف تليجرام ومنظومة توليد العملاء (AI)',
      description: 'نظام بايثون متكامل لكشط منشورات الوظائف من قنوات تليجرام في الوقت الفعلي، واستخلاص بيانات الشركات، وإثرائها باستخدام Google Places API وتوليد رسائل B2B مخصصة عبر Groq Cloud، مع المزامنة الفورية لجداول بيانات جوجل.',
      technologies: ['Python', 'Telethon', 'Ollama (Llama 3)', 'Google Places API', 'Groq API', 'Google Sheets'],
      emoji: '🤖',
      gradientColors: [0xFF1a1a2e, 0xFF4a0e8f],
      liveUrl: 'https://docs.google.com/spreadsheets/d/16ZONKqGDntWeHtt9qioxUlpQ2bSFLbrtKTM-2z3EQmA/edit?usp=sharing',
      detailedSections: [
        ProjectDetailSection(
          title: 'كشط البيانات والتحكم في القيود (Telethon)',
          content: 'تطبيق غير متزامن مبني بمكتبة Telethon يرصد القنوات المستهدفة (مثل Libyanjobs و ziadjobs) لجلب الإعلانات فورياً أو تاريخياً دفعة واحدة، مع آلية تأخير ذكي عشوائي (2-5 ثوانٍ) لتفادي حظر API من تليجرام.',
          iconEmoji: '🔍',
        ),
        ProjectDetailSection(
          title: 'استخلاص وهندسة الأوامر (Llama 3)',
          content: 'خادم Flask محلي يوجه نصوص الوظائف الخام لنموذج Llama 3 محلي عبر Ollama لاستخراج أسماء الشركات، المسميات الوظيفية، البريد، والهاتف، مع استنتاج نقاط الضعف وصياغة عرض مخصص وتنسيقه كملف JSON.',
          iconEmoji: '🧠',
        ),
        ProjectDetailSection(
          title: 'إثراء البيانات وجداول جوجل الحية (Groq & Places)',
          content: 'يقوم بالبحث عن معرف الشركة في خرائط جوجل لجلب الهاتف المعتمد والبريد والموقع الجغرافي. يمرر النتائج لـ Groq API (Llama 3.1) لتصنيف التخصص وكتابة رسالة B2B للواتساب تقل عن 40 كلمة، ثم يرفع البيانات لحظياً إلى جدول بيانات جوجل.',
          iconEmoji: '📊',
        ),
      ],
    ),
  ];

  static const List<ProjectModel> englishProjects = [
    ProjectModel(
      title: 'Smart Clinic System',
      description:
          'A comprehensive multi-tenant SaaS Enterprise Resource Planning (ERP) application '
          'designed for clinic management. Supports 11 distinct user roles and manages 8 '
          'medical and administrative modules.',
      technologies: ['Flutter', 'Dart', 'Supabase', 'PostgreSQL', 'Riverpod'],
      emoji: '🏥',
      gradientColors: [0xFF1a1a2e, 0xFF16213e],
      imageUrl: 'assets/images/smartclinic_logo.png',
      detailedSections: [
        ProjectDetailSection(
          title: 'System Architecture',
          content: 'SmartClinic is built as a multi-tenant Enterprise Resource Planning (ERP) platform. '
              'It utilizes Flutter for a responsive cross-platform UI and relies heavily on Riverpod for '
              'predictable, scalable state management across complex medical workflows.',
          iconEmoji: '🏗️',
        ),
        ProjectDetailSection(
          title: 'Role-Based Access Control',
          content: 'The system securely manages 11 distinct user roles (System Owner, Clinic Admin, Doctor, '
              'Nurse, Receptionist, HR, Lab Technician, etc.). Every action is guarded by strict Supabase '
              'Row Level Security (RLS) policies to ensure data privacy and HIPAA compliance.',
          iconEmoji: '🔐',
        ),
        ProjectDetailSection(
          title: 'Core Modules',
          content: 'Contains 8 fully integrated modules including real-time Appointment Scheduling, '
              'electronic Medical Records (EMR), Pharmacy & Inventory tracking, and a comprehensive HR suite '
              'for staff management and payroll processing.',
          iconEmoji: '⚙️',
        ),
      ],
    ),
    ProjectModel(
      title: 'DoctorLeandak',
      description:
          'A comprehensive healthcare management system connecting patients, doctors, '
          'pharmacies, and emergency delivery personnel. Features multi-role '
          'authentication and real-time medical updates.',
      technologies: ['Flutter', 'Dart', 'Supabase', 'Firebase', 'Google Maps'],
      emoji: '💊',
      gradientColors: [0xFF0f3460, 0xFF533483],
      imageUrl: 'assets/images/doctorleandak_logo.png',
      detailedSections: [
        ProjectDetailSection(
          title: 'Service Ecosystem',
          content: 'DoctorLeandak bridges the gap between multiple healthcare stakeholders. It provides '
              'dedicated application flows for Patients, Doctors, Pharmacies, and Delivery Drivers, all '
              'communicating seamlessly through a unified backend.',
          iconEmoji: '🌐',
        ),
        ProjectDetailSection(
          title: 'Real-Time Connectivity',
          content: 'Utilizes Supabase Realtime and Firebase Cloud Messaging (FCM) to instantly alert '
              'doctors of new bookings, notify patients of prescription statuses, and track emergency '
              'deliveries live on Google Maps.',
          iconEmoji: '⚡',
        ),
        ProjectDetailSection(
          title: 'Medical Data Management',
          content: 'Securely handles patient histories, digital prescriptions, and emergency calls. '
              'The entire database was recently migrated to a robust UUID-based relational architecture '
              'to support massive scaling and prevent data collisions.',
          iconEmoji: '🗄️',
        ),
      ],
    ),
    ProjectModel(
      title: 'Telegram Job Scraper & AI Lead Gen Pipeline',
      description:
          'A comprehensive Python data pipeline that scrapes Telegram job postings, extracts and structures company data using local Llama 3, enriches contact details via Google Places API, generates custom B2B outreach pitches via Groq Cloud, and syncs all results live to Google Sheets.',
      technologies: ['Python', 'Telethon', 'Ollama (Llama 3)', 'Google Places API', 'Groq API', 'Google Sheets'],
      emoji: '🤖',
      gradientColors: [0xFF1a1a2e, 0xFF4a0e8f],
      liveUrl: 'https://docs.google.com/spreadsheets/d/16ZONKqGDntWeHtt9qioxUlpQ2bSFLbrtKTM-2z3EQmA/edit?usp=sharing',
      detailedSections: [
        ProjectDetailSection(
          title: 'Asynchronous Telegram Scraper',
          content:
              'Uses Python and Telethon to monitor and extract job advertisements in real-time or historically from target channels (e.g. Libyanjobs, ziadjobs). Implements randomized delay thresholds (2-5s) to bypass Telegram API rate limit controls.',
          iconEmoji: '🔍',
        ),
        ProjectDetailSection(
          title: 'Structured AI Extraction (Llama 3)',
          content:
              'An active Flask server that processes raw channel text through Ollama (Llama 3), using structured Arabic prompt engineering to accurately extract names, contact info, job postings, and deduce potential business pain points.',
          iconEmoji: '🧠',
        ),
        ProjectDetailSection(
          title: 'Places Enrichment & Groq B2B Pitching',
          content:
              'Enriches listings by querying Google Places API for verified phone numbers, websites, and physical locations. Uses Groq Cloud API (Llama 3.1) to classify business specializations and draft tailored WhatsApp marketing pitches, syncing all data live to a shared Google Sheet dashboard.',
          iconEmoji: '📊',
        ),
      ],
    ),
  ];

  static List<ProjectModel> get projects => LocaleProvider.isArabic.value ? arabicProjects : englishProjects;

  // -------------------------------------------------------------------------
  // 🧭 NAVIGATION
  // -------------------------------------------------------------------------

  static List<String> get navItems => LocaleProvider.isArabic.value
      ? [
          'الرئيسية',
          'عني',
          'المهارات',
          'الخبرات',
          'المشاريع',
          'التواصل',
        ]
      : [
          'Home',
          'About',
          'Skills',
          'Experience',
          'Projects',
          'Contact',
        ];
}
