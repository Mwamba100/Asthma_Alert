import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'settings_screen.dart';
import 'resource/asthma_action_plan.dart';
import 'resource/community_support.dart';
import 'resource/education_materials.dart';
import 'resource/inhaler_guides.dart';
import 'alerts_screen.dart';
import 'health_data_screen.dart';
import 'resource/resource_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.flutterLocalNotificationsPlugin})
      : super(key: key);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double smokeLevel = 0.0; // Initial smoke level
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startSmokeSimulation(); // Start smoke detector simulation
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Simulate smoke level changes every 3 seconds
  void _startSmokeSimulation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        smokeLevel = Random().nextDouble() * 100; // Generate smoke level (0-100)
      });

      if (smokeLevel > 75) {
        _sendSmokeAlertNotification(smokeLevel.toInt());
      }
    });
  }

  // Send a notification when smoke level is high
  Future<void> _sendSmokeAlertNotification(int level) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'high_smoke_channel',
      'High Smoke Alert',
      channelDescription: 'Notifies the user when smoke levels are high',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await widget.flutterLocalNotificationsPlugin.show(
      0,
      'High Smoke Level Detected!',
      'Smoke level is at $level%. Please take precautions!',
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> homeOptions = [
      {'icon': Icons.health_and_safety, 'title': 'Health Data', 'screen': const HealthDataScreen()},
      {'icon': Icons.notifications, 'title': 'Alerts', 'screen': const AlertsScreen()},
      {'icon': Icons.library_books, 'title': 'Resources', 'screen': const ResourceScreen()},
      {'icon': Icons.warning, 'title': 'Asthma Action Plan', 'screen': const AsthmaActionPlanScreen()},
      {'icon': Icons.groups, 'title': 'Community Support', 'screen': const CommunitySupportScreen()},
      {'icon': Icons.school, 'title': 'Education Materials', 'screen': EducationMaterialsScreen()},
      {'icon': Icons.medical_services, 'title': 'Inhaler Guides', 'screen': const InhalerGuidesScreen()},
      {'icon': Icons.settings, 'title': 'Settings', 'screen': const SettingsScreen()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Smoke Detector Simulation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    value: smokeLevel / 100,
                    strokeWidth: 10,
                    color: smokeLevel > 75 ? Colors.red : Colors.blue,
                  ),
                ),
                Text(
                  '${smokeLevel.toInt()}%',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: smokeLevel > 75 ? Colors.red : Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Main Features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: homeOptions.length,
                itemBuilder: (context, index) {
                  final option = homeOptions[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => option['screen']),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(option['icon'], size: 40, color: Colors.blue),
                          const SizedBox(height: 8),
                          Text(option['title'], textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
