import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
    expect(find.text('01 / 10'), findsNWidgets(2));

    await tester.tap(find.byTooltip('Next project'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 450));

    expect(find.text('Sidaliti'), findsWidgets);
    expect(find.text('02 / 10'), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });
}
