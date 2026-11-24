import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../utils/locale_provider.dart';
import '../utils/responsive_helper.dart';
import '../widgets/optimized_image.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    this.onNavigate,
    this.onBackToTop,
  });

  static const _aqua = Color(0xFF52D8DE);

  final ValueChanged<int>? onNavigate;
  final VoidCallback? onBackToTop;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: LocaleProvider.isArabic,
        builder: (context, isArabic, _) {
          final isWide = MediaQuery.sizeOf(context).width > 760;
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0,
              vertical: isWide ? 64 : 44,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: isWide ? 90 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF073F45),
                          border: Border.all(color: const Color(0xFF16818A)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.circle, size: 9, color: _aqua),
                            const SizedBox(width: 6),
                            Text(
                              isArabic ? 'تواصل معي' : 'Contact me.',
                              style: GoogleFonts.inter(
                                color: _aqua,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      // Heading
                      Text.rich(
                        TextSpan(
                          style: GoogleFonts.orbitron(
                            color: Colors.white,
                            fontSize: isWide ? 34 : 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: isWide ? 5 : 2,
                            height: 1.25,
                            shadows: const [
                              Shadow(
                                color: Color(0xAA00D4FF),
                                offset: Offset(2, 2),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          children: [
                            TextSpan(text: isArabic ? 'لنبنِ ' : "Let's "),
                            TextSpan(
                              text: isArabic
                                  ? 'شيئاً مميزاً.'
                                  : 'Build Together.',
                              style: const TextStyle(color: _aqua),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isArabic
                            ? 'لديك فكرة؟ تواصل معي وسنحولها إلى واقع.'
                            : 'Have an idea? Reach out and let\'s make it real.',
                        style: GoogleFonts.orbitron(
                          color: Colors.white,
                          fontSize: isWide ? 13 : (context.isPhone ? 12 : 10),
                          letterSpacing:
                              isWide ? 3 : (context.isPhone ? 0.2 : 1),
                          height: 1.6,
                          shadows: const [
                            Shadow(
                              color: Color(0xAA00D4FF),
                              offset: Offset(1, 2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final details = _ContactDetails(isArabic: isArabic);
                    final form = _PortfolioContactForm(isArabic: isArabic);
                    if (constraints.maxWidth > 760) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 4, child: details),
                          const SizedBox(width: 26),
                          Expanded(flex: 6, child: form),
                        ],
                      );
                    }
                    return Column(
                      children: [details, const SizedBox(height: 22), form],
                    );
                  },
                ),
                const SizedBox(height: 52),
                _PortfolioFooter(
                  isArabic: isArabic,
                  onNavigate: onNavigate,
                  onBackToTop: onBackToTop,
                ),
              ],
            ),
          );
        },
      );
}

class _ContactDetails extends StatelessWidget {
  const _ContactDetails({required this.isArabic});
  final bool isArabic;

  static const _aqua = Color(0xFF52D8DE);

  static const _entries = [
    ('assets/images/Gmail_logo.png', 'Email', PortfolioData.email),
    ('assets/images/whatsapp_logo.webp', 'WhatsApp', PortfolioData.whatsapp),
    ('assets/images/Instagram_logo.png', 'Instagram', PortfolioData.instagram),
    ('assets/images/Github_logo.png', 'GitHub', 'BDFU6000'),
    ('assets/images/Linkedin_LOGO.png', 'LinkedIn', 'Moneeb Salah Abusetta'),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFF4EDDE3).withValues(alpha: .07),
            border: Border.all(color: _aqua.withValues(alpha: .18)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isArabic
                    ? 'يسعدني أن أسمع منك.'
                    : "Let's make your next idea real.",
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 22),
              for (final entry in _entries)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _launchEntry(context, entry.$2, entry.$3),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      constraints: const BoxConstraints(
                          minHeight: AppLayout.minTouchTarget),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: .15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(7),
                            child: OptimizedImage.asset(
                              assetName: entry.$1,
                              fit: BoxFit.contain,
                              priority: ImageLoadPriority.normal,
                              lazy: true,
                              placeholderIcon: Icons.image_outlined,
                              errorIcon: Icons.link_rounded,
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.$2,
                                  style: GoogleFonts.inter(
                                    color: _aqua,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  entry.$3,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchEntry(
    BuildContext context,
    String label,
    String value,
  ) async {
    final Uri? uri = switch (label) {
      'Email' => Uri.parse('mailto:$value'),
      'WhatsApp' =>
        Uri.parse('https://wa.me/${value.replaceAll(RegExp(r'[^0-9]'), '')}'),
      'Instagram' =>
        Uri.parse('https://instagram.com/${value.replaceAll('@', '')}'),
      'GitHub' => Uri.parse('https://github.com/BDFU6000'),
      _ => null,
    };
    if (uri == null) return;
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(isArabic ? 'تعذر فتح الرابط.' : 'Could not open this link.'),
        ),
      );
    }
  }
}

