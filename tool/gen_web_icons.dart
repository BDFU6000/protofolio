// Regenerates the web favicon and PWA icons from assets/images/logo.png.
//
// Run from the project root with:
//   dart run tool/gen_web_icons.dart
//
// The source logo is letterboxed (contain-fit) onto a square canvas so it is
// never distorted, regardless of its aspect ratio.

import 'dart:io';
import 'package:image/image.dart' as img;

const sourcePath = 'assets/images/logo.png';

void main() {
  final bytes = File(sourcePath).readAsBytesSync();
  final logo = img.decodePng(bytes);
  if (logo == null) {
    stderr.writeln('Could not decode $sourcePath');
    exit(1);
  }

  // (output path, square size, inner-content fraction, background color)
  // Transparent background for favicon/standard icons; white for maskable so
  // the logo stays visible inside the circular safe-zone mask.
  final transparent = img.ColorRgba8(0, 0, 0, 0);
  // Sample the logo's own corner so maskable padding blends seamlessly.
  final corner = logo.getPixel(0, 0);
  final logoBg = img.ColorRgba8(
    corner.r.toInt(),
    corner.g.toInt(),
    corner.b.toInt(),
    255,
  );

  final targets = <List<Object>>[
    ['web/favicon.png', 32, 1.0, transparent],
    ['web/icons/Icon-192.png', 192, 1.0, transparent],
    ['web/icons/Icon-512.png', 512, 1.0, transparent],
    ['web/icons/Icon-maskable-192.png', 192, 0.72, logoBg],
    ['web/icons/Icon-maskable-512.png', 512, 0.72, logoBg],
  ];

  for (final t in targets) {
    final path = t[0] as String;
    final size = t[1] as int;
    final fraction = t[2] as double;
    final bg = t[3] as img.Color;
    _renderIcon(logo, path, size, fraction, bg);
    stdout.writeln('  wrote $path (${size}x$size)');
  }

  stdout.writeln('Done.');
}

void _renderIcon(
  img.Image logo,
  String outPath,
  int size,
  double contentFraction,
  img.Color background,
) {
  final canvas = img.Image(width: size, height: size, numChannels: 4);
  img.fill(canvas, color: background);

  // Scale the logo to fit inside (size * contentFraction) while keeping aspect.
  final box = (size * contentFraction).round();
  final scale = box / (logo.width > logo.height ? logo.width : logo.height);
  final w = (logo.width * scale).round();
  final h = (logo.height * scale).round();

  final resized = img.copyResize(
    logo,
    width: w,
    height: h,
    interpolation: img.Interpolation.cubic,
  );

  final dx = ((size - w) / 2).round();
  final dy = ((size - h) / 2).round();
  img.compositeImage(canvas, resized, dstX: dx, dstY: dy);

  File(outPath).writeAsBytesSync(img.encodePng(canvas));
}
