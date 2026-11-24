import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_protofolio/data/portfolio_data.dart';
import 'package:my_protofolio/screens/project_details_screen.dart';
import 'package:my_protofolio/utils/locale_provider.dart';
import 'package:my_protofolio/widgets/optimized_image.dart';

void main() {
  testWidgets('project details renders project-specific specification',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home:
            ProjectDetailsScreen(project: PortfolioData.englishProjects.first),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('CLINIC OPERATING SYSTEM'), findsOneWidget);
    expect(find.text('Project specification'), findsOneWidget);
    expect(find.text('Project Scope'), findsOneWidget);
    expect(find.text('11'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Torrance details include the website comparison study',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final project = PortfolioData.englishProjects.firstWhere(
      (item) => item.emoji == '🏗️',
    );

    await tester.pumpWidget(
      MaterialApp(home: ProjectDetailsScreen(project: project)),
    );
    await tester.pumpAndSettle();

    expect(find.text('WEBSITE REDESIGN CONCEPT'), findsOneWidget);
    expect(find.text('Website comparison'), findsOneWidget);
    expect(find.text('Before / after'), findsOneWidget);
    expect(find.text('What I Built'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('lead pipeline shows every documented processing stage',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final project = PortfolioData.englishProjects.firstWhere(
      (item) => item.emoji == '📈',
    );

    await tester.pumpWidget(
      MaterialApp(home: ProjectDetailsScreen(project: project)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Source-to-delivery pipeline'), findsOneWidget);
    expect(find.text('Collect public listings'), findsOneWidget);
    expect(find.text('Extract raw fields'), findsOneWidget);
    expect(find.text('Clean the records'), findsOneWidget);
    expect(find.text('Filter and qualify'), findsOneWidget);
    expect(find.text('Prepare the text'), findsOneWidget);
    expect(find.text('Draft outreach'), findsOneWidget);
    expect(find.text('Report and review'), findsOneWidget);
    expect(find.text('Google Maps / Places'), findsOneWidget);
    expect(find.text('STAGE 04'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('AI Assistant details show the PC frame with robot aside',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final project = PortfolioData.englishProjects.firstWhere(
      (item) => item.title == 'Smart Clinic AI Assistant',
    );

    await tester.pumpWidget(
      MaterialApp(home: ProjectDetailsScreen(project: project)),
    );
    await tester.pumpAndSettle();

    expect(find.text('AI assistant workspace'), findsOneWidget);
    expect(find.text('Assistant identity'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Assistant context'), 200);
    await tester.pumpAndSettle();
    expect(_assetFinder('assets/images/smart-clinic.png'), findsWidgets);
    expect(
      _assetFinder('assets/images/Robot_smart_clinic.png'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Doctor Leandek details show phone-framed main features',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final project = PortfolioData.englishProjects.firstWhere(
      (item) => item.title == 'Doctor Leandek',
    );

    await tester.pumpWidget(
      MaterialApp(home: ProjectDetailsScreen(project: project)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Main app screens'), findsOneWidget);
    expect(
      find.textContaining('Phone OTP sign-in and patient profile setup'),
      findsOneWidget,
    );
    expect(find.text('Secure sign-in'), findsOneWidget);
    expect(find.text('Service home'), findsOneWidget);
    expect(
      _assetFinder('assets/images/doctor_leandek_login.png'),
      findsWidgets,
    );
    expect(
      _assetFinder('assets/images/doctor_leandek_main.png'),
      findsWidgets,
    );
    expect(_assetFinder('assets/images/Login Page.png'), findsNothing);
    expect(_assetFinder('assets/images/Main Page.png'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tamayoz details pixel-fit its website frames',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final project = PortfolioData.englishProjects.firstWhere(
      (item) => item.emoji == '🌐',
    );

    await tester.pumpWidget(
      MaterialApp(home: ProjectDetailsScreen(project: project)),
    );
    await tester.pumpAndSettle();

    _expectFirstImageAspect(
      tester,
      'assets/images/Tamayous_website.png',
      1805 / 947,
    );
    _expectFirstImageAspect(
      tester,
      'assets/images/Tamayous_website_mobile .png',
      387 / 860,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Arabic details use Arabic specification copy',
      (WidgetTester tester) async {
    LocaleProvider.isArabic.value = true;
    addTearDown(() => LocaleProvider.isArabic.value = false);

    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: ProjectDetailsScreen(project: PortfolioData.arabicProjects.first),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('نظام تشغيل العيادة'), findsWidgets);
    expect(find.text('مواصفات المشروع'), findsOneWidget);
    expect(find.text('نطاق المشروع'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('all project details render without overflow',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final project in PortfolioData.englishProjects) {
      await tester.pumpWidget(
        MaterialApp(home: ProjectDetailsScreen(project: project)),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: project.title);
    }
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
    skipOffstage: false,
  );
}

void _expectFirstImageAspect(
  WidgetTester tester,
  String assetName,
  double expectedAspect,
) {
  final finder = _assetFinder(assetName);
  expect(finder, findsWidgets);

  RenderImage? renderImage;
  void collectRenderImage(RenderObject object) {
    if (object is RenderImage) {
      renderImage ??= object;
      return;
    }
    object.visitChildren(collectRenderImage);
  }

  collectRenderImage(finder.evaluate().first.renderObject!);
  expect(renderImage, isNotNull);

  final size = renderImage!.size;
  expect(size.width, greaterThan(0));
  expect(size.height, greaterThan(0));
  expect(size.width / size.height, closeTo(expectedAspect, 0.001));
}
