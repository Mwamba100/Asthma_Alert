import 'package:flutter/material.dart';
import 'package:asthma_alert/screens/app_drawer.dart';
import 'package:asthma_alert/screens/resource/asthma_action_plan.dart';
import 'package:asthma_alert/screens/resource/community_support.dart';
import 'package:asthma_alert/screens/resource/education_materials.dart';
import 'package:asthma_alert/screens/resource/inhaler_guides.dart';
import 'package:asthma_alert/screens/alerts_screen.dart';
import 'package:asthma_alert/screens/health_data_screen.dart';
import 'package:asthma_alert/screens/resource/resource_screen.dart';
import 'package:asthma_alert/screens/settings_screen.dart';
import 'package:asthma_alert/screens/smoke_level_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> homeOptions = [
      {'icon': Icons.smoke_free, 'title': 'Smoke Monitoring', 'screen': SmokeLevelScreen()},
      {'icon': Icons.notifications, 'title': 'Alerts', 'screen': const AlertsScreen()},
      {'icon': Icons.health_and_safety, 'title': 'Health Data', 'screen': HealthDataScreen()},
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
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
    );
  }
}
