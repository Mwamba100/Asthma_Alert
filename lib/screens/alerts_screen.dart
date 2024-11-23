// lib/screens/alerts_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({Key? key}) : super(key: key);

  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  // Initialize the notifications plugin and settings for alerts
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    // Initialization settings for notifications (Android, iOS)
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('Notification payload: $payload');
        }
      },
    );
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'asthma_alerts', // Channel ID
      'Asthma Alerts', // Channel Name
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
      payload: 'Asthma Alert',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts & Notifications'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSmokeAlertSection(),
          _buildMedicationRemindersSection(),
          _buildSymptomTrackerAlertsSection(),
          _buildEnvironmentalTriggersSection(),
          _buildEmergencyContactsSection(),
        ],
      ),
    );
  }

  // Section for Smoke Level Alert
  Widget _buildSmokeAlertSection() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.smoke_free, color: Colors.redAccent),
        title: const Text('Smoke Level Alert'),
        subtitle: const Text(
          'Get real-time notifications if smoke levels reach a dangerous threshold in your environment.',
        ),
        trailing: Switch(
          value: true, // Replace with state variable
          onChanged: (value) {
            setState(() {
              // Toggle smoke level alert
              // Add functionality to enable/disable smoke detection notifications
            });
          },
        ),
      ),
    );
  }

  // Section for Medication Reminders
  Widget _buildMedicationRemindersSection() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.medical_services, color: Colors.blueAccent),
        title: const Text('Medication Reminders'),
        subtitle: const Text(
          'Set reminders to take your medication on time and track adherence.',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_alarm),
          onPressed: () {
            // Add functionality to create a new medication reminder
            // e.g., set reminder using local notification or calendar API
          },
        ),
      ),
    );
  }

  // Section for Symptom Tracker Alerts
  Widget _buildSymptomTrackerAlertsSection() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.health_and_safety, color: Colors.green),
        title: const Text('Symptom Tracker Alerts'),
        subtitle: const Text(
          'Receive alerts if symptoms like wheezing, coughing, or breathlessness are detected.',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            // Navigate to symptom tracker settings
          },
        ),
      ),
    );
  }

  // Section for Environmental Triggers Alerts
  Widget _buildEnvironmentalTriggersSection() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.warning, color: Colors.orange),
        title: const Text('Environmental Triggers Alerts'),
        subtitle: const Text(
          'Get notified if the air quality, pollen count, or humidity levels are high.',
        ),
        trailing: Switch(
          value: true, // Replace with state variable
          onChanged: (value) {
            setState(() {
              // Toggle environmental trigger alerts
              // Add functionality to enable/disable these notifications
            });
          },
        ),
      ),
    );
  }

  // Section for Emergency Contacts
  Widget _buildEmergencyContactsSection() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.contact_phone, color: Colors.red),
        title: const Text('Emergency Contacts'),
        subtitle: const Text(
          'Automatically notify emergency contacts in case of a severe asthma attack.',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            // Navigate to emergency contact settings page
          },
        ),
      ),
    );
  }
}
