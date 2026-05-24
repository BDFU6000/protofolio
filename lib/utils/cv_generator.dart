import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/portfolio_data.dart';

// ---------------------------------------------------------------------------
// 📄 CV GENERATOR — Premium bilingual PDF resume
// ---------------------------------------------------------------------------

class CVGenerator {
  // ── Brand colours ──────────────────────────────────────────────────────────
  static const _cyan = PdfColor.fromInt(0xFF00D4FF);
  static const _purple = PdfColor.fromInt(0xFF7B2FFF);
  static const _dark = PdfColor.fromInt(0xFF0A0F1E);
  static const _slate = PdfColor.fromInt(0xFF1A2235);
  static const _bodyText = PdfColor.fromInt(0xFF334155);
  static const _mutedText = PdfColor.fromInt(0xFF64748B);
  static const _white = PdfColors.white;
  static const _lightBg = PdfColor.fromInt(0xFFF1F5F9);
  static const _border = PdfColor.fromInt(0xFFE2E8F0);

  // ── Public entry point ─────────────────────────────────────────────────────
  static Future<void> generateAndDownload({required bool isArabic}) async {
    final pdf = pw.Document();

    // Load Cairo font (supports Arabic + Latin)
    pw.Font regularFont;
    pw.Font boldFont;
    try {
      regularFont =
          pw.Font.ttf(await rootBundle.load('assets/fonts/Cairo-Regular.ttf'));
      boldFont =
          pw.Font.ttf(await rootBundle.load('assets/fonts/Cairo-Bold.ttf'));
    } catch (_) {
      regularFont = pw.Font.helvetica();
      boldFont = pw.Font.helveticaBold();
    }

    final theme = pw.ThemeData.withFont(base: regularFont, bold: boldFont);

    // Load images
    pw.MemoryImage? profileImage;
    try {
      profileImage = pw.MemoryImage(
          (await rootBundle.load('assets/images/Moneeb.jpg'))
              .buffer
              .asUint8List());
    } catch (_) {}

    pw.MemoryImage? qrCode;
    try {
      qrCode = pw.MemoryImage(
          (await rootBundle.load('assets/images/moneeb_salah6_qr.png'))
              .buffer
              .asUint8List());
    } catch (_) {}

    final textDir = isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr;
    final crossAxis =
        isArabic ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        theme: theme,
        textDirection: textDir,
        build: (pw.Context context) => [
          // ── Gradient header banner ─────────────────────────────────────────
          _buildHeader(profileImage, qrCode, isArabic, crossAxis),
          // ── Two-column body ────────────────────────────────────────────────
          pw.Padding(
            padding:
                const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: isArabic
                  ? [
                      // RTL: main first, sidebar second
                      pw.Expanded(
                          flex: 3,
                          child: _buildMainColumn(isArabic, crossAxis)),
                      pw.SizedBox(width: 24),
                      pw.SizedBox(
                          width: 160,
                          child: _buildSidebar(isArabic, crossAxis)),
                    ]
                  : [
                      // LTR: sidebar first, main second
                      pw.SizedBox(
                          width: 160,
                          child: _buildSidebar(isArabic, crossAxis)),
                      pw.SizedBox(width: 24),
                      pw.Expanded(
                          flex: 3,
                          child: _buildMainColumn(isArabic, crossAxis)),
                    ],
            ),
          ),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: isArabic
          ? 'Abd_Al_Moneeb_CV_Arabic.pdf'
          : 'Abd_Al_Moneeb_CV_English.pdf',
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  static pw.Widget _buildHeader(
    pw.MemoryImage? profileImage,
    pw.MemoryImage? qrCode,
    bool isArabic,
    pw.CrossAxisAlignment crossAxis,
  ) {
    return pw.Container(
      width: double.infinity,
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_dark, _slate],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          // Avatar
          if (profileImage != null)
            pw.Container(
              width: 88,
              height: 88,
              decoration: pw.BoxDecoration(
                shape: pw.BoxShape.circle,
                border: pw.Border.all(color: _cyan, width: 2.5),
                image: pw.DecorationImage(
                    image: profileImage, fit: pw.BoxFit.cover),
              ),
            ),
          pw.SizedBox(width: 20),
          // Name + title + contacts
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: crossAxis,
              children: [
                pw.Text(
                  isArabic
                      ? 'عبد المنيب صالح أبوسنة'
                      : 'ABD ALMONEEB SALAH ABUSETTA',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: _white,
                    letterSpacing: 1.2,
                  ),
                  textDirection:
                      isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  isArabic
                      ? 'خريج علوم حاسوب • مطور فلاتر شامل'
                      : 'CS Graduate  •  Full-Stack Flutter Developer',
                  style: const pw.TextStyle(fontSize: 11, color: _cyan),
                  textDirection:
                      isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
                ),
                pw.SizedBox(height: 14),
                // Contact pills row
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  children: [
                    _contactPill('✉', 'moneebabusetta53@gmail.com'),
                    _contactPill('📱', '+218 918 474 887'),
                    _contactPill('📸', '@moneeb_salah6'),
                    _contactPill('🐙', 'github.com/BDFU6000'),
                  ],
                ),
              ],
            ),
          ),
          // QR Code
          if (qrCode != null) ...[
            pw.SizedBox(width: 16),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  width: 72,
                  height: 72,
                  decoration: pw.BoxDecoration(
                    color: _white,
                    borderRadius:
                        const pw.BorderRadius.all(pw.Radius.circular(8)),
                    image:
                        pw.DecorationImage(image: qrCode, fit: pw.BoxFit.cover),
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  isArabic ? 'تواصل معي' : 'Scan to connect',
                  style: const pw.TextStyle(fontSize: 8, color: _mutedText),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  static pw.Widget _contactPill(String emoji, String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0x1A00D4FF),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(20)),
        border: pw.Border.all(color: _cyan, width: 0.5),
      ),
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(emoji, style: const pw.TextStyle(fontSize: 8)),
          pw.SizedBox(width: 4),
          pw.Text(text,
              style: const pw.TextStyle(fontSize: 8.5, color: _white)),
        ],
      ),
    );
  }

  // ── Sidebar (skills + about) ────────────────────────────────────────────────
  static pw.Widget _buildSidebar(
      bool isArabic, pw.CrossAxisAlignment crossAxis) {
    return pw.Column(
      crossAxisAlignment: crossAxis,
      children: [
        // About blurb
        _sideSection(
          isArabic ? 'نبذة مختصرة' : 'ABOUT',
          isArabic,
        ),
        pw.Text(
          isArabic
              ? 'خريج علوم حاسوب (2026) متخصص في بناء تطبيقات إنتاجية متكاملة من الصفر.'
              : 'CS Graduate (2026) specialising in building full-scale production apps from scratch — solo.',
          style: const pw.TextStyle(
              fontSize: 9, color: _bodyText, lineSpacing: 1.5),
          textDirection: isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
        ),
        pw.SizedBox(height: 18),

        // Tech Skills
        _sideSection(isArabic ? 'المهارات التقنية' : 'TECH SKILLS', isArabic),
        pw.Column(
          crossAxisAlignment: crossAxis,
          children: PortfolioData.skills.map((skill) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 7),
              child: pw.Column(
                crossAxisAlignment: crossAxis,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        '${skill.emoji} ${skill.name}',
                        style:
                            const pw.TextStyle(fontSize: 8.5, color: _bodyText),
                      ),
                      pw.Text(
                        '${(skill.level * 100).toInt()}%',
                        style:
                            const pw.TextStyle(fontSize: 8, color: _mutedText),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 3),
                  pw.LayoutBuilder(
                    builder: (ctx, c) {
                      final barWidth = (c?.maxWidth ?? 140) * skill.level;
                      return pw.Stack(
                        children: [
                          pw.Container(
                            height: 4,
                            decoration: pw.BoxDecoration(
                              color: _border,
                              borderRadius: const pw.BorderRadius.all(
                                  pw.Radius.circular(2)),
                            ),
                          ),
                          pw.Container(
                            height: 4,
                            width: barWidth,
                            decoration: pw.BoxDecoration(
                              gradient: const pw.LinearGradient(
                                  colors: [_cyan, _purple]),
                              borderRadius: const pw.BorderRadius.all(
                                  pw.Radius.circular(2)),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        pw.SizedBox(height: 18),

        // Stats
        _sideSection(isArabic ? 'الإنجازات' : 'HIGHLIGHTS', isArabic),
        _statRow(
            isArabic ? '📅 سنوات الخبرة' : '📅 Years of Exp.', '2+', isArabic),
        _statRow(
            isArabic ? '🗂️ مشاريع مكتملة' : '🗂️ Projects', '4+', isArabic),
        _statRow(isArabic ? '🤝 عملاء سعداء' : '🤝 Clients', '3+', isArabic),
      ],
    );
  }

  static pw.Widget _statRow(String label, String value, bool isArabic) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label,
              style: const pw.TextStyle(fontSize: 8.5, color: _bodyText)),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: pw.BoxDecoration(
              color: const PdfColor.fromInt(0x1A00D4FF),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
            ),
            child: pw.Text(value,
                style: pw.TextStyle(
                    fontSize: 8.5,
                    color: _cyan,
                    fontWeight: pw.FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  static pw.Widget _sideSection(String title, bool isArabic) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Column(
        crossAxisAlignment:
            isArabic ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
                color: _cyan,
                letterSpacing: 1.5),
          ),
          pw.SizedBox(height: 3),
          pw.Container(height: 1.5, color: _cyan),
          pw.SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Main Column (bio + experience + projects) ──────────────────────────────
  static pw.Widget _buildMainColumn(
      bool isArabic, pw.CrossAxisAlignment crossAxis) {
    final experiences = isArabic
        ? PortfolioData.arabicExperiences
        : PortfolioData.englishExperiences;
    final projects =
        isArabic ? PortfolioData.arabicProjects : PortfolioData.englishProjects;

    return pw.Column(
      crossAxisAlignment: crossAxis,
      children: [
        // Professional Summary
        _mainSection(
            isArabic ? 'الملخص المهني' : 'PROFESSIONAL SUMMARY', isArabic),
        pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: _lightBg,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
            border: pw.Border.all(color: _border),
          ),
          child: pw.Text(
            isArabic ? PortfolioData.arabicBio : PortfolioData.englishBio,
            style: const pw.TextStyle(
                fontSize: 9.5, color: _bodyText, lineSpacing: 1.6),
            textDirection:
                isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
          ),
        ),
        pw.SizedBox(height: 20),

        // Experience
        _mainSection(
            isArabic ? 'الخبرة المهنية' : 'PROFESSIONAL EXPERIENCE', isArabic),
        ...experiences.map((exp) => _experienceCard(exp, isArabic, crossAxis)),

        pw.SizedBox(height: 8),

        // Projects
        _mainSection(isArabic ? 'أبرز المشاريع' : 'NOTABLE PROJECTS', isArabic),
        ...projects.map((proj) => _projectCard(proj, isArabic, crossAxis)),
      ],
    );
  }

  static pw.Widget _mainSection(String title, bool isArabic) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(
        crossAxisAlignment:
            isArabic ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: isArabic
                ? [
                    pw.Expanded(child: pw.Container(height: 1.5, color: _cyan)),
                    pw.SizedBox(width: 8),
                    pw.Text(
                      title,
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: _dark,
                          letterSpacing: 1.2),
                    ),
                  ]
                : [
                    pw.Text(
                      title,
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: _dark,
                          letterSpacing: 1.2),
                    ),
                    pw.SizedBox(width: 8),
                    pw.Expanded(child: pw.Container(height: 1.5, color: _cyan)),
                  ],
          ),
          pw.SizedBox(height: 8),
        ],
      ),
    );
  }

  static pw.Widget _experienceCard(
      dynamic exp, bool isArabic, pw.CrossAxisAlignment crossAxis) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 14),
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: _white,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
        border: pw.Border.all(color: _border),
        boxShadow: [
          const pw.BoxShadow(
              color: PdfColor.fromInt(0x08000000),
              blurRadius: 6,
              offset: PdfPoint(0, 2))
        ],
      ),
      child: pw.Column(
        crossAxisAlignment: crossAxis,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Row(
                children: [
                  pw.Text(exp.emoji, style: const pw.TextStyle(fontSize: 14)),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    exp.role,
                    style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        color: _dark),
                    textDirection:
                        isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
                  ),
                ],
              ),
              pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: pw.BoxDecoration(
                  color: const PdfColor.fromInt(0x1A00D4FF),
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.circular(12)),
                ),
                child: pw.Text(
                  exp.period,
                  style: const pw.TextStyle(fontSize: 8.5, color: _cyan),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 3),
          pw.Text(
            exp.company,
            style: pw.TextStyle(
                fontSize: 9.5, color: _purple, fontStyle: pw.FontStyle.italic),
            textDirection:
                isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            exp.description,
            style: const pw.TextStyle(
                fontSize: 9, color: _bodyText, lineSpacing: 1.5),
            textDirection:
                isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
          ),
          pw.SizedBox(height: 8),
          pw.Wrap(
            spacing: 5,
            runSpacing: 5,
            children: exp.technologies.map<pw.Widget>((tech) {
              return pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: pw.BoxDecoration(
                  color: _lightBg,
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.circular(4)),
                  border: pw.Border.all(color: _border),
                ),
                child: pw.Text(
                  tech,
                  style: const pw.TextStyle(fontSize: 8, color: _bodyText),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  static pw.Widget _projectCard(
      dynamic proj, bool isArabic, pw.CrossAxisAlignment crossAxis) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 14),
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        gradient: const pw.LinearGradient(
          colors: [_white, PdfColor.fromInt(0xFFF8FAFF)],
        ),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
        border: pw.Border.all(color: _border),
        boxShadow: [
          const pw.BoxShadow(
              color: PdfColor.fromInt(0x06000000),
              blurRadius: 6,
              offset: PdfPoint(0, 2))
        ],
      ),
      child: pw.Column(
        crossAxisAlignment: crossAxis,
        children: [
          pw.Row(
            children: [
              pw.Text(proj.emoji, style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(width: 8),
              pw.Expanded(
                child: pw.Text(
                  proj.title,
                  style: pw.TextStyle(
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                      color: _dark),
                  textDirection:
                      isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            proj.description,
            style: const pw.TextStyle(
                fontSize: 9, color: _bodyText, lineSpacing: 1.5),
            textDirection:
                isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
          ),
          pw.SizedBox(height: 8),
          pw.Wrap(
            spacing: 5,
            runSpacing: 5,
            children: proj.technologies.map<pw.Widget>((tech) {
              return pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: pw.BoxDecoration(
                  color: const PdfColor.fromInt(0x1A7B2FFF),
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.circular(4)),
                ),
                child: pw.Text(
                  tech,
                  style: const pw.TextStyle(fontSize: 8, color: _purple),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
