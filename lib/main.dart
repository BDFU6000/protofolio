import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'portfolio_screen.dart';
import 'utils/locale_provider.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LocaleProvider.isArabic,
      builder: (context, isArabic, child) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: MaterialApp(
            title: 'Abd Almoneeb Abusetta | Portfolio',
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return Directionality(
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                child: child!,
              );
            },
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF0A0F1E),
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFF00D4FF),
                secondary: Color(0xFF7B2FFF),
                surface: Color(0xFF131A2A),
              ),
              textTheme: isArabic
                  ? GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme)
                  : GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
            ),
            home: const PortfolioScreen(),
          ),
        );
      },
    );
  }
}
