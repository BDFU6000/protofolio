import '../models/project_model.dart';

enum ProjectSpecKind {
  platform,
  product,
  ecosystem,
  ai,
  automation,
  research,
  website,
  operations,
  mobile,
}

class ProjectSpecStat {
  final String value;
  final String label;

  const ProjectSpecStat({required this.value, required this.label});
}

class ProjectSpecStep {
  final String title;
  final String body;
  final String icon;
  final String? tool;

  const ProjectSpecStep({
    required this.title,
    required this.body,
    required this.icon,
    this.tool,
  });
}

class ProjectDetailSpec {
  final ProjectSpecKind kind;
  final String eyebrow;
  final String focus;
  final List<ProjectSpecStat> stats;
  final List<ProjectSpecStep> steps;
  final String galleryLabel;

  const ProjectDetailSpec({
    required this.kind,
    required this.eyebrow,
    required this.focus,
    required this.stats,
    required this.steps,
    required this.galleryLabel,
  });
}

class ProjectSpecCatalog {
  static ProjectDetailSpec forProject(ProjectModel project, bool isArabic) {
    switch (project.emoji) {
      case '🏥':
        return isArabic ? _smartClinicAr : _smartClinicEn;
      case '📱':
        return isArabic ? _sidalitiAr : _sidalitiEn;
      case '💊':
        return isArabic ? _doctorAr : _doctorEn;
      case '🤖':
        return isArabic ? _assistantAr : _assistantEn;
      case '📈':
        return isArabic ? _leadsAr : _leadsEn;
      case '🎙️':
        return isArabic ? _voiceAr : _voiceEn;
      case '🌐':
        return isArabic ? _tamayozWebAr : _tamayozWebEn;
      case '📦':
        return isArabic ? _erpAr : _erpEn;
      case '🏗️':
        return isArabic ? _torranceAr : _torranceEn;
      case '🍽️':
        return isArabic ? _feedmeAr : _feedmeEn;
      default:
        return isArabic ? _genericAr : _genericEn;
    }
  }

  static const _smartClinicEn = ProjectDetailSpec(
    kind: ProjectSpecKind.platform,
    eyebrow: 'Clinic operating system',
    focus:
        'A unified platform for appointments, medical records, pharmacy operations, and clinic administration.',
    stats: [
      ProjectSpecStat(value: '11', label: 'User roles'),
      ProjectSpecStat(value: '5', label: 'Core modules'),
      ProjectSpecStat(value: 'RLS', label: 'Data protection'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Multi-tenant foundation',
        body:
            'The system was framed as a clinic ERP platform where separate tenants share one product while keeping their operational data isolated.',
        icon: '🏗️',
      ),
      ProjectSpecStep(
        title: 'Role-aware workflows',
        body:
            'Eleven user roles were mapped to clear responsibilities, with access rules designed around real clinic and administrative work.',
        icon: '🔐',
      ),
      ProjectSpecStep(
        title: 'Connected modules',
        body:
            'Appointments, records, pharmacy, inventory, HR, and administration were designed to work as one connected operating experience.',
        icon: '⚙️',
      ),
    ],
    galleryLabel: 'System surfaces',
  );

  static const _smartClinicAr = ProjectDetailSpec(
    kind: ProjectSpecKind.platform,
    eyebrow: 'نظام تشغيل العيادة',
    focus:
        'منصة موحدة تجمع الحجز والسجلات الطبية والصيدلة والمهام الإدارية داخل منتج واحد.',
    stats: [
      ProjectSpecStat(value: '11', label: 'دور مستخدم'),
      ProjectSpecStat(value: '5', label: 'وحدات أساسية'),
      ProjectSpecStat(value: 'RLS', label: 'حماية البيانات'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'أساس متعدد المستأجرين',
        body:
            'تم تصميم النظام كمنصة عيادات تجمع عدة مستأجرين في منتج واحد مع فصل واضح بين بيانات كل عيادة.',
        icon: '🏗️',
      ),
      ProjectSpecStep(
        title: 'سير عمل حسب الدور',
        body:
            'تم تحديد أحد عشر دوراً مستخدماً ومسؤوليات واضحة لكل دور، مع ضبط الوصول بما يخدم العمل العيادي والإداري.',
        icon: '🔐',
      ),
      ProjectSpecStep(
        title: 'وحدات مترابطة',
        body:
            'صُممت المواعيد والسجلات والصيدلة والمخزون والموارد البشرية والإدارة لتعمل كتجربة تشغيلية واحدة.',
        icon: '⚙️',
      ),
    ],
    galleryLabel: 'واجهات النظام',
  );

