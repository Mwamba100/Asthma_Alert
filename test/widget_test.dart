// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart'; // Import mockito
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Import for notifications

import 'package:asthma_alert/main.dart';

// Mock class for FlutterLocalNotificationsPlugin
class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a mock instance
    final mockFlutterLocalNotificationsPlugin = MockFlutterLocalNotificationsPlugin();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
        flutterLocalNotificationsPlugin: mockFlutterLocalNotificationsPlugin));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}