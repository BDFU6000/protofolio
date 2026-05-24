import 'package:flutter/material.dart';

class LocaleProvider {
  static final ValueNotifier<bool> isArabic = ValueNotifier<bool>(false);

  static void toggle() {
    isArabic.value = !isArabic.value;
  }
}
