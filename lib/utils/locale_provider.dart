import 'package:flutter/material.dart';

class LocaleProvider {
  // The reference portfolio is English-first; Arabic remains available in the navbar.
  static final ValueNotifier<bool> isArabic = ValueNotifier<bool>(false);

  static void toggle() {
    isArabic.value = !isArabic.value;
  }
}