  static const _sidalitiEn = ProjectDetailSpec(
    kind: ProjectSpecKind.product,
    eyebrow: 'Independent product study',
    focus:
        'A product-discovery project shaped around finding a practical problem, clarifying the UX, and planning a mobile-first build.',
    stats: [
      ProjectSpecStat(value: 'UX', label: 'Discovery-led'),
      ProjectSpecStat(value: 'Mobile', label: 'First surface'),
      ProjectSpecStat(value: 'Flutter', label: 'Build path'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Problem framing',
        body:
            'The first stage focused on understanding the need, defining the product story, and avoiding feature ideas without a clear purpose.',
        icon: '🧭',
      ),
      ProjectSpecStep(
        title: 'Flow planning',
        body:
            'Core user paths were mapped before interface work, keeping the experience simple and easy to follow.',
        icon: '🗺️',
      ),
      ProjectSpecStep(
        title: 'Scalable foundation',
        body:
            'The concept was planned so the initial product story could grow into a clearer, more complete implementation later.',
        icon: '✨',
      ),
    ],
    galleryLabel: 'Product direction',
  );

  static const _sidalitiAr = ProjectDetailSpec(
    kind: ProjectSpecKind.product,
    eyebrow: 'دراسة منتج مستقلة',
    focus:
        'مشروع يركز على اكتشاف مشكلة عملية، وتوضيح تجربة المستخدم، وتخطيط مسار تنفيذ أولي للهاتف.',
    stats: [
      ProjectSpecStat(value: 'UX', label: 'تجربة المستخدم'),
      ProjectSpecStat(value: 'جوال', label: 'الواجهة الأولى'),
      ProjectSpecStat(value: 'Flutter', label: 'مسار التنفيذ'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'تحديد المشكلة',
        body:
            'بدأ العمل بفهم الحاجة وتحديد قصة المنتج، مع تجنب إضافة ميزات بلا هدف واضح.',
        icon: '🧭',
      ),
      ProjectSpecStep(
        title: 'تخطيط المسارات',
        body:
            'تم رسم مسارات المستخدم الأساسية قبل تصميم الواجهات للحفاظ على بساطة التدفق ووضوحه.',
        icon: '🗺️',
      ),
      ProjectSpecStep(
        title: 'أساس قابل للتوسع',
        body:
            'تم تخطيط المفهوم بحيث يمكن تطويره لاحقاً إلى منتج أكثر اكتمالاً دون فقدان وضوح الفكرة الأولى.',
        icon: '✨',
      ),
    ],
    galleryLabel: 'اتجاه المنتج',
  );

  static const _doctorEn = ProjectDetailSpec(
    kind: ProjectSpecKind.ecosystem,
    eyebrow: 'Main feature set',
    focus:
        'A healthcare app ecosystem centered on phone OTP access, service discovery, pharmacy workflows, appointments, and location-aware delivery tracking.',
    stats: [
      ProjectSpecStat(value: 'OTP', label: 'Phone sign-in'),
      ProjectSpecStat(value: '4', label: 'Product surfaces'),
      ProjectSpecStat(value: 'Maps', label: 'Delivery tracking'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Patient access',
        body:
            'Phone OTP sign-in and profile setup lead into a home dashboard where patients can discover and request healthcare services.',
        icon: '📱',
      ),
      ProjectSpecStep(
        title: 'Care services',
        body:
            'Appointment requests, doctor and nurse interactions, pharmacy browsing, prescriptions, and medication ordering form the core journey.',
        icon: '🩺',
      ),
      ProjectSpecStep(
        title: 'Delivery and admin',
        body:
            'Maps-based delivery tracking is paired with pharmacy and administrative panels that keep the service workflow coordinated.',
        icon: '🚚',
      ),
    ],
    galleryLabel: 'Main app screens',
  );

