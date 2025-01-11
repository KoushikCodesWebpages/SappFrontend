import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nav_bar/main.dart';

void main() {
  testWidgets('NavBarExample smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: NavBarExample()));

    // Verify the app shows the correct initial UI elements.
    expect(find.text("School Camp"), findsOneWidget);
    expect(find.text("Ajay Shanmugam"), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
