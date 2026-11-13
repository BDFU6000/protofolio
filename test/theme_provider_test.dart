import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_protofolio/utils/theme_provider.dart';

void main() {
  test('theme toggle switches between dark and light', () {
    ThemeProvider.mode.value = ThemeMode.dark;

    ThemeProvider.toggle();
    expect(ThemeProvider.mode.value, ThemeMode.light);

    ThemeProvider.toggle();
    expect(ThemeProvider.mode.value, ThemeMode.dark);
  });
}
