import 'dart:async';
import 'dart:math';
import 'package:asthma_alert/screens/health_data_screen.dart';
import 'package:asthma_alert/screens/resource/community_support.dart';
import 'package:asthma_alert/screens/resource/education_materials.dart';
import 'package:asthma_alert/screens/resource/inhaler_guides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// NotificationHelper class
class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showSmokeAlertNotification(int level) async {
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

    await _flutterLocalNotificationsPlugin.show(
      0,
      'High Smoke Level Detected!',
      'Smoke level is at $level%. Please take precautions.',
      notificationDetails,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize notification plugin
  await NotificationHelper.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smoke Detector App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/settings': (context) => const SettingsScreen(),
        '/asthma_action_plan': (context) => const AsthmaActionPlanScreen(),
        '/alerts': (context) => const AlertsScreen(),
        '/community_support': (context) => const CommunitySupportScreen(),
        '/education_materials': (context) => EducationMaterialsScreen(),
        '/inhaler_guides': (context) => const InhalerGuidesScreen(),
        '/health_data': (context) => const HealthDataScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double smokeLevel = 0.0; // Initial smoke level
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startSmokeSimulation(); // Start smoke level simulation
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel timer when the widget is disposed
    super.dispose();
  }

  // Simulates smoke level changes
  void _startSmokeSimulation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        smokeLevel = Random().nextDouble() * 100; // Random smoke level between 0 and 100
      });

      if (smokeLevel > 75) {
        NotificationHelper.showSmokeAlertNotification(smokeLevel.toInt());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smoke Detector Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmokeLevelDisplay(smokeLevel: smokeLevel), // Use SmokeLevelDisplay widget
            const SizedBox(height: 30),
            const Text(
              'Other Features (Navigation)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildFeatureCard(context, Icons.settings, 'Settings', () {
                    Navigator.pushNamed(context, '/settings');
                  }),
                  _buildFeatureCard(
                      context, Icons.book, 'Asthma Action Plan', () {
                    Navigator.pushNamed(context, '/asthma_action_plan');
                  }),
                  _buildFeatureCard(context, Icons.notifications, 'Alerts', () {
                    Navigator.pushNamed(context, '/alerts');
                  }),
                  _buildFeatureCard(
                      context, Icons.groups, 'Community Support', () {
                    Navigator.pushNamed(context, '/community_support');
                  }),
                  _buildFeatureCard(
                      context, Icons.school, 'Education Materials', () {
                    Navigator.pushNamed(context, '/education_materials');
                  }),
                  _buildFeatureCard(
                      context, Icons.medical_services, 'Inhaler Guides', () {
                    Navigator.pushNamed(context, '/inhaler_guides');
                  }),
                  _buildFeatureCard(
                      context, Icons.health_and_safety, 'Health Data', () {
                    Navigator.pushNamed(context, '/health_data');
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// SmokeLevelDisplay widget
class SmokeLevelDisplay extends StatelessWidget {
  final double smokeLevel;

  const SmokeLevelDisplay({Key? key, required this.smokeLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Smoke Level Monitoring',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
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
        Text(
          smokeLevel > 75
              ? 'High Smoke Levels Detected! Please take precautions!'
              : 'Smoke levels are normal.',
          style: TextStyle(
            fontSize: 16,
            color: smokeLevel > 75 ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }
}

// Placeholder screens for other features
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen')),
    );
  }
}

class AsthmaActionPlanScreen extends StatelessWidget {
  const AsthmaActionPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asthma Action Plan')),
      body: const Center(child: Text('Asthma Action Plan Screen')),
    );
  }
}

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
      ),
      body: const Center(
        child: Text('No alerts at this time.'), // Initial message
      ),
    );
  }
}