  static const _doctorAr = ProjectDetailSpec(
    kind: ProjectSpecKind.ecosystem,
    eyebrow: 'أهم المميزات',
    focus:
        'منظومة تطبيق صحي تركز على الدخول برقم الهاتف واكتشاف الخدمات وسير الصيدلية وحجز المواعيد وتتبع التوصيل المرتبط بالموقع.',
    stats: [
      ProjectSpecStat(value: 'OTP', label: 'دخول بالهاتف'),
      ProjectSpecStat(value: '4', label: 'واجهات منتج'),
      ProjectSpecStat(value: 'Maps', label: 'تتبع التوصيل'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'دخول المريض',
        body:
            'يفتح تسجيل الدخول برقم الهاتف عبر OTP وإعداد الملف الشخصي إلى الرئيسية حيث يكتشف المريض الخدمات الصحية ويطلبها.',
        icon: '📱',
      ),
      ProjectSpecStep(
        title: 'خدمات الرعاية',
        body:
            'تشكل طلبات المواعيد والتعامل مع الأطباء والممرضات وتصفح الصيدلية والوصفات وطلب الأدوية الرحلة الأساسية.',
        icon: '🩺',
      ),
      ProjectSpecStep(
        title: 'التوصيل والإدارة',
        body:
            'يقترن تتبع التوصيل عبر الخرائط بلوحات الصيدلية والإدارة التي تحافظ على تناسق سير العمل التشغيلي.',
        icon: '🚚',
      ),
    ],
    galleryLabel: 'شاشات التطبيق الرئيسية',
  );

  static const _assistantEn = ProjectDetailSpec(
    kind: ProjectSpecKind.ai,
    eyebrow: 'AI layer inside a product',
    focus:
        'An assistive intelligence layer built into Smart Clinic to support daily work without adding friction to clinical workflows.',
    stats: [
      ProjectSpecStat(value: 'In-product', label: 'Delivery model'),
      ProjectSpecStat(value: 'Low-friction', label: 'Interaction goal'),
      ProjectSpecStat(value: 'Access-aware', label: 'Design constraint'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Assistive role',
        body:
            'The assistant was defined as a helper for task flow and information handling, not as a replacement for clinical decisions.',
        icon: '💬',
      ),
      ProjectSpecStep(
        title: 'Context integration',
        body:
            'It was connected to the existing product model and backend so suggestions could stay relevant to the current workflow.',
        icon: '🧠',
      ),
      ProjectSpecStep(
        title: 'Guardrails',
        body:
            'The interaction was designed to respect existing access control and avoid complicating established clinic procedures.',
        icon: '🔐',
      ),
    ],
    galleryLabel: 'Assistant context',
  );

  static const _assistantAr = ProjectDetailSpec(
    kind: ProjectSpecKind.ai,
    eyebrow: 'طبقة ذكاء داخل المنتج',
    focus:
        'طبقة مساعدة ذكية مدمجة في Smart Clinic لدعم العمل اليومي دون تعقيد سير العمل العيادي.',
    stats: [
      ProjectSpecStat(value: 'داخل المنتج', label: 'نموذج التقديم'),
      ProjectSpecStat(value: 'خفيف', label: 'هدف التفاعل'),
      ProjectSpecStat(value: 'بالصلاحيات', label: 'قيد التصميم'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'دور مساعد',
        body:
            'تم تعريف المساعد كأداة مساعدة في تدفق المهام ومعالجة المعلومات، وليس كبديل للقرار الطبي.',
        icon: '💬',
      ),
      ProjectSpecStep(
        title: 'ربط بالسياق',
        body:
            'تم ربط المساعد بنموذج المنتج والخلفية الحالية حتى تبقى المساعدة مرتبطة بالعمل الجاري.',
        icon: '🧠',
      ),
      ProjectSpecStep(
        title: 'حدود واضحة',
        body:
            'رُوعي احترام صلاحيات الوصول وعدم تعقيد الإجراءات المعتمدة داخل العيادة.',
        icon: '🔐',
      ),
    ],
    galleryLabel: 'سياق المساعد',
  );

