// lib/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            criticalAlertsEnabled =
                settings['criticalAlertsEnabled'] ?? true;
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
          ),
        );
      }

      void _updateSettings(Map<String, dynamic> settings) {
        _firestoreService.updateSettings(userId, settings);
      }
    }
    ```

---

## **8. Implementing Firestore for Other Data (e.g., Health Data, Settings)**

Ensure each screen that requires data storage interacts with Firestore appropriately. Below are examples of integrating Firestore with other screens.

### **Example: Updating `smoke_level_screen.dart`**

Modify `SmokeLevelScreen` to store and retrieve smoke level data from Firestore.

```dart
// lib/screens/smoke_level_screen.dart

import 'package:flutter/material.dart';
import '../modules/smoke_detector.dart';
import '../services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SmokeLevelScreen extends StatefulWidget {
  final SmokeDetector smokeDetector;
  const SmokeLevelScreen({Key? key, required this.smokeDetector}) : super(key: key);

  @override
  _SmokeLevelScreenState createState() => _SmokeLevelScreenState();
}

class _SmokeLevelScreenState extends State<SmokeLevelScreen> {
  double _currentSmokeLevel = 0.0;
  bool _isAlertActive = false;
  final FirestoreService _firestoreService = FirestoreService();
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    widget.smokeDetector.startSmokeLevelSimulation();
    // Listen to smoke level updates
    widget.smokeDetector.smokeLevelStream.listen((level) {
      setState(() {
        _currentSmokeLevel = level;
        _isAlertActive = _currentSmokeLevel > widget.smokeDetector.smokeThreshold;
      });
      // Save smoke level to Firestore
      _firestoreService.addSmokeLevel(userId, _currentSmokeLevel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smoke Level Monitoring'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Current Smoke Level: ${_currentSmokeLevel.toStringAsFixed(2)} μg/m³',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: _currentSmokeLevel / 150, // Assuming 150 is the max level
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                  _currentSmokeLevel > 50 ? Colors.red : Colors.green),
            ),
            const SizedBox(height: 20),
            _isAlertActive
                ? Column(
                    children: [
                      const Text(
                        'Warning! High Smoke Level Detected!',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _resetAlert,
                        child: const Text('Acknowledge Alert'),
                      ),
                    ],
                  )
                : const Text(
                    'Smoke levels are safe.',
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _refreshSmokeLevel,
              child: const Text('Refresh Smoke Level'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<HealthData>>(
                stream: _firestoreService.getHealthData(userId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data.'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.data!;
                  if (data.isEmpty) {
                    return const Center(child: Text('No smoke level data available.'));
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final healthData = data[index];
                      return ListTile(
                        title: Text(
                            'Smoke Level: ${healthData.peakFlow} μg/m³, Time: ${healthData.timestamp}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetAlert() {
    setState(() {
      _isAlertActive = false;
    });
  }

  void _refreshSmokeLevel() {
    widget.smokeDetector.startSmokeLevelSimulation();
  }
}
