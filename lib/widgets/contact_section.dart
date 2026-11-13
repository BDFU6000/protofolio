import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../utils/locale_provider.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: LocaleProvider.isArabic,
        builder: (context, isArabic, _) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 58),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ContactSectionLabel(text: isArabic ? 'تواصل معي' : 'CONTACT ME'),
              const SizedBox(height: 18),
              Text(
                isArabic
                    ? 'لنبنِ شيئاً مميزاً معاً.'
                    : "Let's work together. Have an idea? Let's build it.",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: MediaQuery.sizeOf(context).width > 760 ? 34 : 26,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 28),
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
        ),
      );
}

class _ContactSectionLabel extends StatelessWidget {
  const _ContactSectionLabel({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFF0B555B),
          border: Border.all(color: const Color(0xFF178D93)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: const Color(0xFF69E4E6),
            fontSize: 11,
            letterSpacing: 1.1,
          ),
        ),
      );
}

class _ContactDetails extends StatelessWidget {
  const _ContactDetails({required this.isArabic});
  final bool isArabic;

  static const _entries = [
    ('assets/images/Gmail_logo.png', 'Email', PortfolioData.email),
    ('assets/images/whatsapp_logo.webp', 'WhatsApp', PortfolioData.whatsapp),
    ('assets/images/Instagram_logo.png', 'Instagram', PortfolioData.instagram),
    ('assets/images/Github_logo.png', 'GitHub', 'BDFU6000'),
    ('assets/images/Linkedin_LOGO.png', 'LinkedIn', 'Moneeb Salah Abusetta'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'يسعدني أن أسمع منك.' : "Let's make your next idea real.",
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 22),
        for (final entry in _entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC900).withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(
                    entry.$1,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.link_rounded,
                      size: 17,
                      color: Color(0xFFFFC900),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.$2,
                        style: GoogleFonts.inter(
                          color: Colors.white54,
                          fontSize: 10,
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
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0A4A50).withValues(alpha: .8),
          border: Border.all(color: const Color(0xFF167C82)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isArabic ? 'أخبرني عن فكرتك' : 'Tell me about your idea',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _MessageField(
                controller: _nameController,
                label: widget.isArabic ? 'الاسم' : 'Your name',
              ),
              const SizedBox(height: 12),
              _MessageField(
                controller: _emailController,
                label: widget.isArabic ? 'البريد الإلكتروني' : 'Your email',
                isEmail: true,
              ),
              const SizedBox(height: 12),
              _MessageField(
                controller: _messageController,
                label: widget.isArabic ? 'رسالتك' : 'Your message',
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: FilledButton.icon(
                  onPressed: _sendMessage,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC900),
                    foregroundColor: const Color(0xFF12383A),
                  ),
                  icon: const Icon(Icons.send_rounded, size: 16),
                  label: Text(widget.isArabic ? 'إرسال' : 'Send message'),
                ),
              ),
            ],
          ),
        ),
      );
}

class _MessageField extends StatelessWidget {
  const _MessageField({
    required this.controller,
    required this.label,
    this.isEmail = false,
    this.maxLines = 1,
  });
  final TextEditingController controller;
  final String label;
  final bool isEmail;
  final int maxLines;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(color: Colors.white60, fontSize: 12),
          filled: true,
          fillColor: Colors.white.withValues(alpha: .08),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide.none,
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
