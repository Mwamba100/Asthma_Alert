// lib/modules/smoke_detector.dart

import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'health_provider_notifier.dart';

class SmokeDetector {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final HealthProviderNotifier providerNotifier = HealthProviderNotifier();

  double smokeThreshold = 50.0; // Threshold for user alert
  final double criticalSmokeThreshold = 100.0; // Threshold for provider notification
  int smokeLevel = 0;

  SmokeDetector(this.flutterLocalNotificationsPlugin);

  // Initialize notification settings
  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Ensure you have an icon

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Simulate reading smoke level data
  Future<double> getSmokeLevel() async {
    return Random().nextInt(150).toDouble(); // Simulate smoke level between 0 and 150
  }

  // Periodically simulate smoke level changes
  void startSmokeLevelSimulation() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      smokeLevel = (await getSmokeLevel()).toInt();
      print("Smoke Level: $smokeLevel");
      await checkSmokeLevelAndAlert();
    });
  }

  // Check smoke level and send alerts if necessary
  Future<void> checkSmokeLevelAndAlert() async {
    if (smokeLevel > smokeThreshold) {
      await _triggerSmokeAlert(smokeLevel);
    }
    if (smokeLevel > criticalSmokeThreshold) {
      await providerNotifier.notifyProvider(
          "Critical smoke level detected: $smokeLevel");
    }
  }

  // Trigger a user alert
  Future<void> _triggerSmokeAlert(int level) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'smoke_alert_channel',
      'Smoke Alerts',
      channelDescription: 'Alerts for high smoke levels',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'High Smoke Level Detected',
      'Smoke level is $level, which is above the safe threshold.',
      notificationDetails,
    );
  }

  // Getter for current smoke level to expose it to other modules
  double getCurrentSmokeLevel() {
    return smokeLevel.toDouble();
  }
}