  static const _leadsEn = ProjectDetailSpec(
    kind: ProjectSpecKind.automation,
    eyebrow: 'Public data to outreach',
    focus:
        'A Python pipeline turning public business listings into organised lead records, enriched drafts, and a live reporting sheet.',
    stats: [
      ProjectSpecStat(value: '6', label: 'Connected tools'),
      ProjectSpecStat(value: 'Public', label: 'Data source'),
      ProjectSpecStat(value: 'Sheets', label: 'Reporting layer'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Collect public listings',
        body:
            'Public clinic and company listings were gathered from Google Maps and Google Places because complete datasets were not available elsewhere.',
        icon: '🌍',
        tool: 'Google Maps / Places',
      ),
      ProjectSpecStep(
        title: 'Extract raw fields',
        body:
            'Python pulled names, categories, locations, contact details, and source links into a working record set.',
        icon: '📥',
        tool: 'Python',
      ),
      ProjectSpecStep(
        title: 'Clean the records',
        body:
            'Duplicate and incomplete rows were removed, then remaining fields were standardized so every lead had the same structure.',
        icon: '🧹',
        tool: 'Python',
      ),
      ProjectSpecStep(
        title: 'Filter and qualify',
        body:
            'Records were narrowed to clinics and companies that matched the partnership and contract opportunity criteria.',
        icon: '🎯',
        tool: 'Python rules',
      ),
      ProjectSpecStep(
        title: 'Prepare the text',
        body:
            'Ollama with Llama 3 normalized raw descriptions and shaped the context used for each outreach draft.',
        icon: '🧠',
        tool: 'Ollama / Llama 3',
      ),
      ProjectSpecStep(
        title: 'Draft outreach',
        body:
            'Groq generated targeted outreach messages from the qualified records and prepared context.',
        icon: '✉️',
        tool: 'Groq API',
      ),
      ProjectSpecStep(
        title: 'Report and review',
        body:
            'Google Sheets held the cleaned records, drafts, and review status so follow-up stayed practical and easy to inspect.',
        icon: '📊',
        tool: 'Google Sheets',
      ),
    ],
    galleryLabel: 'Pipeline view',
  );

  static const _leadsAr = ProjectDetailSpec(
    kind: ProjectSpecKind.automation,
    eyebrow: 'من بيانات عامة إلى تواصل',
    focus:
        'خط Python يحول البيانات التجارية العامة إلى سجلات عملاء منظمة ومسودات مخصصة وتقرير حي داخل الجداول.',
    stats: [
      ProjectSpecStat(value: '6', label: 'أدوات متصلة'),
      ProjectSpecStat(value: 'عام', label: 'مصدر البيانات'),
      ProjectSpecStat(value: 'Sheets', label: 'طبقة العرض'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'جمع القوائم العامة',
        body:
            'تم جمع قوائم العيادات والشركات العامة من Google Maps وGoogle Places لأن مجموعات بيانات مكتملة لم تكن متاحة من مصادر أخرى.',
        icon: '🌍',
        tool: 'Google Maps / Places',
      ),
      ProjectSpecStep(
        title: 'استخراج الحقول',
        body:
            'استخرجت Python الأسماء والتصنيفات والمواقع وبيانات التواصل وروابط المصدر إلى سجلات عمل قابلة للمعالجة.',
        icon: '📥',
        tool: 'Python',
      ),
      ProjectSpecStep(
        title: 'تنظيف السجلات',
        body:
            'تم حذف الصفوف المكررة وغير المكتملة، ثم توحيد الحقول المتبقية حتى تصبح كل بيانات عميل بنفس البنية.',
        icon: '🧹',
        tool: 'Python',
      ),
      ProjectSpecStep(
        title: 'التصفية والتأهيل',
        body:
            'تم تضييق السجلات إلى العيادات والشركات المطابقة لمعايير فرص الشراكة والعقود.',
        icon: '🎯',
        tool: 'قواعد Python',
      ),
      ProjectSpecStep(
        title: 'تجهيز النصوص',
        body:
            'ساعد Ollama مع Llama 3 في توحيد الأوصاف الخام وتجهيز السياق المستخدم في كل مسودة تواصل.',
        icon: '🧠',
        tool: 'Ollama / Llama 3',
      ),
      ProjectSpecStep(
        title: 'كتابة مسودات التواصل',
        body:
            'أنشأ Groq رسائل تواصل مستهدفة من السجلات المؤهلة والسياق المجهز.',
        icon: '✉️',
        tool: 'Groq API',
      ),
      ProjectSpecStep(
        title: 'العرض والمراجعة',
        body:
            'حفظت جداول Google السجلات المنظفة والمسودات وحالة المراجعة، لتبقى المتابعة عملية وسهلة الفحص.',
        icon: '📊',
        tool: 'Google Sheets',
      ),
    ],
    galleryLabel: 'عرض الخط',
  );

