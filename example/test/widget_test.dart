// Basic widget test for the flutter_nexi example app.
//
// See https://docs.flutter.dev/cookbook/testing/widget/introduction for more
// information about widget testing.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_nexi_example/main.dart';

void main() {
  testWidgets('renders the pay button', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.widgetWithText(AppBar, 'Plugin example app'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Pay'), findsOneWidget);
  });
}
