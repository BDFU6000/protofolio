import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/portfolio_data.dart';

class CVGenerator {
  // ── Palette ────────────────────────────────────────────────────────────────
  static const _navy = PdfColor.fromInt(0xFF1B3564);
  static const _navyDim = PdfColor.fromInt(0xFF24427A);
  static const _blue = PdfColor.fromInt(0xFF2E5FAA);
  static const _orange = PdfColor.fromInt(0xFFE8834A);
  static const _dark = PdfColor.fromInt(0xFF1A202C);
  static const _gray = PdfColor.fromInt(0xFF5A6478);
  static const _white = PdfColors.white;
  static const _sidebarDim = PdfColor.fromInt(0xFFADBDD8);

  // ── Entry point ────────────────────────────────────────────────────────────
  static Future<void> generateAndDownload({required bool isArabic}) async {
    final pdf = pw.Document();

    pw.Font regular, bold;
    try {
      regular =
          pw.Font.ttf(await rootBundle.load('assets/fonts/Cairo-Regular.ttf'));
      bold = pw.Font.ttf(await rootBundle.load('assets/fonts/Cairo-Bold.ttf'));
    } catch (_) {
      regular = pw.Font.helvetica();
      bold = pw.Font.helveticaBold();
    }

    pw.MemoryImage? photo;
    try {
      photo = pw.MemoryImage((await rootBundle.load('assets/images/Moneeb.jpg'))
          .buffer
          .asUint8List());
    } catch (_) {}

    pw.MemoryImage? qr;
    try {
      qr = pw.MemoryImage(
          (await rootBundle.load('assets/images/moneeb_salah6_qr.png'))
              .buffer
              .asUint8List());
    } catch (_) {}

    final dir = isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr;

    pdf.addPage(pw.MultiPage(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        theme: pw.ThemeData.withFont(base: regular, bold: bold),
        textDirection: dir,
        buildBackground: (ctx) => pw.Row(
          children: isArabic
              ? [
                  pw.Expanded(child: pw.Container(color: _white)),
                  pw.Container(width: 188, color: _navy)
                ]
              : [
                  pw.Container(width: 188, color: _navy),
                  pw.Expanded(child: pw.Container(color: _white))
                ],
        ),
      ),
      build: (ctx) => [
        pw.Partitions(
          children: isArabic
              ? [
                  pw.Partition(child: _mainCol(isArabic, photo, dir)),
                  pw.Partition(width: 188, child: _sidebar(isArabic, qr)),
                ]
              : [
                  pw.Partition(width: 188, child: _sidebar(isArabic, qr)),
                  pw.Partition(child: _mainCol(isArabic, photo, dir)),
                ],
        ),
      ],
    ));

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: isArabic ? 'CV_Arabic.pdf' : 'CV_English.pdf',
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // MAIN COLUMN (white)
  // ══════════════════════════════════════════════════════════════════════════
  static pw.Column _mainCol(
      bool ar, pw.MemoryImage? photo, pw.TextDirection dir) {
    final ca = ar ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start;
    final exps =
        ar ? PortfolioData.arabicExperiences : PortfolioData.englishExperiences;
    final projs =
        ar ? PortfolioData.arabicProjects : PortfolioData.englishProjects;

    pw.Widget pad(pw.Widget child) => pw.Padding(
        padding: const pw.EdgeInsets.only(left: 34, right: 26), child: child);

    return pw.Column(crossAxisAlignment: ca, children: [
      pw.SizedBox(height: 34),
      // ── Header ──────────────────────────────────────────────────────
      pad(pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: ar
              ? [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'عبد المنيب صالح أبوسنة',
                          textDirection: dir,
                          style: pw.TextStyle(
                              fontSize: 22,
                              fontWeight: pw.FontWeight.bold,
                              color: _dark),
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text('خريج علوم حاسوب • مطور فلاتر شامل',
                            textDirection: dir,
                            style: const pw.TextStyle(
                                fontSize: 10.5, color: _gray)),
                      ]),
                  pw.SizedBox(width: 14),
                  if (photo != null) _avatar(photo),
                ]
              : [
                  if (photo != null) _avatar(photo),
                  pw.SizedBox(width: 14),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Abd Almoneeb Salah Abusetta',
                            style: pw.TextStyle(
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold,
                                color: _dark)),
                        pw.SizedBox(height: 3),
                        pw.Text('CS Graduate  •  Full-Stack Flutter Developer',
                            style: const pw.TextStyle(
                                fontSize: 10.5, color: _gray)),
                      ]),
                ])),
      pw.SizedBox(height: 18),

      // ── Professional Summary ─────────────────────────────────────────
      pad(_secHeader(ar ? 'الملخص المهني' : 'Professional Summary', ar)),
      pad(pw.Text(ar ? PortfolioData.arabicBio : PortfolioData.englishBio,
          textDirection: dir,
          style:
              const pw.TextStyle(fontSize: 9, color: _gray, lineSpacing: 1.5))),
      pw.SizedBox(height: 14),

      // ── Work Experience ──────────────────────────────────────────────
      pad(_secHeader(ar ? 'الخبرة المهنية' : 'Work Experience', ar)),
      ...exps.map((e) => pad(_expItem(e, ar, dir))),

      // ── Notable Projects ─────────────────────────────────────────────
      pad(_secHeader(ar ? 'أبرز المشاريع' : 'Notable Projects', ar)),
      ...projs.map((p) => pad(_projItem(p, ar, dir))),

      pw.SizedBox(height: 26),
    ]);
  }

  static pw.Widget _avatar(pw.MemoryImage img) => pw.Container(
        width: 76,
        height: 76,
        decoration: pw.BoxDecoration(
          shape: pw.BoxShape.circle,
          border: pw.Border.all(color: _blue, width: 2),
          image: pw.DecorationImage(image: img, fit: pw.BoxFit.cover),
        ),
      );

  static pw.Widget _secHeader(String title, bool ar) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 7),
      child: pw.Column(
        crossAxisAlignment:
            ar ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title,
              textDirection: ar ? pw.TextDirection.rtl : pw.TextDirection.ltr,
              style: pw.TextStyle(
                  fontSize: 13, fontWeight: pw.FontWeight.bold, color: _blue)),
          pw.SizedBox(height: 3),
          // dashed separator
          pw.Row(
              children: List.generate(
                  55,
                  (i) => pw.Expanded(
                        child: pw.Container(
                          height: 1,
                          color: i.isEven ? _blue : PdfColors.white,
                        ),
                      ))),
          pw.SizedBox(height: 6),
        ],
      ),
    );
  }

  static pw.Widget _expItem(dynamic exp, bool ar, pw.TextDirection dir) {
    final ca = ar ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start;
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 11),
      child: pw.Column(crossAxisAlignment: ca, children: [
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Text(exp.role,
              textDirection: dir,
              style: pw.TextStyle(
                  fontSize: 10.5,
                  fontWeight: pw.FontWeight.bold,
                  color: _dark)),
          pw.Text(exp.period,
              style: const pw.TextStyle(fontSize: 8.5, color: _gray)),
        ]),
        pw.SizedBox(height: 1),
        pw.Text(exp.company,
            textDirection: dir,
            style: const pw.TextStyle(fontSize: 9, color: _gray)),
        pw.SizedBox(height: 4),
        pw.Text(exp.description,
            textDirection: dir,
            style: const pw.TextStyle(
                fontSize: 8.5, color: _gray, lineSpacing: 1.4)),
        pw.SizedBox(height: 5),
        pw.Wrap(
            spacing: 4,
            runSpacing: 4,
            children:
                exp.technologies.map<pw.Widget>((t) => _techChip(t)).toList()),
      ]),
    );
  }

  static pw.Widget _projItem(dynamic proj, bool ar, pw.TextDirection dir) {
    final ca = ar ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start;
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(crossAxisAlignment: ca, children: [
        pw.Text(proj.title,
            textDirection: dir,
            style: pw.TextStyle(
                fontSize: 10.5, fontWeight: pw.FontWeight.bold, color: _dark)),
        pw.SizedBox(height: 3),
        pw.Text(proj.description,
            textDirection: dir,
            style: const pw.TextStyle(
                fontSize: 8.5, color: _gray, lineSpacing: 1.4)),
        pw.SizedBox(height: 5),
        pw.Wrap(
            spacing: 4,
            runSpacing: 4,
            children: proj.technologies
                .take(5)
                .map<pw.Widget>((t) => _techChip(t))
                .toList()),
      ]),
    );
  }

  static pw.Widget _techChip(String label) => pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: _blue),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
        ),
        child: pw.Text(label,
            style: const pw.TextStyle(fontSize: 7, color: _blue)),
      );

  // ══════════════════════════════════════════════════════════════════════════
  // SIDEBAR (dark navy)
  // ══════════════════════════════════════════════════════════════════════════
  static pw.Column _sidebar(bool ar, pw.MemoryImage? qr) {
    final ca = ar ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start;
    pw.Widget pad(pw.Widget child) => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 18), child: child);

    return pw.Column(crossAxisAlignment: ca, children: [
      pw.SizedBox(height: 32),
      // Contact
      pad(_sideHeader(ar ? 'بيانات التواصل' : 'Contact Details')),
      pad(_contactItem('Email:', 'moneebabusetta53@gmail.com')),
      pad(_contactItem('Tel:', '+218 918 474 887')),
      pad(_contactItem('Insta:', '@moneeb_salah6')),
      pad(_contactItem('GitHub:', 'github.com/BDFU6000')),
      pw.SizedBox(height: 18),

      // Skills
      pad(_sideHeader(ar ? 'المهارات' : 'Skills')),
      pw.SizedBox(height: 4),
      ...PortfolioData.skills
          .take(8)
          .map((s) => pad(_skillRow(s.name, s.level))),
      pw.SizedBox(height: 18),

      // Languages
      pad(_sideHeader(ar ? 'اللغات' : 'Languages')),
      pw.SizedBox(height: 8),
      pad(pw.Wrap(spacing: 6, runSpacing: 6, children: [
        _langPill(ar ? 'العربية' : 'Arabic'),
        _langPill(ar ? 'الإنجليزية' : 'English'),
      ])),
      pw.SizedBox(height: 20),

      // QR
      if (qr != null) ...[
        pad(_sideHeader(ar ? 'تواصل معي' : 'Scan to Connect')),
        pw.SizedBox(height: 8),
        pad(pw.Container(
          width: 68,
          height: 68,
          decoration: pw.BoxDecoration(
            color: _white,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            image: pw.DecorationImage(image: qr, fit: pw.BoxFit.cover),
          ),
        )),
        pw.SizedBox(height: 4),
        pad(pw.Text(ar ? 'انستقرام' : 'Instagram QR',
            style: const pw.TextStyle(fontSize: 7, color: _sidebarDim))),
      ],

      pw.SizedBox(height: 24),
    ]);
  }

  static pw.Widget _sideHeader(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(title,
            style: pw.TextStyle(
                fontSize: 11, fontWeight: pw.FontWeight.bold, color: _white)),
        pw.SizedBox(height: 3),
        // dotted separator
        pw.Row(
            children: List.generate(
                30,
                (i) => pw.Expanded(
                      child: pw.Container(
                          height: 1, color: i.isEven ? _navyDim : _navy),
                    ))),
        pw.SizedBox(height: 2),
      ]),
    );
  }

  static pw.Widget _contactItem(String label, String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 7),
      child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(label,
            style: const pw.TextStyle(fontSize: 9, color: _sidebarDim)),
        pw.SizedBox(width: 6),
        pw.Flexible(
            child: pw.Text(text,
                style: const pw.TextStyle(fontSize: 8, color: _sidebarDim))),
      ]),
    );
  }

  static pw.Widget _skillRow(String name, double level) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 7),
      child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(name, style: const pw.TextStyle(fontSize: 8.5, color: _white)),
        pw.SizedBox(height: 3),
        pw.LayoutBuilder(builder: (ctx, c) {
          final total = c?.maxWidth ?? 148.0;
          return pw.Stack(children: [
            pw.Container(
              height: 5,
              width: total,
              decoration: pw.BoxDecoration(
                color: _navyDim,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
              ),
            ),
            pw.Container(
              height: 5,
              width: total * level,
              decoration: pw.BoxDecoration(
                color: _orange,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
              ),
            ),
          ]);
        }),
      ]),
    );
  }

  static pw.Widget _langPill(String label) => pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: _sidebarDim),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
        ),
        child: pw.Text(label,
            style: const pw.TextStyle(fontSize: 8.5, color: _white)),
      );
}