  static const _voiceEn = ProjectDetailSpec(
    kind: ProjectSpecKind.research,
    eyebrow: 'Libyan Arabic speech research',
    focus:
        'An experimental study preparing Libyan dialect speech data and fine-tuning an open-source voice model for evaluation.',
    stats: [
      ProjectSpecStat(value: '87.5h', label: 'Aligned speech'),
      ProjectSpecStat(value: '3,226', label: 'Curated clips'),
      ProjectSpecStat(value: '0.44', label: 'Similarity after test'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Build the corpus',
        body:
            'Transcripts from 51 Libyan podcast episodes were timestamp-aligned, producing 32,876 lines and a dialect lexicon.',
        icon: '📚',
      ),
      ProjectSpecStep(
        title: 'Curate audio',
        body:
            '4,814 extracted clips were filtered to 3,226 cleaner clips, forming about eight hours of usable speech data.',
        icon: '🔊',
      ),
      ProjectSpecStep(
        title: 'Fine-tune and evaluate',
        body:
            'Chatterbox was fine-tuned with checkpoint recovery, then evaluated with an anonymised synthetic voice and listening tests.',
        icon: '🧠',
      ),
    ],
    galleryLabel: 'Research artefacts',
  );

  static const _voiceAr = ProjectDetailSpec(
    kind: ProjectSpecKind.research,
    eyebrow: 'بحث الصوت العربي الليبي',
    focus:
        'دراسة تجريبية لإعداد بيانات الكلام باللهجة الليبية وضبط نموذج صوت مفتوح المصدر وتقييمه.',
    stats: [
      ProjectSpecStat(value: '87.5س', label: 'كلام محاذى'),
      ProjectSpecStat(value: '3,226', label: 'مقطع منقى'),
      ProjectSpecStat(value: '0.44', label: 'التشابه بعد الاختبار'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'بناء المجموعة',
        body:
            'تمت محاذاة نصوص 51 حلقة بودكاست ليبية زمنياً، لإنتاج 32,876 سطراً وقاموس لهجي.',
        icon: '📚',
      ),
      ProjectSpecStep(
        title: 'تنقيق الصوت',
        body:
            'تم استخراج 4,814 مقطع وتصفيةها إلى 3,226 مقطعاً أنظف، أي حوالي ثماني ساعات من البيانات الصالحة.',
        icon: '🔊',
      ),
      ProjectSpecStep(
        title: 'الضبط والتقييم',
        body:
            'تم ضبط Chatterbox مع حفظ نقاط الاستئناف، ثم تقييم صوت اصطناعي مجهول الهوية باختبارات الاستماع.',
        icon: '🧠',
      ),
    ],
    galleryLabel: 'مخرجات البحث',
  );

