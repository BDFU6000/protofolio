import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_protofolio/data/portfolio_data.dart';
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

  testWidgets('lead pipeline card uses the supplied infographic',
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

    for (var index = 0; index < 4; index++) {
      await tester.tap(find.byTooltip('Next project'));
      await tester.pumpAndSettle();
    }

    expect(find.text('Business Lead Generation Pipeline'), findsWidgets);
    expect(
      _assetFinder('assets/images/Seven-Stage Data Pipeline Infographic.png'),
      findsOneWidget,
    );
    expect(find.text('📈'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Libyan voice card renders a smaller portrait overflow image',
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

    for (var index = 0; index < 5; index++) {
      await tester.tap(find.byTooltip('Next project'));
      await tester.pumpAndSettle();
    }

    expect(find.text('Libyan Arabic AI Voice Research'), findsWidgets);
    final finder = _assetFinder('assets/images/Libyan_dealect_Ai_voice.png');
    expect(finder, findsOneWidget);
    final size = tester.getSize(finder);
    expect(size.width, greaterThan(180));
    expect(size.width, lessThan(360));
    expect(size.height, greaterThan(size.width));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tamayoz website visual is enlarged on mobile',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 1200);
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

    for (var index = 0; index < 6; index++) {
      await tester.tap(find.byTooltip('Next project'));
      await tester.pumpAndSettle();
    }

    final finder = _assetFinder('assets/images/Tamayous_website.png');
    expect(finder, findsOneWidget);
    expect(tester.getSize(finder).width, greaterThan(170));
    expect(tester.takeException(), isNull);
  });

  test('Tamayoz projects use their requested visual assets', () {
    final website = PortfolioData.englishProjects.firstWhere(
      (project) => project.title == "Tamayoz Al-Da'em Corporate Website",
    );
    final erp = PortfolioData.englishProjects.firstWhere(
      (project) => project.title == 'Tamayoz ERPNext Customization',
    );

    expect(website.featuredVisual, 'desktop-mobile');
    expect(website.featuredImages, [
      'assets/images/Tamayous_website.png',
      'assets/images/Tamayous_website_mobile .png',
    ]);
    expect(erp.imageUrl, 'assets/images/ERPNext.png');
    expect(erp.featuredVisual, 'plain-image');
    expect(erp.featuredImages, ['assets/images/ERPNext.png']);

    final pipeline = PortfolioData.englishProjects.firstWhere(
      (project) => project.title == 'Business Lead Generation Pipeline',
    );
    expect(pipeline.featuredVisual, 'infographic');
    expect(pipeline.featuredImages, [
      'assets/images/Seven-Stage Data Pipeline Infographic.png',
    ]);

    final voice = PortfolioData.englishProjects.firstWhere(
      (project) => project.title == 'Libyan Arabic AI Voice Research',
    );
    expect(voice.featuredVisual, 'voice-overflow');
    expect(voice.featuredImages, ['assets/images/Libyan_dealect_Ai_voice.png']);
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
