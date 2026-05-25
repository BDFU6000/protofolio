import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../utils/locale_provider.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, _) {
        final width = MediaQuery.of(context).size.width;
        final horizontalPadding = width > 600 ? 40.0 : 16.0;
        final topPadding = width > 600 ? 100.0 : 64.0;
        final bottomPadding = width > 600 ? 40.0 : 32.0;
        final titleFontSize = width > 600 ? 48.0 : 32.0;
        final bodyFontSize = width > 600 ? 16.0 : 14.0;

        return Container(
          padding: EdgeInsets.fromLTRB(
              horizontalPadding, topPadding, horizontalPadding, bottomPadding),
          child: Column(
            children: [
              FadeInUp(
                child: Text(
                  isArabic ? 'ما هي الخطوة القادمة؟' : "What's Next?",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF00D4FF),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Color(0xFFB0B8D0)],
                  ).createShader(bounds),
                  child: Text(
                    isArabic ? 'تواصل معي' : 'Get In Touch',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    isArabic
                        ? 'رغم أنني لا أبحث عن فرص جديدة حالياً، إلا أن بريدي الوارد مفتوح دائماً. سواء كان لديك سؤال أو ترغب فقط في إلقاء التحية، سأبذل قصارى جهدي للرد عليك!'
                        : "Although I'm not currently looking for any new opportunities, "
                            "my inbox is always open. Whether you have a question or just "
                            "want to say hi, I'll try my best to get back to you!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white54,
                      fontSize: bodyFontSize,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              // Contact Cards Grid
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: _ContactCardsGrid(isArabic: isArabic),
              ),
              const SizedBox(height: 48),
              FadeInUp(
                delay: const Duration(milliseconds: 450),
                child: _SayHelloButton(isArabic: isArabic),
              ),
              const SizedBox(height: 80),
              _Footer(isArabic: isArabic),
            ],
          ),
        );
      },
    );
  }
}

// ── Contact Cards Grid ────────────────────────────────────────────────────────

class _ContactCardsGrid extends StatelessWidget {
  const _ContactCardsGrid({required this.isArabic});
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _ContactCardData(
        icon: Icons.email_rounded,
        label: isArabic ? 'البريد الإلكتروني' : 'Email',
        value: PortfolioData.email,
        color: const Color(0xFFEA4335),
        url: 'mailto:${PortfolioData.email}',
        canCopy: true,
      ),
      _ContactCardData(
        icon: Icons.chat_rounded,
        label: 'WhatsApp',
        value: PortfolioData.whatsapp,
        color: const Color(0xFF25D366),
        url: 'https://wa.me/${PortfolioData.whatsapp.replaceAll('+', '')}',
        canCopy: true,
      ),
      _ContactCardData(
        icon: Icons.camera_alt_rounded,
        label: 'Instagram',
        value: PortfolioData.instagram,
        color: const Color(0xFFE1306C),
        url: 'https://instagram.com/${PortfolioData.instagram.replaceAll('@', '')}',
        canCopy: false,
      ),
      _ContactCardData(
        icon: Icons.code_rounded,
        label: 'GitHub',
        value: 'BDFU6000',
        color: const Color(0xFF6E5494),
        url: PortfolioData.githubUrl,
        canCopy: false,
      ),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final crossCount = constraints.maxWidth > 768
          ? 4
          : (constraints.maxWidth > 400 ? 2 : 1);
      final aspect = constraints.maxWidth > 768
          ? 1.3
          : (constraints.maxWidth > 400 ? 1.15 : 2.8);

      return GridView.count(
        crossAxisCount: crossCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: aspect,
        children: cards.map((c) => _ContactCard(data: c, isArabic: isArabic)).toList(),
      );
    });
  }
}

class _ContactCardData {
  const _ContactCardData({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.url,
    required this.canCopy,
  });
  final IconData icon;
  final String label, value, url;
  final Color color;
  final bool canCopy;
}