  static const _tamayozWebEn = ProjectDetailSpec(
    kind: ProjectSpecKind.website,
    eyebrow: 'Bilingual corporate web',
    focus:
        'A responsive Arabic-English website presenting the company, its services, brand identity, and inquiry pathways.',
    stats: [
      ProjectSpecStat(value: 'AR / EN', label: 'Bilingual content'),
      ProjectSpecStat(value: 'Web', label: 'Responsive build'),
      ProjectSpecStat(value: 'Vercel', label: 'Deployment'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Company presentation',
        body:
            'Content, services, and sectors were organised so potential partners could understand the business quickly.',
        icon: '🧑‍💻',
      ),
      ProjectSpecStep(
        title: 'Brand and UX',
        body:
            'Visual identity, logo direction, and responsive layout decisions were shaped into a consistent web presence.',
        icon: '🎨',
      ),
      ProjectSpecStep(
        title: 'Inquiry path',
        body:
            'The page structure led visitors toward clear business contact opportunities across healthcare and manufacturing.',
        icon: '🚀',
      ),
    ],
    galleryLabel: 'Website views',
  );

  static const _tamayozWebAr = ProjectDetailSpec(
    kind: ProjectSpecKind.website,
    eyebrow: 'موقع شركة ثنائي اللغة',
    focus:
        'موقع متجاوب عربي/إنجليزي يعرض الشركة وخدماتها وهويتها البصرية ومسارات التواصل التجاري.',
    stats: [
      ProjectSpecStat(value: 'عربي/إنجليزي', label: 'محتوى ثنائي'),
      ProjectSpecStat(value: 'Web', label: 'تصميم متجاوب'),
      ProjectSpecStat(value: 'Vercel', label: 'النشر'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'عرض الشركة',
        body:
            'تم تنظيم المحتوى والخدمات والقطاعات ليسهل على الشركاء المحتملين فهم عمل الشركة بسرعة.',
        icon: '🧑‍💻',
      ),
      ProjectSpecStep(
        title: 'الهوية والتجربة',
        body:
            'تم صياغة الهوية البصرية وتوجيه الشعار وقرارات التخطيط المتجاوب في حضور ويب متماسك.',
        icon: '🎨',
      ),
      ProjectSpecStep(
        title: 'مسار الاستفسار',
        body:
            'قاد هيكل الصفحات الزائر نحو فرص تواصل واضحة في قطاعي الرعاية الصحية والتصنيع.',
        icon: '🚀',
      ),
    ],
    galleryLabel: 'مشاهد الموقع',
  );

  static const _erpEn = ProjectDetailSpec(
    kind: ProjectSpecKind.operations,
    eyebrow: 'Operations mapped to ERP',
    focus:
        'An analysis and workflow-design project translating real company operations into a practical ERPNext module map.',
    stats: [
      ProjectSpecStat(value: '8', label: 'Mapped modules'),
      ProjectSpecStat(value: 'Docs', label: 'Role records'),
      ProjectSpecStat(value: 'Lean', label: 'Scope decision'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Operational audit',
        body:
            'Daily operations were analysed and documented before any system configuration decisions were made.',
        icon: '📋',
      ),
      ProjectSpecStep(
        title: 'Module mapping',
        body:
            'Accounts, stock, buying, selling, quality, maintenance, assets, and HR were connected to real responsibilities.',
        icon: '🧭',
      ),
      ProjectSpecStep(
        title: 'Simplification',
        body:
            'Unnecessary modules were identified so the system would support the business instead of adding complexity.',
        icon: '✂️',
      ),
    ],
    galleryLabel: 'Workflow artefacts',
  );

  static const _erpAr = ProjectDetailSpec(
    kind: ProjectSpecKind.operations,
    eyebrow: 'عمليات مرتبطة بـ ERP',
    focus:
        'مشروع تحليل وتصميم سير عمل يترجم العمليات الحقيقية للشركة إلى خريطة وحدات عملية في ERPNext.',
    stats: [
      ProjectSpecStat(value: '8', label: 'وحدات مرتبطة'),
      ProjectSpecStat(value: 'وثائق', label: 'سجلات الأدوار'),
      ProjectSpecStat(value: 'مبسط', label: 'قرار النطاق'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'تحليل العمليات',
        body:
            'تم تحليل العمليات اليومية وتوثيقها قبل اتخاذ أي قرار بتخصيص النظام.',
        icon: '📋',
      ),
      ProjectSpecStep(
        title: 'ربط الوحدات',
        body:
            'تم ربط الحسابات والمخزون والمشتريات والمبيعات والجودة والصيانة والأصول والموارد البشرية بالمسؤوليات الفعلية.',
        icon: '🧭',
      ),
      ProjectSpecStep(
        title: 'التبسيط',
        body:
            'تم تحديد الوحدات غير الضرورية لتقليل التعقيد وجعل النظام يخدم العمل بدلاً من إثقاله.',
        icon: '✂️',
      ),
    ],
    galleryLabel: 'مخرجات سير العمل',
  );

