import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  /// Mobile screen size: width <= 600
  bool get isMobile => MediaQuery.of(this).size.width <= 600;

  /// Tablet screen size: width between 601 and 960
  bool get isTablet =>
      MediaQuery.of(this).size.width > 600 &&
      MediaQuery.of(this).size.width <= 960;

  /// Desktop screen size: width > 960
  bool get isDesktop => MediaQuery.of(this).size.width > 960;

  /// Returns true if mobile or tablet viewports are active
  bool get isMobileOrTablet => MediaQuery.of(this).size.width <= 960;

  /// Quick access to screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Quick access to screen height
  double get screenHeight => MediaQuery.of(this).size.height;
}