class _ContactCard extends StatefulWidget {
  const _ContactCard({required this.data, required this.isArabic});
  final _ContactCardData data;
  final bool isArabic;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.data.url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.data.value));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        widget.isArabic ? 'تم النسخ!' : 'Copied!',
        style: GoogleFonts.inter(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF131A2A),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardPadding = width > 500 ? 20.0 : 14.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.data.color.withOpacity(0.12)
                : Colors.white.withOpacity(0.03),
            border: Border.all(
              color: _hovered
                ? widget.data.color.withOpacity(0.6)
                : Colors.white.withOpacity(0.08),
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.data.color.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: widget.data.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.data.icon,
                        color: widget.data.color, size: 18),
                  ),
                  if (widget.data.canCopy)
                    GestureDetector(
                      onTap: () => _copy(context),
                      behavior: HitTestBehavior.opaque,
                      child: const Icon(Icons.copy_rounded,
                          color: Colors.white24, size: 16),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.data.label,
                style: GoogleFonts.inter(
                  color: Colors.white38,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.data.value,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Say Hello button → opens full contact dialog ──────────────────────────────

class _SayHelloButton extends StatefulWidget {
  const _SayHelloButton({required this.isArabic});
  final bool isArabic;

  @override
  State<_SayHelloButton> createState() => _SayHelloButtonState();
}

class _SayHelloButtonState extends State<_SayHelloButton> {
  bool _hovered = false;

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => _ContactDialog(isArabic: widget.isArabic),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showContactDialog(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          decoration: BoxDecoration(
            gradient: _hovered
                ? const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF7B2FFF)],
                  )
                : null,
            color: _hovered ? null : Colors.transparent,
            border: Border.all(
              color: _hovered
                  ? Colors.transparent
                  : const Color(0xFF00D4FF).withOpacity(0.5),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(40),
            boxShadow: _hovered
                ? [
                    const BoxShadow(
                      color: Color(0x5500D4FF),
                      blurRadius: 30,
                      offset: Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.waving_hand_rounded,
                color: _hovered ? Colors.white : const Color(0xFF00D4FF),
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                widget.isArabic ? 'ألقِ التحية' : 'Say Hello',
                style: GoogleFonts.poppins(
                  color: _hovered ? Colors.white : const Color(0xFF00D4FF),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Contact Dialog ────────────────────────────────────────────────────────────

class _ContactDialog extends StatelessWidget {
  const _ContactDialog({required this.isArabic});
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final contacts = [
      _DialogContact(
        emoji: '📧',
        platform: isArabic ? 'البريد الإلكتروني' : 'Email',
        handle: PortfolioData.email,
        color: const Color(0xFFEA4335),
        url: 'mailto:${PortfolioData.email}',
        canCopy: true,
      ),
      _DialogContact(
        emoji: '💬',
        platform: 'WhatsApp',
        handle: PortfolioData.whatsapp,
        color: const Color(0xFF25D366),
        url:
            'https://wa.me/${PortfolioData.whatsapp.replaceAll('+', '')}',
        canCopy: true,
      ),
      _DialogContact(
        emoji: '📸',
        platform: 'Instagram',
        handle: PortfolioData.instagram,
        color: const Color(0xFFE1306C),
        url: 'https://instagram.com/${PortfolioData.instagram.replaceAll('@', '')}',
        canCopy: false,
      ),
      _DialogContact(
        emoji: '🐙',
        platform: 'GitHub',
        handle: 'github.com/BDFU6000',
        color: const Color(0xFF6E5494),
        url: PortfolioData.githubUrl,
        canCopy: false,
      ),
    ];

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0D1321),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(0xFF00D4FF).withOpacity(0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D4FF).withOpacity(0.1),
                  blurRadius: 60,
                  spreadRadius: -10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF00D4FF).withOpacity(0.08),
                        const Color(0xFF7B2FFF).withOpacity(0.08),
                      ],
                    ),
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(28)),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(0.06),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00D4FF), Color(0xFF7B2FFF)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text('👋', style: TextStyle(fontSize: 24)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic ? 'تواصل معي' : "Let's Connect",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              isArabic
                                  ? 'اختر قناة التواصل المفضلة لديك'
                                  : 'Choose your preferred channel',
                              style: GoogleFonts.inter(
                                color: Colors.white38,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded,
                            color: Colors.white38, size: 20),
                      ),
                    ],
                  ),
                ),
                // Contact list
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: contacts
                        .map((c) => _DialogContactTile(
                              contact: c,
                              isArabic: isArabic,
                            ))
                        .toList(),
                  ),
                ),
                // Footer
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
                    isArabic
                        ? 'عادةً ما أرد خلال ٢٤ ساعة ✨'
                        : 'I usually respond within 24 hours ✨',
                    style: GoogleFonts.inter(
                        color: Colors.white24, fontSize: 12),
                    textAlign: TextAlign.center,
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

class _DialogContact {
  const _DialogContact({
    required this.emoji,
    required this.platform,
    required this.handle,
    required this.color,
    required this.url,
    required this.canCopy,
  });
  final String emoji, platform, handle, url;
  final Color color;
  final bool canCopy;
}

class _DialogContactTile extends StatefulWidget {
  const _DialogContactTile(
      {required this.contact, required this.isArabic});
  final _DialogContact contact;
  final bool isArabic;

  @override
  State<_DialogContactTile> createState() => _DialogContactTileState();
}

class _DialogContactTileState extends State<_DialogContactTile> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.contact.url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.contact.handle));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        widget.isArabic ? 'تم النسخ!' : 'Copied!',
        style: GoogleFonts.inter(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF131A2A),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _launch,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.contact.color.withOpacity(0.1)
                  : Colors.white.withOpacity(0.03),
              border: Border.all(
                color: _hovered
                    ? widget.contact.color.withOpacity(0.5)
                    : Colors.white.withOpacity(0.06),
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Text(widget.contact.emoji,
                    style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.contact.platform,
                        style: GoogleFonts.inter(
                            color: Colors.white38,
                            fontSize: 11,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        widget.contact.handle,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.contact.canCopy)
                  GestureDetector(
                    onTap: _copy,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(Icons.copy_rounded,
                          color: Colors.white24, size: 16),
                    ),
                  ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: _hovered
                      ? widget.contact.color
                      : Colors.white12,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer({required this.isArabic});
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterSocialIcon(
                icon: Icons.code, url: PortfolioData.githubUrl),
            const SizedBox(width: 20),
            _FooterSocialIcon(
                icon: Icons.chat_bubble_outline,
                url:
                    'https://wa.me/${PortfolioData.whatsapp.replaceAll('+', '')}'),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          isArabic
              ? 'صنع باستخدام فلاتر و 💙 بواسطة ${PortfolioData.name}'
              : 'Built with Flutter & 💙 by ${PortfolioData.name}',
          style: GoogleFonts.inter(color: Colors.white24, fontSize: 13),
        ),
      ],
    );
  }
}

class _FooterSocialIcon extends StatefulWidget {
  const _FooterSocialIcon({required this.icon, required this.url});
  final IconData icon;
  final String url;

  @override
  State<_FooterSocialIcon> createState() => _FooterSocialIconState();
}

class _FooterSocialIconState extends State<_FooterSocialIcon> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          child: Icon(
            widget.icon,
            color: _hovered ? const Color(0xFF00D4FF) : Colors.white38,
            size: 24,
          ),
        ),
      ),
    );
  }
}
