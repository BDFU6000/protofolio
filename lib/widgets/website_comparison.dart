import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/project_model.dart';
import 'website_iframe_stub.dart'
    if (dart.library.html) 'website_iframe_web.dart';

class WebsiteComparisonCard extends StatelessWidget {
  const WebsiteComparisonCard({
    super.key,
    required this.comparison,
    required this.isArabic,
  });

  final ProjectWebsiteComparison comparison;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 720;
        final viewportHeight = stacked ? 240.0 : 320.0;

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF101827),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0x33FFFFFF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.compare_arrows_rounded,
                      color: const Color(0xFF00D4FF), size: stacked ? 20 : 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      isArabic ? 'قبل وبعد مباشر' : 'Live before & after',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: stacked ? 17 : 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                isArabic
                    ? 'معاينة تلقائية للموقعين. استخدم زر الفتح لرؤية أي نسخة كاملة الحجم.'
                    : 'Auto-scrolling previews of both sites. Use the open buttons to view either version full size.',
                style: GoogleFonts.inter(
                  color: const Color(0xFFB8C4D9),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              stacked
                  ? Column(
                      children: [
                        _buildPreview(
                          label: comparison.oldLabel,
                          url: comparison.oldUrl,
                          viewportHeight: viewportHeight,
                          highlight: false,
                        ),
                        const SizedBox(height: 20),
                        _buildPreview(
                          label: comparison.newLabel,
                          url: comparison.newUrl,
                          viewportHeight: viewportHeight,
                          highlight: true,
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildPreview(
                            label: comparison.oldLabel,
                            url: comparison.oldUrl,
                            viewportHeight: viewportHeight,
                            highlight: false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildPreview(
                            label: comparison.newLabel,
                            url: comparison.newUrl,
                            viewportHeight: viewportHeight,
                            highlight: true,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1424),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0x33FFFFFF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic ? 'ما الذي تحسّن' : 'What improved',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFC800),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      comparison.summary,
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...comparison.improvements.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 7, right: 10),
                              child: Icon(Icons.check_circle_rounded,
                                  size: 15, color: Color(0xFF00D4FF)),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: GoogleFonts.inter(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPreview({
    required String label,
    required String url,
    required double viewportHeight,
    required bool highlight,
  }) {
    final color = highlight ? const Color(0xFFFFC800) : const Color(0xFF00D4FF);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              highlight ? Icons.auto_awesome_rounded : Icons.history_rounded,
              color: color,
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: buildWebsiteIframe(
            url: url,
            viewportHeight: viewportHeight,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            ),
            icon: Icon(Icons.open_in_new, color: color, size: 14),
            label: Text(
              isArabic ? 'فتح في تبويب جديد' : 'Open in new tab',
              style: GoogleFonts.inter(color: color, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
