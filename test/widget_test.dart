// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_protofolio/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyPortfolioApp());
    await tester.pump(const Duration(seconds: 2));

    // Verify that the app loaded correctly.
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Mobile layout keeps navigation reachable without overflow',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyPortfolioApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);

    final mainScrollView = find.byWidgetPredicate(
      (widget) => widget is SingleChildScrollView && widget.controller != null,
    );
    final controller =
        tester.widget<SingleChildScrollView>(mainScrollView).controller!;
    final initialOffset = controller.offset;

    await tester.tap(find.byIcon(Icons.menu_rounded));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);

    await tester.tap(find.text('Featured Work'));
    await tester.pumpAndSettle();

    expect(find.byType(Drawer), findsNothing);
    expect(controller.offset, greaterThan(initialOffset));
    expect(tester.takeException(), isNull);
  });
}
