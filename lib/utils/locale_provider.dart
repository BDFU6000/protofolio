import 'package:flutter/material.dart';

class LocaleProvider {
  // Arabic (RTL) is the default language for the portfolio.
  static final ValueNotifier<bool> isArabic = ValueNotifier<bool>(true);

  static void toggle() {
    isArabic.value = !isArabic.value;
  }
}
