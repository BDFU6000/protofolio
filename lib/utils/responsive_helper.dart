import 'package:flutter/material.dart';

abstract final class AppLayout {
  static const double phoneMaxWidth = 480;
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 960;
  static const double compactNavMaxWidth = 920;
  static const double mobileGutter = 16;
  static const double tabletGutter = 28;
  static const double desktopGutter = 36;
  static const double minTouchTarget = 48;
  static const double stickyNavHeight = 66;
}

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

  /// Small phones where multi-column layouts must collapse further.
  bool get isPhone => screenWidth <= AppLayout.phoneMaxWidth;

  /// Page gutter matched to the device class.
  double get horizontalGutter => screenWidth > 1200
      ? AppLayout.desktopGutter
      : (screenWidth > 700 ? AppLayout.tabletGutter : AppLayout.mobileGutter);
}