  static const _torranceEn = ProjectDetailSpec(
    kind: ProjectSpecKind.website,
    eyebrow: 'Website redesign concept',
    focus:
        'A live, independent redesign concept built around faster service discovery and a shorter path to a quote request.',
    stats: [
      ProjectSpecStat(value: 'Live', label: 'Working prototype'),
      ProjectSpecStat(value: 'Before / after', label: 'Design study'),
      ProjectSpecStat(value: 'Phone + desktop', label: 'Responsive scope'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Journey audit',
        body:
            'The current site was reviewed from landing page to quote request to find where visitors could hesitate or lose direction.',
        icon: '🔎',
      ),
      ProjectSpecStep(
        title: 'New information architecture',
        body:
            'Services, proof, selected work, and contact were reorganised into a clearer sequence with repeatable calls to action.',
        icon: '🧩',
      ),
      ProjectSpecStep(
        title: 'Responsive prototype',
        body:
            'A responsive colour, typography, and layout system was translated into a browsable prototype for phone and desktop.',
        icon: '🛠️',
      ),
      ProjectSpecStep(
        title: 'Quote-first outcome',
        body:
            'The final flow reduces visual noise and keeps trust signals and contact routes close to the main service message.',
        icon: '📈',
      ),
    ],
    galleryLabel: 'Concept screens',
  );

  static const _torranceAr = ProjectDetailSpec(
    kind: ProjectSpecKind.website,
    eyebrow: 'مفهوم إعادة تصميم موقع',
    focus:
        'مفهوم مستقل قابل للتصفح يركز على وصول أسرع للخدمات ومسار أقصر لطلب السعر.',
    stats: [
      ProjectSpecStat(value: 'مباشر', label: 'نموذج قابل للتصفح'),
      ProjectSpecStat(value: 'قبل / بعد', label: 'دراسة تصميم'),
      ProjectSpecStat(value: 'جوال + سطح', label: 'نطاق متجاوب'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'مراجعة الرحلة',
        body:
            'تمت مراجعة الموقع الحالي من الصفحة الرئيسية حتى طلب السعر لتحديد نقاط التردد وضعف الاتجاه.',
        icon: '🔎',
      ),
      ProjectSpecStep(
        title: 'هيكل معلومات جديد',
        body:
            'أُعيد تنظيم الخدمات والإثبات والأعمال ومعلومات التواصل في تسلسل أوضح مع دعوات إجراء متكررة.',
        icon: '🧩',
      ),
      ProjectSpecStep(
        title: 'نموذج متجاوب',
        body:
            'تم تحويل نظام ألوان وطباعة وتخطيط متجاوب إلى نموذج ويب قابل للتصفح على الهاتف وسطح المكتب.',
        icon: '🛠️',
      ),
      ProjectSpecStep(
        title: 'نتيجة تركز على السعر',
        body:
            'قلل التصميم الفوضى البصرية وأبقى علامات الثقة ومسارات التواصل قريبة من رسالة الخدمة الرئيسية.',
        icon: '📈',
      ),
    ],
    galleryLabel: 'شاشات المفهوم',
  );

