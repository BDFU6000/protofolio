import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_protofolio/widgets/optimized_image.dart';
import 'package:my_protofolio/widgets/projects_section.dart';

void main() {
  testWidgets('carousel advances and exposes the selected project',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: ProjectsSection()),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Smart Clinic'), findsOneWidget);
    expect(find.text('01 / 10'), findsOneWidget);

    await tester.tap(find.byTooltip('Next project'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 450));

    expect(find.text('Sidaliti'), findsWidgets);
    expect(find.text('02 / 10'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Smart Clinic uses a PC frame and AI Assistant adds the robot',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: ProjectsSection()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(_assetFinder('assets/images/smart-clinic.png'), findsWidgets);

    for (var index = 0; index < 3; index++) {
      await tester.tap(find.byTooltip('Next project'));
      await tester.pumpAndSettle();
    }

    expect(find.text('04 / 10'), findsOneWidget);
    expect(_assetFinder('assets/images/smart-clinic.png'), findsWidgets);
    expect(
      _assetFinder('assets/images/Robot_smart_clinic.png'),
      findsWidgets,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Feedme screenshots pixel-fit their phone frames',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: ProjectsSection()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    for (var index = 1; index < 10; index++) {
      await tester.tap(find.byTooltip('Next project'));
      await tester.pumpAndSettle();
    }

    expect(find.text('10 / 10'), findsOneWidget);
    _expectImageAspect(tester, 'assets/images/Login Page.png', 430 / 932);
    _expectImageAspect(tester, 'assets/images/Main Page.png', 428 / 913);
    expect(tester.takeException(), isNull);
  });

  test('image assets resolve to optimized WebP variants', () {
    expect(
      OptimizedAssetRegistry.resolve('assets/images/Moneeb.png'),
      'assets/images/optimized/moneeb_hero.webp',
    );
    expect(
      OptimizedAssetRegistry.resolve('assets/images/smart-clinic.png'),
      'assets/images/optimized/smart-clinic-1600.webp',
    );
    expect(
      OptimizedAssetRegistry.resolve(
        'assets/images/smart-clinic.png',
        compact: true,
      ),
      'assets/images/optimized/smart-clinic-800.webp',
    );
    expect(
      OptimizedAssetRegistry.resolve('assets/images/whatsapp_logo.webp'),
      'assets/images/whatsapp_logo.webp',
    );
  });
}

String? _assetNameOf(Widget widget) {
  if (widget is! Image) return null;
  final provider = widget.image;
  if (provider is AssetImage) return provider.assetName;
  if (provider is ResizeImage && provider.imageProvider is AssetImage) {
    return (provider.imageProvider as AssetImage).assetName;
  }
  return null;
}

Finder _assetFinder(String assetName) {
  final resolved = OptimizedAssetRegistry.resolve(assetName);
  return find.byWidgetPredicate(
    (widget) => _assetNameOf(widget) == resolved,
  );
}

void _expectImageAspect(
  WidgetTester tester,
  String assetName,
  double expectedAspect,
) {
  final finder = _assetFinder(assetName);
  expect(finder, findsOneWidget);

  RenderImage? renderImage;
  void collectRenderImage(RenderObject object) {
    if (object is RenderImage) {
      renderImage ??= object;
      return;
    }
    object.visitChildren(collectRenderImage);
  }

  collectRenderImage(tester.element(finder).renderObject!);
  expect(renderImage, isNotNull);

  final size = renderImage!.size;
  expect(size.width, greaterThan(0));
  expect(size.height, greaterThan(0));
  expect(size.width / size.height, closeTo(expectedAspect, 0.001));
}
