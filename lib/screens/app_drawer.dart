import 'package:flutter/material.dart';
import 'package:asthma_alert/screens/auth/login_screen.dart';
import 'package:asthma_alert/screens/auth/signup_screen.dart';
import 'package:asthma_alert/screens/resource/asthma_action_plan.dart';
import 'package:asthma_alert/screens/resource/community_support.dart';
import 'package:asthma_alert/screens/resource/education_materials.dart';
import 'package:asthma_alert/screens/resource/inhaler_guides.dart';
import 'package:asthma_alert/screens/resource/resource_screen.dart';
import 'package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart';
import 'home_screen.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key, required this.flutterLocalNotificationsPlugin})
      : super(key: key);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Asthma Alert App',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                      flutterLocalNotificationsPlugin:
                      flutterLocalNotificationsPlugin),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Sign Up'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignupScreen()),
              );
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Resources'),
            children: [
              ListTile(
                title: const Text('Asthma Action Plan'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AsthmaActionPlanScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Community Support'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CommunitySupportScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Education Materials'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EducationMaterialsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Inhaler Guides'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InhalerGuidesScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Resource Overview'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResourceScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.air),
            title: const Text('Smoke Level Monitoring'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/smoke');
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Alerts and Notifications'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/alerts');
            },
          ),
          ListTile(
            leading: const Icon(Icons.health_and_safety),
            title: const Text('Health Data'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/health_data');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}

