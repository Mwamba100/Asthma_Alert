// lib/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../modules/health_data.dart';
import '../services/firestore_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late String userId;
  bool notificationsEnabled = true;
  bool criticalAlertsEnabled = true;
  bool dataSyncEnabled = true;
  bool darkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _firestoreService.getSettings(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading settings.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data!.exists) {
            final settings = snapshot.data!.data()!;
            notificationsEnabled = settings['notificationsEnabled'] ?? true;
            criticalAlertsEnabled = settings['criticalAlertsEnabled'] ?? true;
            dataSyncEnabled = settings['dataSyncEnabled'] ?? true;
            darkModeEnabled = settings['darkModeEnabled'] ?? false;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('Enable Notifications'),
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                  _updateSettings({'notificationsEnabled': value});
                },
              ),
              SwitchListTile(
                title: const Text('Enable Critical Alerts'),
                value: criticalAlertsEnabled,
                onChanged: (value) {
                  setState(() {
                    criticalAlertsEnabled = value;
                  });
                  _updateSettings({'criticalAlertsEnabled': value});
                },
              ),
              ListTile(
                title: const Text('Notification Sound'),
                subtitle: const Text('Choose alert sound for notifications'),
                onTap: () {
                  // Open sound selection dialog
                },
              ),
              const Divider(),

              const Text(
                'Data & Privacy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('Enable Data Sync'),
                subtitle: const Text('Automatically sync health data with the cloud'),
                value: dataSyncEnabled,
                onChanged: (value) {
                  setState(() {
                    dataSyncEnabled = value;
                  });
                  _updateSettings({'dataSyncEnabled': value});
                },
              ),
              ListTile(
                title: const Text('Data Backup'),
                subtitle: const Text('Backup health data to secure storage'),
                onTap: () {
                  // Initiate data backup process
                },
              ),
              ListTile(
                title: const Text('Delete All Data'),
                subtitle: const Text('Remove all stored health data permanently'),
                onTap: () {
                  // Confirm and delete all data
                },
              ),
              const Divider(),

              const Text(
                'Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('Change Password'),
                onTap: () {
                  // Open password change dialog
                },
              ),
              ListTile(
                title: const Text('Manage Linked Healthcare Providers'),
                onTap: () {
                  // Open provider management screen
                },
              ),
              ListTile(
                title: const Text('Two-Factor Authentication'),
                subtitle: const Text('Enhance security with 2FA'),
                onTap: () {
                  // Open 2FA setup
                },
              ),
              const Divider(),

              const Text(
                'Device Integration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('Connect Bluetooth Device'),
                subtitle: const Text('Pair with compatible health monitoring devices'),
                onTap: () {
                  // Open device pairing interface
                },
              ),
              ListTile(
                title: const Text('Manage Connected Devices'),
                subtitle: const Text('View or disconnect paired devices'),
                onTap: () {
                  // Open connected devices list
                },
              ),
              const Divider(),

              const Text(
                'Display & Accessibility',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('Enable Dark Mode'),
                value: darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    darkModeEnabled = value;
                  });
                  _updateSettings({'darkModeEnabled': value});
                  // Optionally, toggle app theme here
                },
              ),
              ListTile(
                title: const Text('Font Size'),
                subtitle: const Text('Adjust font size for readability'),
                onTap: () {
                  // Open font size adjustment
                },
              ),
              ListTile(
                title: const Text('Enable Voice Assistance'),
                subtitle: const Text('Use voice commands for app navigation'),
                onTap: () {
                  // Enable voice assistance settings
                },
              ),
              const Divider(),

              const Text(
                'About',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('Privacy Policy'),
                onTap: () {
                  // Open privacy policy document
                },
              ),
              ListTile(
                title: const Text('Terms of Service'),
                onTap: () {
                  // Open terms of service document
                },
              ),
              ListTile(
                title: const Text('App Version'),
                subtitle: const Text('1.0.0'),
              ),
              const Divider(),

              Center(
                child: TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Log Out', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _updateSettings(Map<String, dynamic> settings) {
    _firestoreService.updateSettings(userId, settings);
  }
}
