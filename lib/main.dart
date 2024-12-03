import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize flutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  runApp(MyApp(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.flutterLocalNotificationsPlugin})
      : super(key: key);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (snapshot.hasData) {
          return MaterialApp(
            home: HomeScreen(
                flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin),
            initialRoute: '/home',
            routes: {
              '/home': (context) => HomeScreen(
                  flutterLocalNotificationsPlugin:
                  flutterLocalNotificationsPlugin),
            },
          );
        }
        return MaterialApp(
          home: const LoginScreen(),
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
          },
        );
      },
    );
  }
}