  static const _feedmeEn = ProjectDetailSpec(
    kind: ProjectSpecKind.mobile,
    eyebrow: 'Mobile product concept',
    focus:
        'A Figma concept covering food discovery, customisation, cart logic, onboarding, and multi-role delivery flows.',
    stats: [
      ProjectSpecStat(value: '3', label: 'User roles'),
      ProjectSpecStat(value: '6', label: 'Gallery screens'),
      ProjectSpecStat(value: 'Figma', label: 'Design tool'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Discovery',
        body:
            'The concept starts with restaurant discovery and product exploration before moving into order decisions.',
        icon: '🍔',
      ),
      ProjectSpecStep(
        title: 'Order flow',
        body:
            'Customisation, cart review, and order tracking were designed as one continuous customer journey.',
        icon: '🛒',
      ),
      ProjectSpecStep(
        title: 'Shared ecosystem',
        body:
            'Customer, restaurant, and driver roles were considered together so each screen fits a shared delivery system.',
        icon: '👥',
      ),
    ],
    galleryLabel: 'App screens',
  );

  static const _feedmeAr = ProjectDetailSpec(
    kind: ProjectSpecKind.mobile,
    eyebrow: 'مفهوم منتج للهاتف',
    focus:
        'مفهوم في Figma يغطي اكتشاف الطعام والتخصيص وسلة الطلب والتسجيل الأولي وسير العمل متعدد الأدوار.',
    stats: [
      ProjectSpecStat(value: '3', label: 'أدوار مستخدم'),
      ProjectSpecStat(value: '6', label: 'شاشات معرض'),
      ProjectSpecStat(value: 'Figma', label: 'أداة التصميم'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'الاكتشاف',
        body:
            'يبدأ المفهوم باكتشاف المطاعم واستكشاف الأصناف قبل الانتقال إلى قرارات الطلب.',
        icon: '🍔',
      ),
      ProjectSpecStep(
        title: 'تدفق الطلب',
        body:
            'صُممت خيارات التخصيص ومراجعة السلة وتتبع الطلب كرحلة عميل واحدة متصلة.',
        icon: '🛒',
      ),
      ProjectSpecStep(
        title: 'منظومة مشتركة',
        body:
            'تمت مراعاة أدوار العميل والمطعم والسائق معاً لتناسب كل شاشة نظام توصيل واحداً.',
        icon: '👥',
      ),
    ],
    galleryLabel: 'شاشات التطبيق',
  );

  static const _genericEn = ProjectDetailSpec(
    kind: ProjectSpecKind.product,
    eyebrow: 'Project case study',
    focus:
        'A focused project presented through its problem, process, and outcome.',
    stats: [
      ProjectSpecStat(value: 'Case', label: 'Study format'),
      ProjectSpecStat(value: 'Build', label: 'Practical focus'),
      ProjectSpecStat(value: 'Detail', label: 'Structured view'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'Context',
        body:
            'The project context and purpose are presented before the implementation details.',
        icon: '🧭',
      ),
      ProjectSpecStep(
        title: 'Process',
        body:
            'The work is broken into clear decisions so the reasoning behind the result is visible.',
        icon: '🛠️',
      ),
      ProjectSpecStep(
        title: 'Outcome',
        body:
            'The final section connects the delivered work back to its intended value.',
        icon: '📈',
      ),
    ],
    galleryLabel: 'Project gallery',
  );

  static const _genericAr = ProjectDetailSpec(
    kind: ProjectSpecKind.product,
    eyebrow: 'دراسة مشروع',
    focus: 'مشروع يُعرض من خلال مشكلته وعملية تنفيذه والنتيجة النهائية.',
    stats: [
      ProjectSpecStat(value: 'دراسة', label: 'شكل العرض'),
      ProjectSpecStat(value: 'تنفيذ', label: 'التركيز العملي'),
      ProjectSpecStat(value: 'تفصيل', label: 'عرض منظم'),
    ],
    steps: [
      ProjectSpecStep(
        title: 'السياق',
        body: 'يُعرض سياق المشروع وهدفه قبل تفاصيل التنفيذ.',
        icon: '🧭',
      ),
      ProjectSpecStep(
        title: 'العملية',
        body: 'تُقسم القرارات إلى مراحل واضحة لتظهر طريقة الوصول إلى النتيجة.',
        icon: '🛠️',
      ),
      ProjectSpecStep(
        title: 'النتيجة',
        body: 'يربط القسم الأخير بين العمل المنفذ والقيمة المرجوة منه.',
        icon: '📈',
      ),
    ],
    galleryLabel: 'معرض المشروع',
  );
}