class _PortfolioContactForm extends StatefulWidget {
  const _PortfolioContactForm({required this.isArabic});
  final bool isArabic;

  @override
  State<_PortfolioContactForm> createState() => _PortfolioContactFormState();
}

class _PortfolioContactFormState extends State<_PortfolioContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSending = true);
    try {
      final subject = Uri.encodeComponent(
          'Portfolio inquiry from ${_nameController.text.trim()}');
      final body = Uri.encodeComponent(
        'Name: ${_nameController.text.trim()}\nEmail: ${_emailController.text.trim()}\n\n${_messageController.text.trim()}',
      );
      final uri = Uri.parse(
          'mailto:${PortfolioData.email}?subject=$subject&body=$body');
      if (!await canLaunchUrl(uri)) throw Exception('No email app');
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              widget.isArabic ? 'تم فتح تطبيق البريد.' : 'Email app opened.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.isArabic
              ? 'تعذر فتح تطبيق البريد.'
              : 'Could not open an email app.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(context.isPhone ? 20 : 26),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC900).withValues(alpha: .08),
              border: Border.all(
                color: const Color(0xFFFFC900).withValues(alpha: .28),
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFC900).withValues(alpha: .12),
                  blurRadius: 32,
                  spreadRadius: 1,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC900).withValues(alpha: .15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.mark_email_unread_rounded,
                          color: Color(0xFFFFC900),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          widget.isArabic
                              ? 'أخبرني عن فكرتك'
                              : 'Tell me about your idea',
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: context.isPhone ? 16 : 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  _MessageField(
                    controller: _nameController,
                    label: widget.isArabic ? 'الاسم' : 'Your name',
                    icon: Icons.person_outline_rounded,
                    isArabic: widget.isArabic,
                  ),
                  const SizedBox(height: 14),
                  _MessageField(
                    controller: _emailController,
                    label: widget.isArabic ? 'البريد الإلكتروني' : 'Your email',
                    isEmail: true,
                    icon: Icons.alternate_email_rounded,
                    isArabic: widget.isArabic,
                  ),
                  const SizedBox(height: 14),
                  _MessageField(
                    controller: _messageController,
                    label: widget.isArabic ? 'رسالتك' : 'Your message',
                    maxLines: 4,
                    icon: Icons.chat_bubble_outline_rounded,
                    isArabic: widget.isArabic,
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _isSending ? null : _sendMessage,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC900),
                        foregroundColor: const Color(0xFF12383A),
                        disabledBackgroundColor:
                            const Color(0xFFFFC900).withValues(alpha: .6),
                        minimumSize: const Size(0, AppLayout.minTouchTarget),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: .5,
                        ),
                      ),
                      icon: _isSending
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Color(0xFF12383A)),
                            )
                          : const Icon(Icons.send_rounded, size: 17),
                      label: Text(widget.isArabic
                          ? 'إرسال الرسالة'
                          : (_isSending ? 'Sending...' : 'Send Message')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _MessageField extends StatelessWidget {
  const _MessageField({
    required this.controller,
    required this.label,
    required this.icon,
    this.isEmail = false,
    this.maxLines = 1,
    this.isArabic = false,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isEmail;
  final int maxLines;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        style: GoogleFonts.inter(
          color: const Color(0xFF032D32),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(
            color: const Color(0xFF032D32).withValues(alpha: .6),
            fontSize: 13,
          ),
          prefixIcon: Icon(icon, size: 20, color: const Color(0xFF06454A)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Color(0xFFFFC900), width: 1.5),
          ),
          errorStyle: const TextStyle(color: Color(0xFF8E1B1B)),
        ),
        validator: (value) {
          final text = value?.trim() ?? '';
          if (text.isEmpty) {
            return isArabic ? 'مطلوب' : 'Required';
          }
          if (isEmail && !RegExp(r'^.+@.+\..+$').hasMatch(text)) {
            return isArabic
                ? 'أدخل بريداً إلكترونياً صحيحاً'
                : 'Enter a valid email';
          }
          return null;
        },
      );
}

class _PortfolioFooter extends StatelessWidget {
  const _PortfolioFooter({
    required this.isArabic,
    this.onNavigate,
    this.onBackToTop,
  });

  static const _aqua = Color(0xFF52D8DE);
  static const _gold = Color(0xFFFFC900);

  static const _socials = <(IconData, String, String)>[
    (Icons.code, 'GitHub', PortfolioData.githubUrl),
    (Icons.link, 'LinkedIn', PortfolioData.linkedinUrl),
    (Icons.alternate_email, 'Email', 'mailto:${PortfolioData.email}'),
    (
      Icons.camera_alt_outlined,
      'Instagram',
      'https://instagram.com/moneeb_salah6'
    ),
  ];

  final bool isArabic;
  final ValueChanged<int>? onNavigate;
  final VoidCallback? onBackToTop;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 760;
    final content = Padding(
      padding: EdgeInsets.all(wide ? 34 : 22),
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: _brand(context)),
                const SizedBox(width: 22),
                Expanded(flex: 3, child: _explore()),
                const SizedBox(width: 22),
                Expanded(flex: 3, child: _contact(context)),
                const SizedBox(width: 22),
                Expanded(flex: 3, child: _social(context)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _brand(context),
                const SizedBox(height: 28),
                _explore(),
                const SizedBox(height: 28),
                _contact(context),
                const SizedBox(height: 28),
                _social(context),
              ],
            ),
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF073A40), Color(0xFF041E23)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: _gold.withValues(alpha: .28)),
        borderRadius: BorderRadius.circular(22),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            content,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: wide ? 34 : 22,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: _gold.withValues(alpha: .08),
                border: Border(
                  top: BorderSide(color: _gold.withValues(alpha: .2)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '© ${DateTime.now().year} ${PortfolioData.name} · ${isArabic ? 'صُمم وبُني بـ Flutter' : 'Designed & built with Flutter'}',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 11,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Material(
                    color: _gold.withValues(alpha: .14),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: onBackToTop ?? () => _scrollToTop(context),
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 42,
                        height: 42,
                        child: Icon(
                          Icons.keyboard_arrow_up_rounded,
                          color: _gold,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _brand(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _gold,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: Text(
                    PortfolioData.name.trim().isEmpty
                        ? 'M'
                        : PortfolioData.name.trim()[0].toUpperCase(),
                    style: GoogleFonts.orbitron(
                      color: const Color(0xFF17383A),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  PortfolioData.name,
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            isArabic
                ? 'مطور Flutter ومصمم واجهات يبني تجارب عملية بواجهات واضحة وأداء حقيقي.'
                : 'Flutter developer and UI designer building practical experiences with clear interfaces and real performance.',
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 12,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withValues(alpha: .1),
              border:
                  Border.all(color: Colors.greenAccent.withValues(alpha: .4)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.circle, size: 8, color: Colors.greenAccent),
                const SizedBox(width: 8),
                Text(
                  isArabic ? 'متاح للمشاريع الجديدة' : 'Available for new work',
                  style: GoogleFonts.inter(
                    color: Colors.greenAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _explore() => _footerColumn(
        title: isArabic ? 'استكشف' : 'Explore',
        children: [
          for (var index = 0; index < PortfolioData.navItems.length; index++)
            _footerLink(
              label: PortfolioData.navItems[index],
              onTap: () => onNavigate?.call(index),
            ),
        ],
      );

  Widget _contact(BuildContext context) => _footerColumn(
        title: isArabic ? 'تواصل مباشرة' : 'Reach me',
        children: [
          _footerContact(
            icon: Icons.mail_outline,
            label: PortfolioData.email,
            onTap: () => _openLink(
              context,
              'mailto:${PortfolioData.email}',
            ),
          ),
          _footerContact(
            icon: Icons.chat_bubble_outline,
            label: PortfolioData.whatsapp,
            onTap: () => _openLink(
              context,
              'https://wa.me/${PortfolioData.whatsapp.replaceAll(RegExp(r'[^0-9]'), '')}',
            ),
          ),
          _footerContact(
            icon: Icons.location_on_outlined,
            label: isArabic ? 'ليبيا · عن بُعد' : 'Libya · Remote',
            onTap: null,
          ),
        ],
      );

  Widget _social(BuildContext context) => _footerColumn(
        title: isArabic ? 'تابعني' : 'Follow',
        children: [
          for (final social in _socials)
            _footerContact(
              icon: social.$1,
              label: social.$2,
              onTap: () => _openLink(context, social.$3),
            ),
        ],
      );

  Widget _footerColumn({
    required String title,
    required List<Widget> children,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.orbitron(
              color: _gold,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      );

  Widget _footerLink({required String label, required VoidCallback onTap}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 11, color: _aqua),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: .78),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _footerContact({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Icon(icon, size: 16, color: _aqua),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: .78),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> _openLink(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic ? 'تعذر فتح الرابط.' : 'Could not open this link.',
          ),
        ),
      );
    }
  }

  Future<void> _scrollToTop(BuildContext context) async {
    final position = Scrollable.of(context).position;
    await position.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }
}
