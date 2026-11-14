import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'portfolio_screen.dart';
import 'utils/locale_provider.dart';
import 'utils/theme_provider.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeProvider.mode,
      builder: (context, themeMode, _) => ValueListenableBuilder<bool>(
        valueListenable: LocaleProvider.isArabic,
        builder: (context, isArabic, child) {
          final lightTextTheme = isArabic
              ? GoogleFonts.cairoTextTheme(ThemeData.light().textTheme)
              : GoogleFonts.interTextTheme(ThemeData.light().textTheme);
          final darkTextTheme = isArabic
              ? GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme)
              : GoogleFonts.interTextTheme(ThemeData.dark().textTheme);

          return Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: MaterialApp(
              title: 'Eng:AbdAlmoneeb Abusetta | Portfolio',
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                scaffoldBackgroundColor: const Color(0xFF032D32),
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFFFFC900),
                  secondary: Color(0xFF62DADD),
                  surface: Color(0xFF06454A),
                ),
                textTheme: lightTextTheme,
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                scaffoldBackgroundColor: const Color(0xFF032D32),
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFFFFC900),
                  secondary: Color(0xFF62DADD),
                  surface: Color(0xFF06454A),
                ),
                textTheme: darkTextTheme,
              ),
              builder: (context, child) {
                return Directionality(
                  textDirection:
                      isArabic ? TextDirection.rtl : TextDirection.ltr,
                  child: child!,
                );
              },
              home: const PortfolioScreen(),
            ),
          );
        },
      ),
    );
  }
}
