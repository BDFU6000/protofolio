import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../utils/locale_provider.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const _aqua = Color(0xFF52D8DE);

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                        text: isArabic ? 'شيئاً مميزاً.' : 'Build Together.',
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
                    fontSize: isWide ? 13 : 10,
                    letterSpacing: isWide ? 3 : 1,
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
                const _ReferenceFooter(),
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
                isArabic ? 'يسعدني أن أسمع منك.' : "Let's make your next idea real.",
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 22),
              for (final entry in _entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    children: [
                      // White background logo container
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
                        child: Image.asset(
                          entry.$1,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.link_rounded,
                            size: 18,
                            color: Color(0xFF032D32),
                          ),
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
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.1,
                              ),
                            ),
                            Text(
                              entry.$3,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;
    final subject = Uri.encodeComponent(
        'Portfolio inquiry from ${_nameController.text.trim()}');
    final body = Uri.encodeComponent(
      'Name: ${_nameController.text.trim()}\nEmail: ${_emailController.text.trim()}\n\n${_messageController.text.trim()}',
    );
    final uri =
        Uri.parse('mailto:${PortfolioData.email}?subject=$subject&body=$body');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.isArabic
              ? 'تعذر فتح تطبيق البريد.'
              : 'Could not open an email app.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(26),
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
                      Text(
                        widget.isArabic
                            ? 'أخبرني عن فكرتك'
                            : 'Tell me about your idea',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  _MessageField(
                    controller: _nameController,
                    label: widget.isArabic ? 'الاسم' : 'Your name',
                    icon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 14),
                  _MessageField(
                    controller: _emailController,
                    label: widget.isArabic
                        ? 'البريد الإلكتروني'
                        : 'Your email',
                    isEmail: true,
                    icon: Icons.alternate_email_rounded,
                  ),
                  const SizedBox(height: 14),
                  _MessageField(
                    controller: _messageController,
                    label: widget.isArabic ? 'رسالتك' : 'Your message',
                    maxLines: 4,
                    icon: Icons.chat_bubble_outline_rounded,
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _sendMessage,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC900),
                        foregroundColor: const Color(0xFF12383A),
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
                      icon: const Icon(Icons.send_rounded, size: 17),
                      label: Text(
                          widget.isArabic ? 'إرسال الرسالة' : 'Send Message'),
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
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isEmail;
  final int maxLines;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        style: GoogleFonts.inter(
          color: const Color(0xFF032D32),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(
            color: const Color(0xFF032D32).withValues(alpha: .6),
            fontSize: 12,
          ),
          prefixIcon: Icon(icon, size: 17, color: const Color(0xFF06454A)),
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
          errorStyle: const TextStyle(color: Color(0xFFFFB4AB)),
        ),
        validator: (value) {
          final text = value?.trim() ?? '';
          if (text.isEmpty) return 'Required';
          if (isEmail && !RegExp(r'^.+@.+\..+$').hasMatch(text)) {
            return 'Enter a valid email';
          }
          return null;
        },
      );
}

class _ReferenceFooter extends StatelessWidget {
  const _ReferenceFooter();

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          color: const Color(0xFFFFC900),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          '© ${DateTime.now().year} ${PortfolioData.name} · Built with Flutter',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF17383A),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
